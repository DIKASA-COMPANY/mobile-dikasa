# Account Settings Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking. Execute and review inline without subagents, as requested by the user.

**Goal:** Deliver Figma-based self-account profile editing, local profile photos, password changes and six-digit PIN setup/change without requiring Firebase.

**Architecture:** Extend the existing Go user service and partial-update API, retain the AvatarStore boundary and add local storage beside existing product media. Flutter uses a typed account service and guarded view model; successful profile updates replace the current session's user without replacing the checkout view or cart.

**Tech Stack:** Existing Go, GORM/PostgreSQL, Gin/Huma, bcrypt, os.Root; Flutter/Dart, Dio, Provider/MobX conventions, FilePicker, flutter_svg and Poppins. No new dependencies.

**Spec:** [Approved account-settings design](../specs/2026-10-24-account-settings-design.md).

Paths below are relative to the parent Dikasa workspace. Run backend commands in be-dikasa and Flutter commands in mobile-dikasa.

## Global Constraints

- Work inline, without subagents, commits or deployment. Preserve prior uncommitted changes.
- Scope: own profile, profile-photo upload/removal, password changes, initial PIN setup and subsequent PIN changes.
- Preserve checkout cart, saved orders and all existing features.
- Use authenticated /dikasa/v1 routes; derive account identity from authentication, never request-supplied user IDs.
- Username, role and assigned outlet are read-only. Omit unsupported subscription and notification controls.
- Profile fields: first/last name, phone, optional email, optional birth date, optional gender and optional personal address.
- Keep personal address separate from outlet address; migration 000014 adds only nullable users.personal_address, after confirming the number remains free.
- PINs contain exactly six digits. Verify the current PIN when one exists; verify the current password and require matching confirmation fields for credential changes.
- Respect bcrypt's 72-byte maximum and the existing eight-byte minimum for new passwords; do not trim or normalize secrets.
- Profile photos accept actual PNG/JPEG content, at most three MiB. Store generated filenames and keep local/Firebase storage selectable.
- Do not log or persist plaintext credentials on the client. Do not automatically retry credential mutations after ambiguous outcomes.
- Password changes retain existing JWT expiry behavior. Do not claim global session revocation.
- Verify configured auth mode before exposing password changes; local bcrypt updates must not masquerade as Firebase password updates.
- Use the existing Figma references and verified local assets; do not ship temporary Figma asset URLs.
- Do not modify the real local user's credentials/profile or create live sales for tests. Use temporary PostgreSQL schemas and temporary storage directories.
- Preserve the running backend on port 8081; apply only the tested additive migration to the local database during execution, without printing credentials.
- Update API documentation, Bruno, ERD and feature accountability files in the same feature.

## Review Focus

1. A late response after logout or re-login to the same account must not replace the newer session: generation guards and tests in Task 4.
2. Concurrent edits to different profile fields must not overwrite one another; competing credential changes must not both accept the same previous credential: Task 1 tests atomic repository writes.
3. A connection failure after a credential write can mean success; the form must clear secrets and report uncertainty without retrying: Tasks 4–5.
4. A small compressed image can have extreme decoded dimensions, and stored paths can be malicious: Task 2 tests bounded decoding and filesystem confinement.
5. Switching to Firebase authentication must not offer a password form that only changes the local hash; switching image storage must not silently claim old local files migrated: Tasks 3 and 6.

## Task 1: Complete the self-profile contract and safe writes

**Files:** Modify be-dikasa/internal/user/{entity,dto,handler,routes,service,settings,repository,repository_gorm}.go and their tests. Create internal/user/profile_settings.go, profile_settings_test.go and settings_postgres_test.go. Create migrations/000014_add_user_personal_address.{up,down}.sql and update migration tests.

