# Whole and item-level refunds with cancellation handling

Status: written design approved by the user on 24 October 2026 (Asia/Jakarta).
The user approved both refund modes for cashiers and optional per-item stock return.
Implemented locally on 24 October 2026. See the workspace refund implementation
log for actual verification, migration state and limits.

## Intent and agreed behavior

Let cashiers and managers correct paid sales without deleting the original receipt,
losing the audit trail or refunding the same units twice. Support anonymous walk-in
sales; customer management remains deferred. Preserve the current local Go,
PostgreSQL and Flutter setup without requiring Firebase. Work inline, no subagents.

- Whole receipt: refund all still-unrefunded units and their remaining value.
- Individual items: choose receipt lines and whole-unit quantities, including one
  unit from a line containing several units. Base and variation lines stay distinct.
- Both modes account for all earlier refunds. Whole receipt after partial refunds
  means the remaining balance, not a second refund of the original total.
- Reason, authenticated actor, timestamp, amount, returned quantities and stock
  decision are recorded. The original receipt and sale item snapshots stay intact.
- Stock return defaults to zero. The cashier explicitly chooses returned quantities
  per line; damaged/prepared items can be refunded without restocking.
- Money is returned outside this app and recorded by the cashier, matching existing
  manual payment handling. No payment gateway transfer is initiated.
- Keep a dated implementation log and update changelog/history after delivery.

## Approaches

Use additive refund records linked to immutable sale snapshots. Both full and item
refunds use the same quantity-based ledger and validation. A full refund simply
selects every remaining line quantity. This follows the agreed receipt-preservation
and audit requirements and avoids two competing refund calculations.

Editing/deleting original receipt lines would destroy the sale history. Using a
negative sale as a refund would mix different validation, stock and cash semantics
and make original-item quantity limits harder to enforce. Neither fits the agreed
behavior. The concrete table/API design below is the builder's proposal.

## Cancellation boundaries

- Unsaved unpaid cart: existing Hapus action clears the local cart; there is no
  paid receipt or financial reversal to record.
- Saved unpaid order: existing confirmed deletion retains its deleted draft and
  command audit records. Stock is unaffected because saving never deducted stock.
- Paid order: a request to cancel opens whole-remaining refund, with explicit
  confirmation that money was returned. Do not delete the paid receipt or introduce
  a second financial reversal path. History records the result as refunded.
- Previously cancelled/imported transaction states remain visible but cannot be
  refunded unless a supported original paid sale exists. A refunded saved order
  remains completed/paid as a draft and cannot be reopened for another payment.

## Cashier flow

1. In Daftar Order, open a paid-history row to view receipt details: original
   items/variations, quantities, original total, refunded total and remaining amount.
2. Choose Refund seluruh sisa or Refund item. For item mode, select quantities no
   greater than the remaining quantity shown on each original transaction item.
3. Enter a reason (1–500 Unicode characters). Stock-return quantity is initially0
   on every selected line; enable/adjust it explicitly, never above refunded quantity.
4. Select how money was returned. Default to the original payment method; allow
   another supported manual method when that is what actually happened. Display the
   original method separately so this choice never rewrites the original payment.
5. Fetch a server preview. Show selected quantities, amount, original tax allocation,
   return method and stock changes. Confirmation says the money has been returned
   manually. Preview has no database or stock side effects.
6. Confirm once. Preserve inputs on validation/revision errors. If another refund
   changed availability after preview, require a refreshed preview and confirmation.
7. Show the confirmed refund number and refresh receipt/history/catalog. Previous
   refunds are viewable with reason, actor, time, amounts and stock-return decisions.

Use existing app dialog/list styles and responsive scrolling; no Figma write or new
design-system import is required. Disable refund actions while a checkout/payment
or uncertain command is being resolved. Account/request guards prevent late responses
from displaying old-outlet receipts or changing the next account's cart/catalog.

## Amounts, tax and rounding

Use original transaction/item snapshots, never current catalog prices or current tax.
Refund the charged `total_amount`, not `paid_amount` (which can include cash tender
and change). The existing payment contract defines total as subtotal minus discount
plus recorded tax; tip/rounding metadata must not be added again.

Allocate original discount and recorded tax to original receipt lines with integer
largest-remainder allocation, stable by original item UUID. Discount uses original
line-total weights; tax uses post-discount line weights, falling back to gross
weights and then quantities when every monetary weight is zero. Use arbitrary-
precision intermediate arithmetic; exposed amounts remain bounded whole Rupiah.

For a component budget B on an original line of quantity Q, the amount assigned to
refunding the next q units after k units were already refunded is
`floor(B*(k+q)/Q) - floor(B*k/Q)`. Apply this to the line's post-discount net budget
and tax budget separately; the sum is its refund amount. This makes all partial
refunds plus a final whole-remaining refund equal the original charged total exactly.
Free items can have quantity refunded at Rp0; completion is based on remaining
quantities, not amount alone.

Example: three Rp10,000 units and Rp3,000 recorded tax. Refunding one unit yields
Rp11,000; later refunding the remaining two yields Rp22,000. A tax budget of Rp1
is distributed deterministically across successive unit refunds without exceeding
that one Rupiah. The preview and committed refund use the same server calculation.

Reject inconsistent historical receipt snapshots with a clear error and no writes,
rather than guessing their amounts. Do not backfill invented refund records for
legacy transactions already labelled refunded/cancelled without ledger evidence.

## Authorization, persistence and concurrency

