# Saved unpaid orders

Status: approved by the user on 22 October 2026; implementation has not started.

## Purpose and scope

Connect the existing Simpan action so a cashier can park a cart, serve another
customer, reopen the saved order and finish payment. Persist orders in the local
PostgreSQL backend without Firebase. All cashiers at the same outlet can access
them. Preserve prior uncommitted work and work inline without subagents.

Saving is explicit, requires a connection and does not reserve or deduct stock.
Success means saved orders survive app/backend restarts, retain base and variation
lines and notes, and can be paid once without losing another cart or overwriting
another cashier's edits.

## Approach and alternatives

Recommended: add saved-order tables and integrate their completion into the
existing payment database transaction. This preserves the distinction between an
unpaid draft and a paid receipt and enables atomic stock deduction/completion.

Device-only storage would be smaller but would not share orders across cashiers.
Representing drafts as existing paid transactions would require weakening receipt
and cash-session constraints. Neither fits this workflow as well.

## Cashier workflow

- Simpan is enabled for a nonempty cart with a selected order type. Ask for an
  optional order label (maximum 100 characters); generate a readable fallback.
- Persist product and variation IDs, display names, quantity, displayed unit price,
  per-line note and order type. Require at most 100 lines, quantities 1..1000 and
  notes at most 500 characters. Totals remain estimates; never accept paid state,
  an outlet ID or a creator ID from the request.
- Clear the working cart only after confirmed save success. Saving an already
  reopened order updates it rather than creating another order. Disable cart
  mutations and duplicate submissions while saving.
- Add a Tersimpan tab within Daftar Order, with pagination, label search, creator,
  update time, item count and an estimated total. Existing paid-history browsing
  remains available.
- Opening a draft requires an empty working cart. If it is occupied, explain that
  the cashier must save or clear it first; never silently replace its contents.
- Reopening retains quantities, variation selection and notes. Refresh the catalog
  and order types. Compare current prices and availability with the saved snapshot;
  show affected lines and require confirmation of repricing or removal of missing
  products/variations before payment. Short stock does not prevent draft storage,
  but payment still requires sufficient stock.
- Current outlet tax is used for checkout; the saved estimate is not a price lock.
  The current app chooses a table during payment, so this increment preserves that
  behavior rather than introducing table reservations.
- Allow explicit deletion of an unpaid saved order after confirmation. No unpaid
  draft creates a paid-history row or changes inventory.
- A new cart, account change or logout clears the local draft association. Late
  responses from the old account cannot replace the new account's state.

## Persistence, authorization and concurrent edits

Add migration 000010, preserving existing rows:

- saved_orders: UUID primary key, outlet_id, created_by, label, order_type_id,
  revision (positive integer), status (open/paid/deleted), optional transaction_id,
  created_at and updated_at.
- saved_order_items: UUID primary key, saved_order_id, line position, product_id,
  optional product_variant_id, product_name, optional variant_name, unit_price,
  quantity and notes. Unique order/position; nonnegative price and bounded quantity.
- saved_order_commands: outlet_id and request_id unique, actor ID, operation,
  canonical payload hash, saved_order_id and immutable response JSON. This records
  successful create/update/delete retries even when later revisions have changed.
- Foreign keys follow existing UUID conventions. Product/variant identifiers must
  belong together in the authenticated outlet; validate that relationship in the
  service. Preserve item snapshots if a catalog item is deactivated later.
- Index outlet/status/update time for browsing. Keep paid/deleted drafts for audit
  and retry resolution; omit them from the normal saved list.

Every API derives the outlet and actor from the authenticated account. Cashiers
and managers can operate only on their own outlet. Cross-outlet IDs return 404.
Updates, deletion and checkout lock the draft row and require its current revision.
A stale revision returns 409 and leaves the server order intact; Flutter offers
reload instead of silently overwriting it. Opening does not acquire an exclusive
long-lived lock; concurrent cashiers are resolved at mutation time.

## API contract

All routes use /dikasa/v1 and standard response/error envelopes:

- POST /saved-orders: request_id UUID plus label, order_type_id and items;
  returns a confirmed saved-order snapshot and revision.
- GET /saved-orders: open orders, search, page and page_size (maximum 100).
- GET /saved-orders/{id}: full outlet-scoped snapshot including status and receipt
  reference when paid, allowing recovery after a lost payment response.
- PUT /saved-orders/{id}: request_id, expected_revision and replacement cart.
- DELETE /saved-orders/{id}: request_id and expected_revision query parameters;
  returns a confirmed deleted snapshot.
- Extend POST /transactions with optional saved_order_id and saved_order_revision,
  required together. Ordinary unsaved checkout retains its existing contract.

Create/update/delete retries use the same UUID and exact payload. A matching
successful command returns its original result; a reused UUID with different
content returns 409. The client retains an uncertain command for retry/recovery
and does not discard its cart on a timeout. On app restart the saved-order browser
is the recovery source; this increment does not add general offline cart autosave.

## Atomic payment and recovery

For checkout linked to a draft, the payment repository first locks the scoped
saved-order row and checks its revision/status. Validate that the submitted cart
matches the saved revision, including quantities, notes, selected variations and
prices; editing or repricing a reopened cart must save a new revision before pay.
Then use existing catalog-price and stock validation, insert the receipt/items,
deduct stock and mark the draft paid with the receipt ID in one transaction.
Any failure rolls back all changes.

A second payment of a paid draft returns 409 with a stable already-paid code.
Flutter resolves an uncertain response by fetching that draft and its receipt
reference, never by submitting an unrelated fresh payment. Existing manual
reconciliation remains for unsaved checkout; this does not claim general payment
idempotency for all receipts. No external payment gateway is added.

## Implementation boundaries and verification

Introduce a backend saved-order package and extend payment through shared
persistence helpers without circular package imports. Wire it into API startup,
OpenAPI generation and router tests. Add matching Flutter models/service calls,
MobX state, save dialog, browser tab and mock behavior.

Write tests before implementation for outlet isolation, input bounds, replay and
changed-payload UUID conflicts, stale revisions, missing variants, save failures,
nonempty-cart protection and account switches. PostgreSQL integration tests must
prove one winner for competing payment/update/delete actions and rollback of
receipt, draft status and stock on failure. Flutter tests cover separate variation
lines, notes, repricing confirmation, retry retention and already-paid recovery.

Run focused/full Go and Flutter tests, Flutter analyze, web build and OpenAPI sync.
Keep Bruno requests, API documentation, Draw.io ERD and developer handoff log in
sync. Use temporary-schema database checks first. Apply only the new migration to
the existing local database after verification; no reset. Avoid creating live paid
test receipts unless needed and document any retained fixtures.

## Out of scope

Customer creation/attachment, split payments, refunds, reservations, offline sync,
automatic abandoned-cart recovery, kitchen tickets, discounts, printing and new
Figma design work. Match the current app's existing dialog/list styles.