**Interfaces:** GET/PATCH /users/me return existing fields plus role, outlet_name, date_of_birth (YYYY-MM-DD or null), gender_name, personal_address, has_pin and can_change_password. Add authenticated GET /users/me/genders returning {data:[{id,name}]}. Multipart PATCH accepts date_of_birth, gender_id and personal_address. Omitted fields remain unchanged; empty optional fields clear their value. Keep existing constructors/callers compatible through service options.

- [ ] Write failing handler/service tests for profile mapping without hashes, auth-required responses, immutable role/outlet/username, unknown gender, invalid/future calendar birth date, cleared optional fields and omitted-field preservation. Inject a clock for birth-date validation; use WIB calendar dates.
- [ ] Run `go test ./internal/user ./migrations`; confirm the new assertions fail for missing behavior before product edits.
- [ ] Add the nullable personal_address migration, profile DTO/form fields, authenticated reference-data route and service validation. Limit personal_address to 1000 Unicode characters and trim profile text, never credentials. Load role/outlet/gender for profile responses. Return server capability can_change_password from configured authentication mode.
- [ ] Add failing isolated-schema tests for a valid existing gender FK, invalid gender rejection, clearing optional fields, unchanged outlet address and two concurrent disjoint profile patches. Add competing old-password/PIN tests expecting exactly one successful replacement.
- [ ] Make profile writes update only supplied fields. Serialize dependent photo/reference changes under a row lock; return the committed profile and replaced avatar reference. Use compare-and-swap against the previously verified hash for credential writes, including null PIN setup. Return a stable conflict response when the verified value changed.
- [ ] Run user/migration unit tests and the isolated PostgreSQL cases using the existing opt-in DB-test pattern. Assert migration up/down in temporary schemas; never run down against the local application schema.

## Task 2: Supply validated local profile photos

**Files:** Create be-dikasa/internal/user/avatar_local.go and avatar_local_test.go. Modify avatar_firebase.go and avatar_firebase_test.go; create avatar_validation.go and avatar_validation_test.go. Modify cmd/api/main.go, internal/server/router.go and router_test.go.

**Interfaces:** NewLocalAvatarStore(directory, baseURL string) (*LocalAvatarStore, error); the store implements AvatarStore, http.Handler and Close() error. Add server.Dependencies.AvatarImages. Serve GET/HEAD /dikasa/v1/avatar-images/{filename} only in local-storage mode. Use a dedicated avatars subdirectory under configured LocalImageDirectory.

- [ ] Write failing storage tests for valid PNG/JPEG, exact three-MiB bound, forged MIME/extensions, broken images, excessive dimensions, traversal/symlink attempts, unsupported HTTP methods and missing-file behavior. Pin maximum width/height 4096 and maximum pixel count 16 million before decoding; apply the same validator to local and Firebase avatars.
- [ ] Run `go test ./internal/user -run Avatar`; observe expected failures.
- [ ] Implement bounded validation, generated canonical UUID filenames, exclusive writes and os.Root confinement following the existing product-image store. Serve correct MIME/nosniff with no directory listing; document that random avatar URLs are publicly readable, consistent with current Firebase URLs.
- [ ] Wire the local store and route without changing product-media behavior. Ensure local deletion cannot delete Firebase object paths, or vice versa, after a provider switch.
- [ ] Add failure/race tests for DB failure after upload, replacement/removal cleanup and concurrent photo replacement. Delete only replaced committed files; never the current winning avatar. Treat failed old-file cleanup as a documented orphan, without falsely failing a committed profile save.
- [ ] Run `go test ./internal/user ./internal/server ./internal/catalog` and confirm all pass.

## Task 3: Enforce credential capabilities and synchronize API examples

**Files:** Modify be-dikasa/internal/user/{settings,handler,routes}.go and account_settings_test.go; cmd/api/main.go; cmd/openapi/main.go; api/openapi.yaml; api/bruno/users/{profile,update-profile,change-pin,change-password}.bru. Create api/bruno/users/genders.bru. Update docs/architecture/DIKASA.drawio.

