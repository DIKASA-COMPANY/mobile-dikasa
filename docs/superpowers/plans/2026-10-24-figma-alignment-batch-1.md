# Figma Alignment Batch 1 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox syntax for tracking. The user requires inline execution without subagents; do not delegate.

**Goal:** Match payment success, read-only customers, and paid/saved order lists to their Figma screens while preserving working behavior.

**Architecture:** Reuse existing services and business actions. Add an immutable local payment presentation snapshot, then build full-page Flutter presentations around existing browser logic. No backend changes or migrations.

**Tech Stack:** Flutter/Dart, MobX, Provider, Dio, flutter_svg, bundled Poppins fonts, flutter_test.

**Spec:** [Approved batch-1 design](../specs/2026-10-24-figma-alignment-batch-1-design.md), approved by the user after its initial review.

## Global Constraints

- Reference canvas is 1340 by 800; narrow layouts wrap/scroll rather than scale the whole canvas.
- Customer creation/editing and order attachment remain deferred.
- No database migrations, backend mutations, payment gateways, printing, WhatsApp integration, customer management, split payments, discounts, points redemption, tips/rounding behavior or batch-2 work.
- No commits, pushes, worktrees or subagents. Preserve all accumulated local edits and the running backend.
- Keep existing session, pending payment, draft and write guards.
- Use actual outlet/user/avatar data, exact local Figma assets and Poppins; no sample identities or temporary asset URLs at runtime.
- SDK verification may require escalated access to installed Flutter caches; do not change repository-wide permissions or Git configuration.

## Review Focus

- Payment clears the cart: success must retain exact submitted values after clearing and never reconstruct them from current products.
- Session/account changes during requests: stale results must not display another user's receipt or customer/order data.
- Payment response uncertainty: success must not appear and no automatic duplicate payment may occur.
- Saved draft reopening/repricing: keep revision checks, user review, request recovery and original-cart protection.
- Long names, absent optional fields and narrow windows: content remains readable, fields are truthful, and navigation/actions remain reachable.

## Task 1: Immutable confirmed-payment presentation

**Files:**
- Create `lib/data/models/payment_snapshot.dart`.
- Modify `lib/data/models/pos.dart`, `lib/features/new_order/view_model.dart`.
- Create `test/data/payment_snapshot_test.dart`.
- Extend `test/features/new_order/saved_order_test.dart` for payment/session integration.

**Interfaces:**
- `PaymentSnapshot.fromPayload(Map<String, dynamic> payload, {required String orderTypeLabel})` produces immutable copied line/totals data from the submitted request.
- Each `PaymentSnapshotLine` exposes product/variant labels, note, quantity, unit price and line total.
- Snapshot exposes subtotal, tax percentage/amount, total, paid, change, rounding, tips, method and order-type label.
- `PaymentReceipt` retains its existing constructor/fromJson and adds optional `PaymentSnapshot? snapshot` and `PaymentReceipt withSnapshot(PaymentSnapshot snapshot)`; API JSON remains unchanged.
- `NewOrderViewModel.pay(...)` keeps `Future<PaymentReceipt?>` and current guard/error behavior.

- [x] Write tests named `snapshotCopiesSubmittedLinesAndAmounts` and `snapshotCollectionsAreImmutable`: mutate the source request after construction, assert original values and unmodifiable line storage.
- [x] Extend payment tests: returned receipt has correct subtotal/tax/paid/change/variant/notes after cart clear; failed/uncertain/account-switched payments return no successful presentation; normal request count remains one.
- [x] Run `flutter test --no-pub test/data/payment_snapshot_test.dart test/features/new_order/saved_order_test.dart` and confirm the new assertions fail before implementation.
- [x] Capture the snapshot from the exact payload before sending; attach it only after a valid response and existing `currentPayment()` check, then clear the cart as before. Do not change transaction submission/retry contracts.
- [x] Run the same tests and confirm all pass.

## Task 2: Figma page components and payment-success screen