Only authenticated cashier/manager accounts can refund within their own outlet.
Foreign-outlet receipt/refund IDs return404. Require an active outlet cash session
at confirmation and record it on the refund, even when the original sale belongs
to an older session. Record the actual return method independently of the original
sale. This prepares cash reconciliation without implementing cash closing now.

Proposed additive migration000011:

- transaction_refunds: UUID/unique refund number, outlet, original transaction,
  actor, current cash session, reason, method, mode, net/tax/total amounts, timestamp,
  request UUID, payload hash and immutable successful-response snapshot.
- transaction_refund_items: refund/outlet/original transaction-item references,
  refunded quantity, stock-return quantity and allocated net/tax/total amounts.
- Add a nonnegative refund_revision to transactions, initially0, for preview and
  confirmation concurrency checks. Extend allowed status with partially_refunded.
- Add nullable refund_id on stock_movements and allow refund_return movement kind,
  linking each physical inventory return to its refund and original transaction.
- Composite foreign keys and unique scoped request IDs protect outlet relationships.
  Add indexes for receipt refund history and outlet refund time. No receipt resets.

Before confirmation, serialize outlet/request UUID, inspect successful replay,
then lock the original receipt. Enforce expected_refund_revision and sum refunded
quantities under that lock. Lock parent products in stable UUID order for returns.
Write refund/header/items, optional stock increments/audit movements, receipt status
and incremented revision in one transaction. Any failure rolls back everything.

Same UUID and canonical payload returns the original successful response; changed
payload under that UUID returns409. Distinct racing refunds cannot exceed sold
quantities. Retry lookup precedes revision checks, so later refunds cannot invalidate
the retry of a refund that already succeeded.

## Inventory return rules

Restock eligibility requires evidence that the original sale deducted this product's
tracked stock. Use original sale stock_movements, not today's tracking flag alone.
Do not invent stock for historical/untracked sales that had no deduction.

Combine all base/variation returns into their shared parent product balance. Cap
total returns across all refunds at the original recorded deduction, and cap each
line return at its refunded units. Require tracking still enabled at confirmation;
if it was disabled or balance would exceed1,000,000,000, reject the selected return
without applying money/stock writes. Cashier can deselect restocking and re-preview.
An inactive product with tracked inventory may receive its physical return without
reactivating the product or its category. Each refund return has an audit movement.

## API and history

All authenticated routes use `/dikasa/v1` and existing response/error envelopes:

- GET /transactions/{transaction_id}: original receipt snapshots, current refund
  revision, per-line refunded/remaining quantities, refundable totals and restock
  eligibility. This detail endpoint does not exist yet and must be built.
- GET /transactions/{transaction_id}/refunds: paginated refund history, default20,
  maximum100, including quantities and stock decisions.
- POST /transactions/{transaction_id}/refunds/preview: read-only calculation for
  full/item selection, returned quantities and method at an expected revision.
- POST /transactions/{transaction_id}/refunds: confirm with request UUID, expected
  revision, reason, method and selection. Amounts are calculated on the server.
- GET /refunds/by-request/{request_id}: resolve a lost confirmation response in the
  authenticated outlet. Return404 if it is not yet committed; retain the exact retry.

Receipt history keeps the original total and adds refunded/net-after-refund totals
plus a partially_refunded filter/label. Refund status is paid with no refunded units,
partially_refunded while units remain, and refunded after every unit is refunded.
Existing refunded/cancelled labels without ledger rows are flagged as legacy/blocked.

Use clear409 codes for changed revision, exhausted quantities, altered retry UUID,
unavailable cash session or invalid restocking state;422 for invalid selections or
unsupported/inconsistent original snapshots. No raw database details in responses.

## Lost responses and external money

Freeze the pending confirmation payload/UUID if response is lost, malformed or5xx.
Offer outcome lookup and identical retry, never a fresh automatic refund. Preserve
the reason, selection and stock decision. A lookup404 alone does not prove failure
because the first request may still be running. Mutation replay/receipt locks ensure
an identical retry cannot create a second ledger entry or stock return.

The app cannot guarantee or reverse an external cash/bank action. Clearly show that
this flow records money already returned; a server timeout is not an instruction
to return money again. On restart use receipt refund history for reconciliation.

## Verification, documentation and rollout

Use TDD and existing repository patterns. Test full/partial/partial-then-full,
variation lines, one-of-many quantity, free lines, discounted receipts and Rupiah
rounding. Test permission/outlet isolation, duplicate requests, changed UUID payload,
concurrent refunds, stale previews, stock limits/eligibility, transaction rollback,
uncertain-response recovery, account switches and active-cart preservation.

Run full Go/Flutter tests, actual Huma contract tests, analyzer, web build, OpenAPI
sync and isolated-schema PostgreSQL integration. Mock flow mirrors the real ledger.
Update OpenAPI, Bruno, development guide, Draw.io source, dated handoff log, changelog,
feature history and backlog in the same delivery. Report actual test runs/skips.

Verify migration000011 in temporary schemas before applying only that additive
migration locally. Do not refund real existing user transactions for a smoke test.
Prefer temporary-schema transactions for refund verification; document any retained
local marked fixtures. Preserve the user's running server unless restart is agreed.

## Non-goals

Customer management, automated gateway payouts, cash-session closing, general
accounting/tax reporting, exchanges, arbitrary goodwill amounts without item
quantities, split-tender allocation, refund reversal and multi-outlet returns.
