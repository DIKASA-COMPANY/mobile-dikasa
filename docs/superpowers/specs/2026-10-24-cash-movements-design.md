# Cash-in / cash-out and till activity (CASH-02)

Date: 24 October 2026 (Asia/Jakarta).
Status: accepted for implementation planning when the user resumed cash movements on 24 October 2026; implemented locally with additive migration000015. See the workspace cash-movement implementation log for verification and limits.
User confirmed that **the opening cashier or a manager** may add cash movements.

## Intent and approach

Complete the shared outlet till with real cash additions, withdrawals and an audit
history using the existing Figma Kas Kasir screens. Extend the current Go cash
package and session reconciliation; Flutter renders server-calculated activity.
Work inline without subagents, preserve uncommitted work and retain per-feature
history. Local development continues without Firebase.

Use permanent, session-linked ledger records. This is the sensible fit for the
existing immutable cash closing and UUID-based recovery. An editable running
balance would lose the event history needed to explain a count; a general expense
accounting system is a separate backlog feature. Customer management stays deferred.

## Existing behavior and references

The backend has cash opening, current/history, preview and permanent closure, but
no manual cash-movement table or API. Expected cash currently includes opening cash,
retained original cash receipts and cash refunds paid by that session. Close locks
the cash-session row for UPDATE; sale/refund writers acquire SHARE locks. A closed
session's stored reconciliation JSON is returned without recalculation.

Figma file jgBLUfP6OXyxmErwgTjfIT, inspection session
5b9fdda5-41d9-4324-8c46-d4ad1ab77812. High-fidelity contexts and screenshots inspected:

| Screen | Frame |
| --- | --- |
| Kas Kasir list, totals and close/add actions | [1:5074](https://www.figma.com/design/jgBLUfP6OXyxmErwgTjfIT/aiuiuiu?node-id=1-5074) |
| Add movement, name/amount/note and evidence photo | [1:5183](https://www.figma.com/design/jgBLUfP6OXyxmErwgTjfIT/aiuiuiu?node-id=1-5183) |
| Cash-in/out type selection | [1:5357](https://www.figma.com/design/jgBLUfP6OXyxmErwgTjfIT/aiuiuiu?node-id=1-5357) |

Preserve the existing Figma blue headers, white/grey cards, orange actions,
right-side report navigation, table columns and evidence panel. Reuse exact local
assets where they match; download missing originals. Use the platform keyboard,
responsive form stacking and scroll rather than drawing the Figma sample keyboard.
Correct the copied label Informasi Reservasi to Informasi Transaksi Kas. Actual
account and financial data replace every sample name, date and amount.

## User-visible scope

Provide Kas Kasir from the POS menu and report navigation, plus an action from the
existing session detail. Default to the current open session; select prior sessions
for history. An overnight session stays one till, with its actual opening/closing
WIB date/time shown. Do not calculate a misleading partial-day drawer balance.

Show the three Figma cards and a paged, stable activity list:

- Total Kas Kasir: current expected cash, or the frozen closed-session expectation.
- Total Uang Masuk: opening cash + original cash receipts retained + manual inflows.
- Total Uang Keluar: cash refunds + manual outflows.

Opening cash appears once. Original receipts appear using paid_amount-change_amount;
refund events appear by their own paying session and return method. Show cash-only
activity here; existing noncash breakdown remains available in session details.
Display movement name, Masuk/Keluar, notes and accessible detail with actor/time,
receipt/refund reference, evidence and correction links. Only manual movements
have movement-correction actions; sales/refunds retain their established workflows.

Tambah opens the Figma form: required transaction name (1–120 Unicode characters),
positive whole-Rupiah amount, Uang Masuk/Uang Keluar selection, required reason/note
(1–500 Unicode characters), and optional PNG/JPEG photo evidence. Make the required
note clear in the label. Example purposes include additional float, supplies and
bank deposits; no expense categories or automatic expense/profit accounting yet.
Save/cancel, loading, validation, permission, closed-session and network states must
work. Warn before discarding a dirty form.

Tutup Kas reuses the existing count/preview/confirm flow and existing permission
rule. Refresh the displayed totals after a movement or correction. Keep the unpaid
cart, variations, saved-order identity and selected account intact during navigation.

## Permissions and audit corrections

Use the authenticated current outlet and active cashier/manager role. Any active
cashier/manager at that outlet may read session activity and authorized evidence.
The **opening cashier or a manager** may create movements. The server returns
capabilities for the selected session; client-side hiding is supplementary.

Proposed correction rule: the opening cashier may reverse their own manual entry;
a manager may reverse any manual entry in the outlet. Both require that the original
session is still open and a nonempty correction reason. The original record remains
unchanged; create one linked opposite movement with exactly the original amount.
The original actor/name/time/reason/evidence remain visible. Prevent a second
reversal and reversal of a reversal. Correcting an amount/type means reversing the
mistake, then recording the replacement. Never edit/delete financial history or
change a closed session. Return existing successful requests on exact replay,
including when the session has since closed.

The reversal rule was proposed in this design and included in the subsequent request to continue; it was not independently selected in the earlier permissions question. No new PIN override, staff role editor or manager-approval queue is included.

## Calculation, concurrency and historical compatibility

Expected cash = opening cash + retained original cash receipts - cash refunds
+ manual cash-in - manual cash-out. Linked reversals participate once as their
actual opposite ledger record; the net effect of a reversed entry is zero. Keep
movement totals separate from sales totals. A bank deposit reduces drawer cash;
it does not create an expense or reduce reported sales.

Bound money and aggregate outputs to +/-9007199254740991 using checked integer
arithmetic; movement amounts must be 1..9007199254740991. Proposed cash-out rule:
reject withdrawals above the current expected cash, including an outflow reversal
of a previous cash-in. A correction must not silently create an impossible drawer
balance. Explain the refusal and allow a manager to inspect the ledger; no negative
amount trick or count-discrepancy adjustment is introduced. Existing sale/refund
rules remain as approved; this new withdrawal check applies to manual outflows.

Every new movement/reversal locks the same session row FOR UPDATE before checking
open status, current permissions, expected balance and committing. Coordinate with
sale/refund SHARE locks and close UPDATE locks so simultaneous cash-outs cannot
both spend the same expected balance and a movement cannot slip into a closed till.
Use consistent lock ordering and a transaction for each command. Refuse new manual
writes when legacy activity cannot be reconciled rather than guessing a balance.

Include movement IDs/directions/amounts and immutable audit data in close-preview
activity hashing, so a movement or correction invalidates an earlier preview even
when its net amount is zero. Freeze cash_in, cash_out, movement_count and cash
breakdown in new closing summaries. Old frozen summaries retain original totals;
missing movement fields mean zero. No historical backfill/recalculation and no
rewriting earlier sales/refunds/closed-session JSON.

## Storage, API and recovery

Add an additive migration (next available number, currently 000015) for
cash_movements, with session/outlet FK scope, actor/name snapshot, in/out kind,
amount/name/reason, server UTC timestamp, request UUID/payload hash, optional proof
metadata and a unique reversal link. Enforce positive amounts and relevant
uniqueness/FKs/checks in PostgreSQL as well as the service. No live fixtures or
balances are written during verification.

Use /dikasa/v1, existing envelopes and explicit scoped routes for session activity,
movement creation, movement detail/request recovery, reversal and evidence reads.
Define the exact DTOs/paths in the implementation plan. Original sales/refunds and
opening cash are read from their source records, not copied into mutable duplicates.
A stable page and full-session totals must come from a consistent snapshot.

Generate one secure request UUID per user intent. Bind it to the account, outlet,
selected session, normalized body and evidence-content hash. Reusing it with a
changed command returns conflict; an exact replay returns the same successful
record without inserting again. After timeout, keep the original payload/target
and resolve or replay that intent. Never attach an uncertain old withdrawal to a
newly opened till. Block conflicting checkout/closing actions while a drawer
command outcome is unresolved. Account-generation guards must reject replies after
logout or re-login to the same account; do not expose previous-user form/evidence.

Evidence is optional, at most three MiB, actual PNG/JPEG, max4096 px per side and
16 million pixels. Reuse the validated image boundary without modifying originals.
Store generated filenames under a dedicated confined local cash-proof directory.
Serve evidence through an authenticated outlet-scoped binary endpoint with private
cache policy; Flutter fetches authorized bytes rather than sending a bearer token
in a URL. Keep evidence immutable with its event. Validate before persistence and
avoid deleting a referenced proof after an ambiguous DB commit. Document possible
orphan cleanup after partial failures. Do not put proof files under public product
or avatar routes. Keep a storage interface for a future private Firebase adapter;
this first delivery uses local proof storage and does not migrate cloud media.

## Verification and accountability

Write focused failing tests before product changes. Cover exact calculations,
zero/negative/overflow amounts, overdraw, ownership/outlet/inactive roles, immutable
history, single reversal, actor audit, UUID replay/mismatch and uncertain recovery.
Use isolated temporary PostgreSQL schemas to verify simultaneous withdrawals,
movement versus close/sale/refund races, stale previews, rollback, FK constraints
and preservation of old frozen summaries. Use temporary directories for proof
validation, authorized reads and filesystem confinement.

Flutter tests cover Figma forms, photo preview, entry/correction permissions,
loading/errors, duplicate taps, uncertain commands, same-account re-login, session
switches, updated closing totals, mock parity and cart preservation. Capture and
inspect desktop/narrow/list/dialog/error states using exact local asset metadata.
Run focused/full Go tests, Flutter tests/analyzer and a web build. Update generated
OpenAPI, Bruno examples, the Draw.io ERD, dated implementation/work logs, CHANGELOG,
FEATURE_HISTORY, BACKLOG and README guidance. Preserve the normal port8081 process.
Apply only the tested additive migration locally with unchanged-existing-data
checks; never close the real till or create real cash movements for smoke tests.