**Files:**
- Create `lib/features/new_order/widgets/browser_design.dart` and `browser_page_header.dart`.
- Create `lib/features/new_order/widgets/payment_success_view.dart`.
- Modify `lib/features/new_order/view.dart`.
- Add exact missing assets under `assets/icons/` and `assets/images/`.
- Create `test/features/new_order/figma_batch_one_test.dart`.
- Modify `test/features/new_order/pos_flow_test.dart`.

**Interfaces:**
- `BrowserPageHeader({required String title, required User? user, required VoidCallback onBack, VoidCallback? onLock})` is a shared 88-pixel responsive header.
- `BrowserDesignIcon(String name)` wraps only exact locally verified assets at natural root geometry.
- `PaymentSuccessView({required PaymentReceipt receipt, required User? user})` consumes Task 1's immutable presentation; `static Future<bool?> show(BuildContext context, PaymentReceipt receipt, User? user)` returns true for Daftar Order, false/null for Selesai/back.

- [x] Write tests: `successKeepsPaidItemsAfterCartClear`, `successActionsReturnToCashierOrHistory`, `unfinishedReceiptActionsAreDisabled`, `successNarrowLayoutHasNoOverflow`.
- [x] Update the existing POS flow expectation from the old confirmation title to Transaksi Berhasil and Selesai; retain the one-write and cleared-cart assertions. Run those tests and confirm expected failures.
- [x] Compare existing catalog/report/cash SVGs with Figma sources before adding assets; download missing assets using connector-specified curl instructions. Record hashes, root dimensions and layer/slot mapping for verification.
- [x] Implement the reference left order-summary panel and right success/payment panel from node 1:15873. Use actual snapshot values; omit payment timestamp because the existing response/detail model supplies no authoritative timestamp. Keep zero tips/rounding truthful.
- [x] Leave Cetak Struk and Share via WA disabled with accessible explanations. Preserve Selesai and secondary Daftar Order navigation; do not show success from reconciliation without a confirmed receipt.
- [x] Route confirmed payment through this page after the existing post-payment catalog refresh; check current user/session before navigation and before opening history. Protect active routes against stale session data.
- [x] Run the targeted tests and confirm pass; render desktop and narrow success screenshots and inspect them against Figma.

## Task 3: Customer page and full-page browser shell

**Files:**
- Modify `lib/features/new_order/widgets/sales_browser.dart`.
- Create `lib/features/new_order/widgets/customer_browser_body.dart` and `browser_empty_state.dart`.
- Extend `test/features/new_order/figma_batch_one_test.dart`.

**Interfaces:**
- `SalesBrowser.show(BuildContext context, NewOrderViewModel vm, {bool customers = false}) -> Future<void>` stays unchanged externally but pushes a full-page route.
- `CustomerBrowserBody({required PosPage page})` renders six Figma columns without mutation actions.
- `BrowserEmptyState({required bool customers, required bool searching})` distinguishes no stored records from no matching search; uses the exact empty-state illustration from frames 1:15513/1:12449.

- [x] Write tests: customer toolbar and six headers, address/gender/null fields, empty versus search-empty messages, failed fetch retry, search reset to page 1, server pagination, no customer POST, disabled Tambah/Tanpa Pelanggan, late results after account change, narrow overflow.
- [x] Run `flutter test --no-pub test/features/new_order/figma_batch_one_test.dart` and confirm new cases fail for the intended missing layout/guards.
- [x] Introduce the full-page shell using Task 2 header; preserve the caller-await contract and add account/session result invalidation consistent with existing account settings patterns.
- [x] Build the blue Pelanggan Terdaftar toolbar and rounded blue/gray six-column table from node 1:12374. Read address and gender from existing API fields; preserve search by name, phone or email and pagination.
- [x] Use the inspected empty frame for no records; do not imply the database is empty when a search returns no matches. Retain refresh and retry controls.
- [x] Run targeted tests and inspect desktop/narrow/populated/empty/error screenshots.