**Interfaces:** Add WithPasswordChangesAllowed(bool) ServiceOption with backwards-compatible local behavior; runtime explicitly supplies configuration.AuthMode == "local". Unsupported password changes return 503 with a stable capability error before a hash write. PIN remains a local operational credential in either mode.

- [ ] Write and run failing tests for disabled password capability, zero writes in that mode, 204 success, wrong old credential, reuse, confirmation mismatch, leading-zero PINs and multibyte passwords over 72 bytes. Keep hashes/secrets out of all response assertions and logging.
- [ ] Implement the capability check and consistent validation/error mapping, preserving current JWT behavior. Confirm real client/server errors distinguish rejected mutations from uncertain transport outcomes.
- [ ] Generate OpenAPI using `go run ./cmd/openapi -output api/openapi.yaml`. Update Bruno examples/assertions for all changed routes and add genders/optional-field-clearing examples with placeholder variables only.
- [ ] Add personal_address to the existing users ERD representation, preserve relationships and existing diagram pages, and verify the Draw.io XML parses. Document the generated public avatar route and storage/auth capability behavior.
- [ ] Run `go test ./internal/user ./internal/server ./cmd/...`; inspect generated contract and Bruno paths/envelopes against handler tests.

## Task 4: Connect typed Flutter account data and session refresh

**Files:** Create mobile-dikasa/lib/data/models/account_profile.dart and lib/data/services/account_service.dart. Modify lib/data/models/user.dart, lib/data/repositories/auth_repository.dart and existing dependency wiring in lib/main.dart as needed. Create lib/core/network/mock_account.dart; modify mock_api_interceptor.dart. Add test/data/account_service_test.dart, account_session_test.dart and mock_account_test.dart.

**Interfaces:** AccountProfile.fromJson(Map<String,dynamic>), GenderOption.fromJson(Map<String,dynamic>); AccountService(ApiClient) exposes Future<AccountProfile> profile(), Future<List<GenderOption>> genders(), Future<AccountProfile> updateProfile(Map<String,String> fields, {Uint8List? avatarBytes, String? avatarFilename}), Future<void> changePIN(String current, String next, String confirmation), Future<void> changePassword(String current, String next, String confirmation). Add CredentialOutcomeUncertainException. AuthRepository exposes a monotonically increasing sessionGeneration and bool replaceUser(User user, {required int expectedGeneration}); increment generation on every login attempt/logout.

- [ ] Write failing service/session tests for real envelopes, multipart fields and file MIME, clearing versus omitted values, 204 responses, malformed payloads, duplicate-data errors, no credential retry and rejected stale profile replacement, including re-login to the same user ID.
- [ ] Run `flutter test test/data/account_service_test.dart test/data/account_session_test.dart` and confirm failures before implementation.
- [ ] Implement typed parsing and API error handling through existing Dio/ApiException conventions. Treat network timeout/disconnect and server errors after sending credentials conservatively as uncertain. Keep profile secrets out of User and all logs; verify Dio logging does not include multipart/JSON secrets.
- [ ] Extend User compatibly with optional avatar/profile data; retain existing required constructor parameters and mock login behavior. Publish refreshed identity through the repository's existing consumers or a narrowly scoped notifier; do not recreate checkout or replace its order state.
- [ ] Implement per-mock-account profile/credential state, genders and capability flags with the same endpoint rules. Keep mock secrets in memory only and test subsequent mock login using the changed password.
- [ ] Run the new data tests plus existing login/backend-contract tests; assert late response/account switching cannot leak another account's profile.

## Task 5: Build Figma profile and credential forms

**Files:** Create mobile-dikasa/lib/features/account/{view,view_model,profile_form,credential_forms,profile_photo}.dart and matching test/features/account tests. Modify lib/features/new_order/view.dart and view_model.dart only for navigation/identity refresh. Create docs/account-assets.json when assets are added/reused.

**Interfaces:** AccountSettingsView takes AccountService and AuthRepository; AccountSettingsViewModel owns profile loading, gender choices, dirty state and independent profile/PIN/password mutation state. Navigation enters from the existing POS menu and returns to the same checkout instance.

