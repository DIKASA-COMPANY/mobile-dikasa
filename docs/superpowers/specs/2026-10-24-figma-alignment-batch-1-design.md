# Figma alignment, batch 1

Date: 24 October 2026 (Asia/Jakarta).
Status: approved by the user and implemented locally; see the batch-1 implementation log.

## Intent and agreed sequence

Replace the simplified payment-success dialog, read-only customer browser, and
paid/saved order browser with screens based on the existing Figma file. Preserve
their working data connections and safeguards. User selected these as batch 1;
cash closing, dedicated transaction history, and checkout layout are batch 2.
Customer creation/editing and order attachment remain deferred.

## Design evidence

File: https://www.figma.com/design/jgBLUfP6OXyxmErwgTjfIT/aiuiuiu

High-fidelity design context and screenshots inspected for:

- Payment success: node 1:15873.
- Registered customers: node 1:12374.
- Populated order list: node 1:12140.

Figma task session: a348e4f4-d3ef-498b-93e4-fcfdcf1b2a84.
The empty-order frame 1:15513 and customer variant 1:12449 must also be inspected
before implementing their visible states. Reference canvas is 1340 by 800.

## Approach

Recommended: replace these presentations with Flutter pages, reuse the existing
services and business actions, and adapt Figma components to the current data.
This matches the user's request to fix existing screens and limits payment risk.

Alternative: also implement every currently unfinished action visible in Figma,
including printing, WhatsApp sharing, customer creation/attachment, tips, and
rounding. This substantially expands scope and conflicts with deferred customer
management, so it is excluded from this batch.

The implementation choices below are recommendations for approval, not choices
the user has separately made.

## Shared presentation and navigation

- Use Poppins, the Figma blue/gray palette, 88-pixel desktop header and toolbar,
  rounded table headers, row styling, and reference spacing.
- Reuse matching existing local SVGs and Flutter components where exact; download
  missing Figma assets as instructed by the connector. Record source layers,
  file hashes, root dimensions, slots and rendered sizes in the implementation log.
- Show actual outlet/user/avatar data; never use the sample person's identity.
- Full-page presentation replaces the floating browser/dialog. Retain the
  SalesBrowser.show entry point if practical so cashier/recovery callers continue
  to await navigation correctly.
- Back returns to the caller. Reopening a saved order returns to the cashier.
  Existing session, pending payment, draft and write guards remain enforced.
- At narrow widths, wrap toolbars and scroll wide tables horizontally; success
  panels stack vertically with scrolling. Do not shrink an entire desktop canvas.
- Keep loading, API-error/retry, empty, no-search-results and pagination states.
- Notification/lock behavior stays consistent with the existing app; no new lock
  or notification feature is included.

## 1. Payment success

- Replace the small confirmation dialog with the Figma two-panel screen: order
  lines and totals on the left, success heading, payment figures and actions on
  the right, plus the existing shared identity/header treatment.
- Build an immutable snapshot from the exact submitted payment and combine it
  with the successful receipt response before clearing the cart. Show it only
  after a confirmed successful payment for the same session/account.
- Preserve product/variation labels, notes, quantities, subtotal, tax, order type,
  payment method, amount received, total and change. Never read the cleared cart
  or current catalog to reconstruct this receipt.
- Show zero for unsupported tips/rounding; do not apply Figma sample amounts or
  introduce new financial calculations. Never label cash change as rounding.
- The payment response has an ID, number and total, but no authoritative payment
  timestamp. Do not invent one: omit the timestamp unless an existing receipt
  read contract supplies it; this must be verified before implementation.
- Selesai returns to the cashier. Keep Daftar Order available as a secondary
  action so the existing post-payment history path remains accessible.
- Cetak Struk and Share via WA occupy their reference positions but are disabled,
  with accessible explanations, until their functionality is implemented.
- An uncertain payment remains in the existing reconciliation flow and must not
  display success or submit another payment automatically.

## 2. Read-only customers

- Match the Pelanggan Terdaftar toolbar, search and six-column table: Nama,
  Alamat, Poin, Gender, Telefon, Email.
- Use existing /customers search/pagination. Address and gender already exist in
  the API response; optional fields display a dash when absent.
- Keep search by name/phone/email. Display points read-only without implying
  redemption is implemented.
- Tambah and Tanpa Pelanggan remain visibly disabled with explanations because
  creating/selecting an order customer is deferred. Back remains functional.
- Do not introduce customer mutations or silently attach a customer to a cart.

## 3. Paid and saved orders

- Match the Daftar Order toolbar, search, blue table header, gray rows and footer.
  Use the reference columns: No Nota, Nama Pelanggan, Tanggal Order, Jenis Order,
  Jumlah, Tagihan, and the trailing action slot.
- Retain clearly labeled Dibayar and Tersimpan tabs as an intentional extension;
  Figma does not provide distinct layouts for these two persisted states.
- Paid rows use existing receipt/customer/date/type/table/quantity/amount fields.
  Keep status/type filters, refund status and original/refunded/net amounts
  accessible without concealing previously delivered information.
- The paid trailing action opens the existing receipt/refund detail. It must not
  imply a completed sale is editable merely because Figma uses an edit icon.
- Saved rows identify drafts by their label, never by a fabricated receipt number.
  Show creator, updated date, order type, quantity and estimated subtotal with an
  explicit before-tax label; do not label a draft estimate as a paid bill.
- Preserve reopen/delete, confirmation, changed-catalog review, revision conflict,
  identical-request retry and uncertain-write recovery behavior.
- Keep tabs/search/filter changes and navigation guarded during pending writes.

## Boundaries

No database migrations, backend mutations, payment gateways, printing, WhatsApp
integration, customer management, split payments, discounts, points redemption,
tips/rounding behavior or batch-2 work. If an actual read-contract gap is found,
document it before broadening scope. No commits, pushes, worktrees or subagents.
Preserve all accumulated local edits and the running backend.

## Verification and accountability

- Widget/flow tests cover confirmed success with a cleared cart, failed/uncertain
  payments, account changes, search/pagination, filters, receipt details, saved
  reopen/delete/review and blocked navigation during writes.
- Render and inspect desktop 1340x800 and narrow layouts for all three screens,
  including empty/error states, against the Figma screenshots. Verify every
  visible static asset's exact source, geometry and local callsite.
- Run Flutter tests, analyzer and web build; inspect diffs for accidental edits.
  Use mock/isolated test data; do not create real sales or delete actual drafts.
- Add a dated batch-1 implementation log with screenshots, tests, changed files,
  approved adaptations and limitations; update CHANGELOG.md and FEATURE_HISTORY.md
  only when delivered. Record batch 2 separately as pending.

## Approval

Review the batch boundaries, disabled unfinished actions, draft adaptations and
payment snapshot approach above before implementation planning begins.