## Task 4: Paid and saved order tables

**Files:**
- Modify `lib/features/new_order/widgets/sales_browser.dart`, `saved_orders_browser.dart`.
- Create `lib/features/new_order/widgets/paid_orders_table.dart`.
- Extend `test/features/new_order/figma_batch_one_test.dart`, `saved_order_widgets_test.dart`.

**Interfaces:**
- `PaidOrdersTable({required PosPage page, required bool actionsBlocked, required ValueChanged<String> onDetail})` supplies reference columns and refund/status information.
- Keep `SavedOrdersBrowser({required NewOrderViewModel viewModel})` and its current open/delete/review methods. Its presentation adopts the shared table style.
- Keep `ReceiptDetailDialog.show(...)` and all saved-order service mutation signatures unchanged.

- [x] Write tests: Figma columns render real customer/table/quantity data; status/type filters use API values; paid action opens receipt detail; refund totals remain available; saved rows label estimates before tax and use draft labels; Buka returns to cashier only after successful open; deletion/conflict/catalog review/recovery and write-time navigation guards still work.
- [x] Run `flutter test --no-pub test/features/new_order/figma_batch_one_test.dart test/features/new_order/saved_order_widgets_test.dart` and confirm the new table expectations fail before implementation.
- [x] Match node 1:12140 toolbar/table/footer; retain Dibayar/Tersimpan tabs as the approved extension. Put existing filters in the reference filter control while preserving all supported statuses/order types.
- [x] Render paid reference columns plus accessible original/refunded/net/status details. Use a truthful Detail action rather than implying a paid sale is editable.
- [x] Restyle saved rows into the same table family; identify drafts by label, display creator/time/quantity/order type/estimated subtotal and preserve all existing reopen/delete/review/retry logic.
- [x] Run targeted tests and inspect desktop/narrow paid/saved/empty/error states against the references.

## Task 5: Regression verification, asset audit and delivery history

**Files:**
- Create parent-folder `FIGMA_ALIGNMENT_BATCH_1_IMPLEMENTATION_LOG_2026-10-24.md`.
- Modify parent-folder `CHANGELOG.md`, `FEATURE_HISTORY.md` and frontend README history links if needed.
- Update approved spec status and this plan's completed checkboxes with actual evidence.

- [x] Run `flutter test --no-pub --dart-define=CAPTURE_CASH_MOVEMENTS=true --dart-define=CAPTURE_ACCOUNT=true --dart-define=CAPTURE_REPORTS=true --dart-define=CAPTURE_FIGMA_BATCH_ONE=true`; record passed/skipped counts and investigate every failure.
- [x] Run `flutter analyze --no-pub` and `flutter build web --no-pub`; require no analyzer issues and successful build.
- [x] Inspect screenshots for all three requested screens at 1340x800 and a narrow width, including long text/empty/error cases. Check every visible static asset's local file, hash, source slot, callsite and effective rendered geometry; correct in-scope mismatches.
- [x] Run repository `git --git-dir=.git --work-tree=. diff --check`; inspect changed/untracked files without discarding existing work. No real transactions, customer writes or draft deletions for QA.
- [x] Write the dated implementation log with Figma frame/session references, approved deviations, asset audit, tests, screenshots and limitations; update history/changelog only for delivered work. Mark batch 2 pending.

## Self-review

All approved sections map to Tasks 1-5: immutable payment data and uncertainty to
Task 1, success/navigation/assets to Task 2, customer read-only/search/session
states to Task 3, paid/saved preservation to Task 4, and responsive visual QA and
accountability to Task 5. No backend read-contract extension is required for the
chosen timestamp omission. Interfaces retain existing public browser/pay entry
points. Review Focus cases have explicit owning tests above.

Status: approved and completed inline. Full suite 156 passed / 7 optional skips; final dedicated visual/browser run 10 passed; analyzer clean; web build succeeded (83.6s). See the parent-folder batch-1 implementation log and work log for evidence.
