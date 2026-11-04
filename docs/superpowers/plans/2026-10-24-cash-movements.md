# Cash Movements Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking. Implement and review inline without subagents; the user already selected that execution method.

**Goal:** Deliver Figma-based cash-in/out, private optional evidence, permanent corrections and accurate cash-session closing totals.

**Architecture:** Extend internal/cash with an immutable movement ledger and a unified read-only activity projection; preserve original receipt/refund data and frozen closings. Movement commands share the session lock with checkout/refunds/closing and use account-bound UUID recovery. Flutter renders authoritative totals through the existing authenticated client and retains one pending intent until resolved.

**Tech Stack:** Existing Go, Gin/Huma, GORM/PostgreSQL, checked math/big arithmetic, os.Root and local files; Flutter/Dart, Dio, Provider/MobX conventions, existing file picker, SVG assets and Poppins. No added dependency, Firebase requirement or payment provider.

**Spec:** [Cash movement design](../specs/2026-10-24-cash-movements-design.md).

Paths below are relative to the parent Dikasa workspace. Backend commands run in be-dikasa; Flutter commands run in mobile-dikasa.

## Global Constraints

- Preserve existing uncommitted work; work inline without subagents, commits, push, deployment or a new worktree.
- Keep one shared open till per outlet. Read access: active cashiers/managers in the current authenticated outlet.
- Create access: the opening cashier or a manager. Reverse access: opening cashier reversing their own original entry, or manager reversing any original entry; original session must still be open.
- Entries are permanent. One exact opposite reversal per original; never reverse a reversal, edit/delete history, or change closed-session totals.
- Required name: 1–120 Unicode characters; required reason: 1–500 Unicode characters. Trim those text fields before hashing/validation.
- Movement amount: whole Rupiah 1..9007199254740991; every aggregate output bounded to +/-9007199254740991.
- Manual outflow, including reversing a cash-in, cannot exceed the locked current expected cash. Unsupported legacy balances refuse new manual writes.
- Expected cash = opening + original cash paid_amount-change_amount - session-local cash refunds + manual inflow - manual outflow.
- Sales reports keep their sales definitions. Bank deposits affect the drawer; no expense/profit accounting, customer management or automated bank transfers.
- Old frozen summaries retain original totals; missing movement fields mean zero. Do not rewrite historical closing JSON or backfill movement records.
- Evidence: optional actual PNG/JPEG, max 3 MiB, max4096 pixels per axis/16 million pixels; private authenticated outlet-scoped reads and generated confined local filenames.
- Preserve checkout/cart variations, saved-order identity, cash closing and existing account settings. Reject stale replies by session generation, including re-login to the same account.
- An uncertain command keeps its original actor/session/body/UUID/evidence bytes; do not retarget a newer till or silently discard it. Block conflicting checkout/closing operations while unresolved.
- Use /dikasa/v1 APIs, exact Figma assets stored locally, source frame/asset manifests, dated feature history and synchronized OpenAPI/Bruno/ERD.
- Test writes use disposable temporary PostgreSQL schemas/directories. Keep port8081 running; no real movement, refund, sale, account mutation or real till closure for smoke tests.
- After verification, apply only tested additive migration000015 if that number remains free, with unchanged-existing-data checks.

## Review Focus

1. Two simultaneous outflows must not both spend the same balance, and a movement cannot arrive after closure: Task 3 database races.
2. A movement and its reversal have zero net value but must invalidate an old close preview: Tasks 1 and 3 hash tests.
3. A lost response followed by session closure/new opening must recover the original outcome without creating a new withdrawal: Tasks 3 and 5.
4. Evidence can leak through a public image route, filename traversal or stale UI response after logout: Tasks 2, 4 and 5 test denial and generation guards.
5. Historical frozen JSON lacks new fields, and overnight sessions cross report dates: Tasks 1, 4 and 6 preserve stored totals and session boundaries.

## Shared contracts and file ownership

The existing cash opening/current/list/detail/preview/close routes stay compatible. Add these authenticated routes; all paths below are relative to /dikasa/v1:

| Method | Path | Contract |
| --- | --- | --- |
| GET | /cash-sessions/{session_id}/activity?page=1&page_size=20 | data:{session,totals,capabilities,events}, meta:{page,page_size,total}; page_size max100 |
| POST | /cash-sessions/{session_id}/movements | multipart request_id,kind(in/out),name,amount,reason,optional proof; 201 data:MovementRecord, including exact replay |
| GET | /cash-sessions/{session_id}/movements/by-request/{request_id} | recover current actor's immutable successful record; 404 is not proof a pending write failed |
| GET | /cash-sessions/{session_id}/movements/{movement_id} | data:{movement,can_reverse,reversed_by_id}; scoped detail |
| POST | /cash-sessions/{session_id}/movements/{movement_id}/reverse | JSON request_id,reason; 201 data:opposite MovementRecord |
| GET | /cash-sessions/{session_id}/movements/{movement_id}/proof | validated binary image; private,no-store,nosniff; auth/outlet/movement checks before file access |

MovementRecord carries id, session_id, outlet_id, request_id, created_by/name snapshot, created_at, kind, amount, name, reason, reverses_id and has_proof. Do not expose object paths, hashes or filesystem errors. Keep dynamic can_reverse/reversed_by_id outside the immutable create/replay response. Actor-scoped recovery must match the original request's current actor.

Activity events have stable namespaced IDs (opening/session, sale/id, refund/id, movement/id), kind, direction, amount, name, reason, occurred_at, actor reference/display label and source ID. Manual actor names are snapshots; older sale/refund names use available source data and must not be presented as invented historical snapshots. Sort ascending occurred_at, then namespaced ID; server timestamps, not user backdating. Totals cover the full session, independently of the visible page.

CashFlowTotals contains opening, cash_sales, cash_refunds, cash_in, cash_out, total_in, total_out, expected_cash, movement_count. total_in=opening+cash_sales+cash_in; total_out=cash_refunds+cash_out. Explain that recorded correction entries participate in gross inflow/outflow cards.

## Task 1: Extend reconciliation calculation and immutable storage schema

**Files:** Create be-dikasa/internal/cash/movement.go, movement_test.go; modify reconciliation.go and reconciliation_test.go. Create migrations/000015_create_cash_movements.{up,down}.sql and migrations/cash_movements_test.go; update docs/architecture/DIKASA.drawio only when the schema is implemented.

**Interfaces:** MovementActivity is canonical close-hash input; Activity.Movements []MovementActivity. ReconciliationSummary gains CashIn/CashOut int64 and MovementCount int with snake_case JSON. Extend Summarize and BuildClosePreview; preserve nil/empty compatibility for legacy closing JSON. CashFlowTotals derives from ReconciliationSummary through FlowTotals(summary) (CashFlowTotals,error).

- [ ] Write failing TestMovementReconciliationExact and TestMovementPreviewChangesAtZeroNet: opening100000 + retained cash50000 - cash refund10000 + in20000 - out30000 => expected130000, total_in170000, total_out40000; adding a same-amount reversal restores its original net value but changes the preview hash. Noncash activity does not enter drawer totals.
- [ ] Add failing cases for duplicate movement IDs, invalid directions, zero/negative/unsafe amounts, aggregate overflow and missing old JSON fields. Assert old frozen summary expectations remain unchanged and zero movement fields parse safely.
- [ ] Run `go test ./internal/cash -run 'Movement|Reconciliation'`; observe the expected new failures, then implement checked totals/canonical ordering without altering existing receipt/refund allocation.
- [ ] Create cash_movements with UUID identity; session/outlet composite FK referencing the existing unique session pair; actor/name snapshot; kind/amount/name/reason; server timestamp; request UUID/payload SHA-256; optional proof key/MIME/hash/size; nullable reverses_id. Add unique(outlet_id,request_id), unique(id,cash_session_id,outlet_id), scoped self-FK for reversal, unique(reverses_id), non-self and positive/length/all-or-none-proof checks. Index session/time/id and outlet/request lookup. Reversal opposite amount/type and open status are checked under repository locks in Task 3.
- [ ] Run migration syntax/up/down in temporary schemas, `go test ./internal/cash ./migrations`, and confirm existing cash tests still pass. Never run down on the app schema.

