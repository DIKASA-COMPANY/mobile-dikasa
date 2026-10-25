# Cash-session closing and reconciliation

Date: 24 October 2026 (Asia/Jakarta).
Status: approved and implemented locally on 24 October 2026. See the workspace cash-closing implementation log for verification and limits.
User approved the feature and selected closure by the opening cashier or a manager.

## Intent and scope

Complete the existing opening/sales/refund workflow with counted-cash reconciliation,
permanent closure and a retrievable session summary. Keep one shared open till per
outlet. Work inline, no subagents, preserve uncommitted work and maintain dated logs.

Expected cash = opening cash + cash receipts retained - cash refunds paid out.
Use original cash receipt paid_amount minus change_amount, irrespective of a later
partial/full refund status. Refunds are subtracted separately by their own return
method and cash_session_id. This equals the original charged total for the current
Flutter checkout, which records no tips/rounding. Do not count tendered cash before
change, subtract a refund twice or subtract a noncash refund from the till.
A cash refund of an older sale affects the session that paid the refund, not the
original sale's closed session. Noncash activity is shown separately and does not
change expected cash. Closure freezes the summary, including original sales totals,
refund totals and counts, even when older receipts are refunded in later sessions.

## Approaches and choice

The proposed approach extends the existing cash session with immutable closing
metadata/summary and reuses sales/refund records already linked to sessions. This
fits the authorized scope with no duplicated money movements. A separate cash
ledger would be useful for future cash-in/out/expense workflows, but duplicates
current records and adds reconciliation work here. Frontend-only closing cannot
protect concurrent devices or keep an authoritative audit. Neither alternative is
included. The shared-session approach is the implementation recommendation, not
a claim that the user separately requested a new ledger.

## Cashier flow

Add Sesi Kas / Tutup Kas to the existing cashier menu. Show opening amount,
opening user/time, cash sales retained, cash refunds, expected cash, transaction
counts and separate noncash breakdown. Cashier enters actual counted cash in whole
Rupiah; zero is valid. Difference = counted minus expected (positive surplus,
negative shortage). Require a 1–500 Unicode-character reason when difference is
nonzero; allow an optional note when matched. No arbitrary cash adjustments.

A server preview binds the current activity summary and entered count/reason.
Final confirmation saves the authoritative summary and closes that session in one
transaction. If another device records activity, refuse the stale preview and show
updated values for review, retaining the cashier's count/reason. Disable duplicate
submission and preserve one UUID/body for uncertain retry. A scoped session-detail
lookup can recover the saved result by checking its close request UUID. Never close
a different newly opened session accidentally.

After confirmed closure, show a read-only summary (opening/closing users/times,
amounts, difference/reason and method breakdown). Provide paginated session history
so summaries survive logout/restart; a new session may be opened with an explicitly
entered opening amount. Do not carry counted cash forward automatically. Closure
does not clear the active cart or delete saved orders; a later checkout requires
an open session. Prevent local checkout/refund/draft mutations overlapping the
close flow. Account-switch guards reject late responses and release only owned locks.

## Permissions and data integrity

All reads are authenticated/outlet scoped; foreign IDs return404. Cashiers/managers
may view their outlet's summaries. Only the cashier recorded as session.user_id or
an outlet manager can close; other cashiers are refused. No PIN/second approval gate.

Extend the existing cash package. Use existing authenticated client injection and
Flutter patterns. Add additive migration000012 for closure identity, reason,
expected/difference values, preview/request hash and immutable summary JSON, with
scoped unique request key and consistency checks. Keep nullable closure metadata
for previously closed legacy sessions: display unavailable historic reconciliation
rather than inventing values. Preserve opening/current endpoint compatibility.

Endpoints under /dikasa/v1: paginated GET /cash-sessions; GET /cash-sessions/{id};
POST /cash-sessions/{id}/close/preview; POST /cash-sessions/{id}/close. Existing
POST /cash-sessions and GET /cash-sessions/current remain. Explicit static route
registration prevents current being interpreted as a UUID. No request-supplied
outlet, closer identity or authoritative expected cash is accepted.

Use one database transaction and an exclusive session row lock for closure. Payment
creation must acquire/recheck that same session's open status under a shared lock
inside its write transaction; the current service preflight lookup alone is not
sufficient. Refund creation already locks its current session FOR SHARE. Existing
committed payment/refund recovery must remain possible after closing. Closure
waits for earlier writers; later writers cannot write to the closed session.
No automatic switching to a new session for an already prepared command.

Preview uses a consistent read snapshot. Confirmation locks the session before
recomputing activity; match the reviewed summary fingerprint. Successful exact
replay is checked before mutable checks, while UUID reuse with a different count/
reason/hash conflicts. Already closed by another intent is an explicit conflict.
Store enough response data to replay the original result after future activity.

Aggregate amounts with overflow-safe intermediates and validate whole Rupiah
safe-integer bounds. Counted cash >=0; expected/difference may be signed because
current-session refunds can exceed current cash inflows. Reject unsupported or
inconsistent snapshots with a meaningful error; do not silently repair old data.
Legacy cancelled/refunded receipts lacking verifiable refund evidence must be
flagged in the summary and block authoritative closure until resolved, rather than
silently guessing the missing cash outflow. Ordinary paid receipts remain usable.

## Verification and documentation

Tests cover permission/outlet scope, cash tender/change, partial/full and cross-session
refunds, return-method independence, zero/matched/short/surplus counts, reason and
range checks, immutable summaries, UUID replay/reuse, stale preview and concurrent
payment/refund/close races. Use isolated temporary PostgreSQL schemas; never close
the user's real open session to test. Verify existing checkout/saved-order/refund
regressions, mock parity, account-switch/recovery and cart preservation. Run full
Go/Flutter tests, analysis and web build; inspect desktop/narrow real-font renders.

Update OpenAPI, executable Bruno examples, Go docs, Draw.io source, both READMEs,
CHANGELOG, FEATURE_HISTORY POS-07, BACKLOG and a dated implementation log. Test the
migration in temporary schemas before applying only its verified additive up locally.
Preserve the normal8081 process and real user sales/stock/session data; no commits,
pushes or deployment. No new dependencies expected.

## Non-goals and builder choices

No separate tills per cashier, reopening/editing a closed reconciliation, cash
withdrawals/deposits, expenses, bank settlement, cash drawer hardware, printing,
shift scheduling or general sales reports. Customer management stays deferred.
Builder chooses package/file split, pagination bounds, hash serialization and UI
layout consistent with existing patterns; these are implementation decisions.