- [ ] Read the approved Figma contexts again through the Figma design-to-code workflow as needed. Verify existing owner_settings icons against reference assets; download only missing static assets, then record node IDs, dimensions and hashes. Do not use sample avatars as user data.
- [ ] Write failing view-model/widget tests for read/edit/cancel/save, optional field clearing, date/gender selection, photo removal/validation, initial versus existing PIN, password capability disabled, validation/mismatched confirmation, loading/error/retry and uncertain credential outcomes.
- [ ] Run `flutter test test/features/account`; confirm expected missing behavior.
- [ ] Implement the approved cards, photo panel and individual submit buttons. Use explicit first/last-name labels, real readonly role/outlet values, accessible obscured PIN/password fields and local byte-length validation. Clear all secret controllers on success, uncertainty, disposal and account change.
- [ ] Guard every async response with session generation and widget lifetime; prevent simultaneous conflicting mutations. Confirm discard before leaving dirty profile edits. Present server validation without losing entered non-secret profile fields.
- [ ] Add the settings menu action using the existing payment/draft-lock navigation guard. Refresh the header when returning; preserve the same cart, selected variations, opening till and saved-order identity. Add a checkout-navigation regression test asserting those values remain identical.
- [ ] Run account widget/view-model tests and existing checkout/login tests. Capture desktop 1340x800 and narrow 390x844 renders using the existing visual-test harness; inspect clipping, keyboard/scroll behavior, empty avatar and credential success/error states against Figma.

## Task 6: Verify the integrated feature and write accountability records

**Files:** Update both READMEs, parent CHANGELOG.md, FEATURE_HISTORY.md and BACKLOG.md. Create ACCOUNT_SETTINGS_IMPLEMENTATION_LOG_2026-10-24.md in the parent workspace; retain test evidence in ignored build output. Update the spec/plan status only as work is actually completed.

- [ ] Run `go test -p 1 ./...`, the isolated-schema account/migration tests and appropriate existing local-auth suites. Use working local DSN privately with loopback guards; redact credentials from output. Never alter real credentials to perform a smoke test.
- [ ] Run `flutter analyze`, `flutter test` and `flutter build web`; investigate regressions and inspect desktop/narrow screenshots. Record optional-test skips and any checks not run.
- [ ] Verify OpenAPI/Bruno consistency, local documentation links, Draw.io XML and asset manifest paths/hashes. Run `git --git-dir=.git --work-tree=. diff --check` in both repositories.
- [ ] After migration tests pass, apply only additive migration 000014 to the existing local schema with the established migration runner. Confirm the column exists and existing user/account/outlet data is unchanged. Keep backend8081 running and tell the user a restart is needed for the new API.
- [ ] Document actual behavior, testing, limitations, local photo backup/migration requirements and password/JWT behavior. Add the feature history entry; keep customer management and cash movements in backlog. Do not claim Firebase account-password management or automatic media migration.
- [ ] Review the completed diff against every spec section inline, fix findings, then report changed behavior, evidence and the exact restart/testing steps to the user.

## Plan self-review

Checked the plan against all approved design sections: profile fields and clearing,
identity permissions, local/Firebase photos, credential capabilities, concurrency,
uncertain outcomes, session/cart preservation, Figma adaptation, mock parity,
tests and accountability documentation each map to an owning task above. Review
Focus items have corresponding test steps. Implementation completed locally on 24 October 2026. See ACCOUNT_SETTINGS_IMPLEMENTATION_LOG_2026-10-24.md and ACCOUNT_SETTINGS_WORK_LOG.md at the workspace root for actual execution, selected RED/GREEN observations, final test evidence and limitations.


## Execution outcome

All six deliverables are implemented locally. The step list above retains the
approved plan; the work log records what ran rather than treating this plan as
verification evidence. No subagents, commits, push, merge or deployment occurred.