## Task 2: Add a private proof storage boundary

**Files:** Create be-dikasa/internal/shared/imagefile/{validate,validate_test}.go; adapt internal/user/avatar_validation.go to the shared implementation while retaining its error contract. Create internal/cash/{movement_proof,movement_proof_test}.go. Modify internal/config/{config,config_test}.go and .env.example only for proof-directory configuration.

**Interfaces:** imagefile.Validate(Upload,Policy) (Image,error) returns validated bytes/MIME/canonical extension/SHA-256. Preserve the avatar policy (3 MiB,4096 per axis,16MP) and existing avatar errors via a small adapter. MovementProofStore exposes Save(context.Context,string,string,imagefile.Image)(ProofObject,error), Read(context.Context,string)([]byte,string,error), Delete(context.Context,string) error; LocalMovementProofStore additionally Close() error. Config.CashProofDirectory reads CASH_PROOF_DIRECTORY, falling back to LOCAL_IMAGE_DIRECTORY/cash-proofs in local-image mode. When no local proof directory is configured, manual text movements still work and can_upload_proof=false; future private Firebase adapter is outside this delivery.

- [ ] Write failing boundary tests for valid PNG/JPEG, three-MiB bounds, spoofed MIME/extensions, corrupt files, excessive decoded dimensions, generated names, traversal/symlink attempts, bounded reads and missing files. Run `go test ./internal/shared/imagefile ./internal/cash -run Proof` and observe failures.
- [ ] Implement validated byte preservation, os.Root confinement, generated UUID filenames/exclusive writes and lifecycle close. Store outside public product/avatar namespaces. Tests must assert uploaded bytes are unchanged and that store keys cannot become caller-supplied filesystem paths.
- [ ] Extract only the existing avatar validation rule into the shared boundary; rerun `go test ./internal/user ./internal/shared/imagefile ./internal/cash` to prove no avatar regression. Do not refactor product-image policy, which has different dimension limits.
- [ ] Add cleanup tests: known DB refusal removes an unreferenced new proof, an uncertain commit checks references before deleting, and DB unavailability retains a possible orphan. Local media migration/backup/orphan limits must be documented.

## Task 3: Implement locked, idempotent movement commands and activity queries

**Files:** Create be-dikasa/internal/cash/{movement_repository,movement_service,movement_activity}.go plus movement_service_test.go and movement_postgres_test.go. Modify reconciliation_repository.go to read movements into the same snapshot; extend reconciliation_postgres_test.go.

**Interfaces:** MovementService exposes Create(ctx,actorID,sessionID string,command MovementCommand)(MovementRecord,error), Reverse(ctx,actorID,sessionID,movementID string,command ReversalCommand)(MovementRecord,error), Activity(ctx,actorID,sessionID string,page,size int)(ActivityPage,error), Detail(ctx,actorID,sessionID,movementID string)(MovementDetail,error), ByRequest(ctx,actorID,sessionID,requestID string)(MovementRecord,error), Proof(ctx,actorID,sessionID,movementID string)(ProofBytes,error). Dependencies: current ReconciliationAccounts, a narrow MovementRepository, ProofStore and injected clock. MovementCommand contains request UUID, kind/name/amount/reason and optional validated proof; ReversalCommand contains request UUID/reason.

