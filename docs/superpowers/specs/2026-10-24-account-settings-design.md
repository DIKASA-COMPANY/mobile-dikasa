# Account settings: profile, password and PIN

Date: 24 October 2026 (Asia/Jakarta).
Status: approved by the user on 24 October 2026. Implemented locally; see the workspace account-settings implementation log for verification and limitations.

## Purpose and scope

Let the signed-in cashier or manager maintain their own profile and credentials
from the existing Figma settings designs. Continue supporting local authentication
without Firebase. Work inline, without subagents, commits or deployment. Preserve
the checkout cart and all existing features.

Deliver profile viewing/editing, profile-photo upload/removal, password changes,
and initial PIN setup or subsequent PIN changes. Customer management and cash
movements remain separate backlog items.

## Approach and current evidence

Extend the existing Go user service and connect it through typed Flutter models,
an account-settings client and view model. The backend already exposes GET/PATCH
`/dikasa/v1/users/me` and PATCH `/users/me/pin` and `/users/me/password`.
It already checks current credentials, rejects reuse and stores bcrypt hashes.
Avatar storage currently defaults to disabled without Firebase. Flutter currently
has no settings feature, although several settings icons are already present.

This is the recommended approach because the API and storage abstractions already
exist. Duplicating account endpoints creates conflicting behavior; requiring
Firebase conflicts with the established local-development setup. Reuse matching
local assets after checking them against the Figma references.

## Design references and screen behavior

Figma file: jgBLUfP6OXyxmErwgTjfIT. Inspection session:
26581f89-9f39-4144-9418-61d8262a7cfd.

- [Profile](https://www.figma.com/design/jgBLUfP6OXyxmErwgTjfIT/aiuiuiu?node-id=1-14248)
- [Edit profile](https://www.figma.com/design/jgBLUfP6OXyxmErwgTjfIT/aiuiuiu?node-id=1-14876)
- [Account settings](https://www.figma.com/design/jgBLUfP6OXyxmErwgTjfIT/aiuiuiu?node-id=1-14360)
- [Edit account and credentials](https://www.figma.com/design/jgBLUfP6OXyxmErwgTjfIT/aiuiuiu?node-id=1-14627)

Follow the blue section headers, pale form cards, orange save actions, profile
photo panel, Poppins typography and existing app navigation. Stack fields and
photo panel on narrow screens; allow the credential sections to scroll.
Show the current account's actual information rather than Figma sample values.
Use profile terminology that does not imply a cashier owns the outlet.

Profile editing supports first/last name, phone, optional email, optional birth
date, optional gender and optional personal address. Keep name components explicit
to avoid silently splitting a person's full name. Date of birth and gender already
have database fields; add a nullable personal address in migration 000014 if still
available at implementation time. An outlet's address must never be overwritten.
Expose valid gender choices from server reference data; do not hard-code UUIDs.
Allow clearing optional fields through an explicit partial-update contract.

Username, role and assigned outlet are read-only. Omit the unsupported subscription
and notification controls. Save and cancel apply to profile edits only; PIN and
password changes have their own buttons and validation. Warn before discarding
unsaved profile edits. Show loading, validation, duplicate phone/email, unauthorized,
network-error and success states without false success messages.

## Backend and storage

Add profile response fields for role/outlet display names, birth date, gender,
personal address and a non-secret has_pin boolean. Never return credential hashes.
Enforce self-account authorization through the authenticated identity, never a
client-supplied account ID. Keep current outlet/role permissions unchanged.

Add local avatar storage behind the existing AvatarStore interface. Reuse the
established local-media configuration and serving pattern with a distinct avatar
namespace. Validate actual PNG/JPEG content and the existing three-MiB limit;
bound image decoding, reject unsafe paths, generate filenames and clean up a new
file when the database write fails. Preserve Firebase storage support and document
that local images need to be copied when switching storage providers later.

Inspect existing concurrent profile/credential writes and prevent lost updates
where necessary. Profile patches must preserve fields omitted by the caller.
Credentials must not be logged or persisted on the client. Keep all validation on
the backend as well as the frontend, including bcrypt's byte-length limit.

## Credentials and session behavior

PINs contain exactly six digits. Initial setup needs no old PIN; replacing one
requires the current PIN. Both changes require matching confirmation fields.
Password changes require the current password, a new password and confirmation.

Update the local account password only in supported local-auth mode. Verify the
configured authentication mode before exposing credential actions: do not suggest
that updating a local bcrypt hash changes a Firebase-managed password.

Successful profile edits refresh the signed-in user and visible identity without
logging out or losing an unpaid order. A successful password change clears the
form and tells the user to use the new password at their next login; existing JWT
sessions retain their current expiry behavior. Do not claim global revocation.
Guard asynchronous results against logout/account switching. Disable duplicate
submissions. For an ambiguous credential timeout, explain that it may have applied,
clear secrets and avoid automatic retries.

## Verification and accountability

Use focused Go service/handler/storage tests and isolated PostgreSQL tests for
partial updates, ownership, constraints and credential changes. Never change the
real local user's password, PIN or profile during verification. Test Flutter form
validation, error/success states, initial versus existing PIN, profile refresh,
account switching and checkout-cart preservation. Support the existing mock mode.

Run Go tests, Flutter tests/analyzer and a web build. Capture desktop and narrow
screen renders and compare with the inspected Figma references. Update OpenAPI,
Bruno examples and ERD for changed contracts/schema, then add the dated feature
log and update CHANGELOG.md, FEATURE_HISTORY.md and BACKLOG.md. Record actual test
results and any limitations rather than marking this proposal as implemented.