- [ ] Write and run failing service tests for active/role/outlet enforcement, opener/manager creation, own-entry opener reversal versus manager-any reversal, disallowed reversal-of-reversal, closed/unsupported sessions, missing reason, zero/unsafe amount, exact replay/mismatched actor/body/session/photo hash, foreign IDs and unavailable proof capability.
- [ ] Implement command ordering: resolve current auth/outlet, validate/bound input and evidence; acquire outlet/request advisory transaction lock, lookup exact replay, lock target cash-session FOR UPDATE, re-check current role/opener and open status, read authoritative activity, validate withdrawal/reversal and persist. Reversal then locks the original entry in the same session; require opposite amount/type, one reversal and original.reverses_id=null. Store a new opposite record; do not update the original. Replay lookup precedes open-status refusal so a previously committed command remains recoverable after closure.
- [ ] Bind canonical SHA-256 to operation, actor, outlet, session, normalized body, original ID when reversing and evidence-content hash. Decode/hash before duplicate lookup; defer proof persistence until the new intent is confirmed. Rollback and safely clean staged files after known refusal; avoid deleting referenced files after uncertain commit. Persist/return the committed immutable record rather than doing a fallible post-commit reload.
- [ ] Add failing isolated PostgreSQL tests: two80000 withdrawals against100000 => one success/one insufficient-balance; movement/close race => either included in the frozen close or rejected; concurrent exact replays => one row; simultaneous reversal => one opposite row; same request with changed photo/body =>409; foreign session/reversal FK => refusal; rollback leaves no movement; old frozen closing JSON unchanged. Run them and observe relevant failures before finalizing repository behavior.
- [ ] Implement read-only activity under REPEATABLE READ: opening once plus original cash receipts, cash-method refund events and manual movements. Fetch page/count/full totals/capabilities consistently. For closed supported sessions use frozen summary totals and permanent event records; legacy unsupported closings display unavailable totals, not invented balances. No daily slicing of an overnight session.
- [ ] Extend readCloseSnapshot and close-preview hashing with canonical movement activity. Test new movement/reversal after preview => stale-close refusal, including zero-net correction; preserve replay/closing JSON compatibility and existing sale/refund locks.
- [ ] Run `go test ./internal/cash ./internal/payment ./internal/refund` and all isolated movement/reconciliation race tests using guarded loopback DIKASA_TEST_DATABASE_URL. All temporary schemas must be removed. No public-schema movement fixtures.

## Task 4: Expose authenticated API contracts and synchronized examples

**Files:** Create be-dikasa/internal/cash/{movement_handler,movement_routes,movement_handler_test}.go. Modify internal/server/{router,router_test}.go, cmd/api/main.go, cmd/openapi/main.go and api/openapi.yaml. Add six requests under api/bruno/cash-movements/ and update cash-sessions close/detail examples and docs/development/cash-reconciliation.md. Update the ERD's new table/constraints/relations in this task if not already completed with Task 1.

**Interfaces:** NewMovementHandler/NewMovementService/RegisterMovementRoutes follow existing cash constructors. Add server.Dependencies.MovementHandler and wire configured private local proof storage. Use the six Shared contracts routes. Following the existing binary export response pattern, Huma output for proof returns []byte with actual Content-Type and Cache-Control:private,no-store and X-Content-Type-Options:nosniff. No proof object key in JSON. Multipart requests are bounded to4 MiB before parsing.

- [ ] Write failing real-router tests for401/403/404 scoping, actual multipart fields/file handling, optional omitted proof, whole-Rupiah validation,201 replay,409 stale request/closed/insufficient cash,413 size,422 corrupt proof and private binary fetch. Assert direct public product/avatar paths cannot serve cash proofs and unauthenticated proof requests cannot fetch bytes.
- [ ] Implement DTOs/handlers, capabilities and stable error codes: CASH_MOVEMENT_INVALID(422), CASH_MOVEMENT_FORBIDDEN(403), CASH_MOVEMENT_INSUFFICIENT_CASH(409), CASH_MOVEMENT_ALREADY_REVERSED(409), CASH_MOVEMENT_REQUEST_USED(409), existing closed/unsupported cash-session codes, and non-leaking storage413/422/502/503 errors. Return404 for foreign/missing scoped records. Derive IDs/actor/time from server context.
- [ ] Generate OpenAPI using `go run ./cmd/openapi -output api/openapi.yaml`. Add Bruno activity/create/detail/recovery/reverse/proof requests with placeholder credentials/UUIDs and assertions; annotate writes as disposable-account operations. Update existing close examples with movement totals and stale-preview behavior. Validate Draw.io XML and show actual FKs/nullability/checks.
- [ ] Run `go test ./internal/server ./internal/cash ./cmd/...`; inspect generated route/schema/media/error contracts and API examples against the router tests.

## Task 5: Connect Flutter service, guarded command state and shared mock ledger

**Files:** Create mobile-dikasa/lib/data/models/cash_movement.dart, data/services/cash_movement_service.dart and features/cash_movement/controller.dart. Modify data/models/cash_reconciliation.dart, data/services/pos_service.dart, core/network/{mock_cash_sessions,mock_api_interceptor}.dart and features/new_order/view_model.dart. Add tests under test/data and test/features/cash_movement/controller_test.dart.

**Interfaces:** CashMovementService(ApiClient) exposes activity(sessionId,{page=1}), detail(sessionId,movementId), byRequest(sessionId,requestId), create(sessionId,PendingCashMovement), reverse(sessionId,movementId,PendingCashReversal), proof(sessionId,movementId). Models validate all integer amounts and required IDs. Pending command values are immutable and own request UUID/normalized fields/copied proof bytes/name; rebuilding FormData for a replay must send identical bytes. Add CashMovementUncertainException and a typed error code. PosService.cashMovements exposes the service. Reuse the tested account photo picker boundary, with an injected picker for tests.

- [ ] Write failing client tests for multipart omission of optional proof, leading-zero normalization and decimal/exponent rejection for money, real envelopes/201/binary bytes, malformed write reply => uncertain, no retry with a fresh UUID, exact repeatable FormData, scoped recovery and non-leaking errors. New summary fields default0 only when absent in legacy frozen JSON; reject malformed present values.
- [ ] Run targeted Flutter tests; implement typed service and CashMovementController with auth.sessionGeneration guards. Listen for logout/re-login; invalidate cached rows/proofs/form state, and ignore old responses even when account ID is unchanged.
- [ ] Add failing controller tests for duplicate taps, dirty cancel, uncertainty, session changed during write, replay after close/new till, by-request404 retaining the pending command, explicit same-command retry and wrong-result UUID/session rejection. Retain the pending intent at a POS/account-owned boundary so view disposal cannot unlock unresolved checkout; do not persist proof/credentials/command in browser storage.
- [ ] Add the view-model acquisition/release gate for cash-movement writes and uncertainty. Keep it separate from the cash-closing owner so resolving a movement does not inadvertently release another operation's lock. Extend draftLocked/checkout guards without clearing the cart. Ensure pending original-session recovery remains reachable before any new withdrawal; surface the unresolved entry after returning to the menu.
- [ ] Extend MockCashSessions using its existing shared sale/refund/session ledger and request records. Match movement/reversal totals, permissions, close hash invalidation, exact replay, private in-memory proof bytes, legacy fields and closed-session immutability; do not maintain a second independent till balance. Run client/controller/mock tests plus existing cash/refund/checkout/account tests.

## Task 6: Build the Figma Kas Kasir view, entry/details and existing-close integration

**Files:** Create mobile-dikasa/lib/features/cash_movement/{view,activity_table,entry_dialog,detail_dialog,proof_view,design}.dart and docs/cash-movement-assets.json. Modify features/new_order/{view.dart,widgets/cash_sessions_dialog.dart,widgets/cash_closing_dialog.dart}, features/report/{main.dart,widgets/report_selector.dart}. Add view_test.dart and visual_test.dart under test/features/cash_movement/.

**Interfaces:** CashMovementView consumes controller, current user and existing cash-session service plus onClose/onLock callbacks. Keep ReportKind's four sales-report API values unchanged; ReportSelector accepts a separate onCashDrawer action and compact entry, and CashMovementView offers links back to the four sales reports. Existing callers without new callbacks remain valid.

- [ ] Re-read high-fidelity contexts/screenshots for Figma1:5074/1:5183/1:5357 using the design-to-code skill; reuse exact matching local assets, download missing originals and record source/sha256/natural dimensions. No sample avatar, drawn keyboard or temporary asset URL in runtime code.
- [ ] Write failing widget tests for no open session, session selection/history, full-session cards versus a paged list, create permission, required fields/photo preview, correcting own/manager entries, linked history, closed-session read-only state, busy/error/recovery flows and dirty form discard. Cover a session spanning WIB midnight and legacy missing summary fields.
- [ ] Implement the three original cards and ledger table with actual totals/date/time, add/close buttons, session selection and required-name/amount/type/reason form plus optional evidence panel. Correct copied Figma reservation text. Details show immutable actor/time/reason, original/reversal link, existing sale/refund references and authorized proof bytes. Clear proof bytes and pending view data on account change.
- [ ] Wire POS menu/report navigation/session detail without replacing the checkout route or clearing cart state. Tutup Kas reuses CashClosingDialog only after releasing a resolved movement owner; unresolved writes block it. Add cash-in/out lines to CashSummaryView for live/new frozen summaries, defaulting legacy fields safely. Refresh activity and totals after confirmed writes; sales report totals must remain unchanged.
- [ ] Test unchanged cart/variation/saved-order/till identity across navigation, plus write/close guard behavior. Capture desktop1340x800 and narrow390x844 list, dialog, details/proof and error states. Inspect against Figma and verify every static asset's slot/intrinsic geometry. Run focused/new and existing report/closing/checkout widget tests.

## Task 7: Final verification, additive local upgrade and accountability

**Files:** Update both READMEs, parent CHANGELOG.md/FEATURE_HISTORY.md/BACKLOG.md/CASH_MOVEMENTS_WORK_LOG.md; create CASH_MOVEMENTS_IMPLEMENTATION_LOG_2026-10-24.md. Keep optional screenshots/test evidence under ignored mobile-dikasa/build/cash-movements-*.

- [ ] Run `go test -p 1 ./...` and opted-in isolated PostgreSQL movement/migration/reconciliation/payment/refund tests. Read all outputs and investigate failures; print no DSN/credentials. Run `flutter analyze`, full Flutter tests and `flutter build web`. Record real pass/skip counts and limitations; do not infer completion from compilation alone.
- [ ] Inspect new screenshots and source-level permission/locking/recovery/proof boundaries inline. Verify generated OpenAPI/Bruno schemas, all local doc links, asset hashes/dimensions and Draw.io XML. Run `git --git-dir=.git --work-tree=. diff --check` in both repos; preserve prior uncommitted work.
- [ ] After temporary-schema migration tests pass, apply only additive000015 to guarded local PostgreSQL using psql single-transaction/ON_ERROR_STOP. Before/after checks must confirm existing users/outlets/receipts/refunds/items/cash sessions and stored closing JSON unchanged; new movement table starts empty and existing open till remains open. No live movement or close smoke mutation and no automatic backend restart.
- [ ] Write actual implementation history, schema/configuration/proof backup and unsupported Firebase-proof adapter details, command uncertainty/recovery limits, tests and review findings. Mark CASH-02 delivered only after working integration; keep expense accounting/customer work deferred. Link the dated log from changelog, feature history and both READMEs. Report restart steps and the Kas Kasir menu path.

## Plan self-review

Checked the approved design section-by-section: permissions, permanent corrections,
withdrawal bounds, session totals, zero-net preview invalidation, immutable legacy
closings, private proof handling, UUID recovery, same-account session generation,
POS locks/cart preservation, mock parity, Figma layouts and accountability each
have an owning task and explicit verification. Shared request/response names are
consistent across API and Flutter tasks. Implementation is complete locally on24 October2026. The work log and dated implementation history at the workspace root record actual tests, upgrades and limits; this approved step list is retained as the original plan.


## Execution outcome

All seven deliverables are complete locally. See CASH_MOVEMENTS_IMPLEMENTATION_LOG_2026-10-24.md
and CASH_MOVEMENTS_WORK_LOG.md in the workspace root for executed checks and
selected RED/GREEN cases. No subagents, commits, pushes or deployment occurred.
