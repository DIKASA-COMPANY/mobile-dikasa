# Cash Closing and Reconciliation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking. The user requires inline execution without subagents, including review.

**Goal:** Close an outlet's shared till with an authoritative cash count, discrepancy reason, immutable summary and recoverable confirmation.

**Architecture:** Extend the existing cash package with a separate reconciliation boundary so opening/current interfaces remain compatible. Read session-linked receipt/refund activity, preview it consistently and close under an exclusive session lock. Payment/refund writers take shared session locks; Flutter owns one account-bound close command and refreshes current-session state without clearing the cart.

**Tech Stack:** Existing Go/GORM/PostgreSQL/Gin/Huma; Flutter/Dart/MobX/Dio; Go math/big and Dart BigInt. No new dependency or service.

**Spec:** [Approved cash-closing design](../specs/2026-10-24-cash-closing-design.md).

Paths are relative to the parent Dikasa workspace. Backend commands run inside be-dikasa; Flutter commands inside mobile-dikasa.

## Global Constraints

- Work inline, no subagents, preserve uncommitted work and maintain dated logs.
- Only the cashier recorded as session.user_id or an outlet manager can close; other cashiers are refused. No PIN/second approval gate.
- Keep one shared open till per outlet. Existing opening/current endpoints remain compatible.
- Expected cash = opening cash + cash receipts retained - cash refunds paid out.
- Cash receipts retained = original paid_amount minus change_amount; do not drop receipts subsequently refunded or subtract the refund twice.
- Refunds are attributed by their own method and cash_session_id, including refunds for older sales. Noncash methods do not change expected cash.
- Counted cash >=0; expected/difference may be signed. Difference = counted minus expected.
- Require a 1–500 Unicode-character reason when difference is nonzero; allow an optional note when matched.
- Whole Rupiah safe-integer bounds: each exposed amount is within +/-9007199254740991; counted/opening values are nonnegative. Intermediate sums must not overflow.
- Closure freezes its summary. Do not recalculate a closed summary from mutable receipt statuses.
- Legacy closed sessions without reconciliation remain readable with unknown/null closing summary; legacy cancelled/refunded receipts lacking verifiable refund evidence block new authoritative closure with an explicit error.
- All new endpoints use /dikasa/v1 and existing data/error envelopes. Outlet/closer identities are derived from auth.
- Preserve the normal8081 process and real user sales/stock/session data; no commits, pushes or deployment.
- No new dependencies expected. Customer management stays deferred.
- No separate cash ledger, cash-in/out, expenses, reopening, hardware, printing or general sales reports.

## Review Focus

1. An older receipt refunded by cash today must affect today's session only; Task1/3 fixtures verify both summaries and later immutable reads.
2. A payment prepared before close must not commit into the closed session, including saved-order checkout; Task4 pins lock ordering and rollback.
3. A lost close response must replay after a new session opens, without closing that new session; Tasks3/6 test exact-ID recovery.
4. Cash receipts with change and refunds through a different method must reconcile independently of sale status/method; Tasks1/3/7 pin those amounts.
5. Late account-switch responses must not clear a new account's session/cart or release another operation's lock; Task6 tests each asynchronous boundary.

## File map and shared contracts

- New be-dikasa/internal/cash/reconciliation.go: activity/snapshot/summary/preview/command types, safe pure calculation and canonical hash.
- New reconciliation_test.go and reconciliation_service{,_test}.go: amount/permission/orchestration tests and service.
- New reconciliation_repository.go and reconciliation_postgres_test.go: consistent reads, immutable detail/history, transactional closure/replay and isolated DB fixtures.
- New reconciliation_handler{,_test}.go: DTOs, HTTP adapter and route registration.
- New migrations/000012_add_cash_reconciliation.{up,down}.sql; modify Makefile, cash/entity.go and migration tests.
- Modify payment/repository_gorm.go and its regression tests for in-transaction open-session locking; retain refund/repository_gorm.go shared-lock behavior.
- Modify cmd/api startup, internal/server/router.go, cmd/openapi generator, router/schema tests to inject the new cash handler, leaving existing CashHandler interface intact.
- New mobile data/models/cash_reconciliation.dart and data/services/cash_reconciliation_service.dart; expose PosService.cashReconciliation using its existing authenticated ApiClient.
- New features/new_order/cash_closing_controller.dart, widgets/cash_sessions_dialog.dart and widgets/cash_closing_dialog.dart; extend existing menu and view-model operation guards.
- New core/network/mock_cash_sessions.dart; extend mock API/refund session attribution without copying catalog inventory.
- Add focused Go/Flutter tests and update all documentation in Task8.

Shared JSON names: session_id, opening_user_id/name, opened_at, opening_cash,
cash_sales, cash_refunds, expected_cash, sale_count, refund_count, methods,
reconciliation_supported, unsupported_reason, can_close. Each methods element has
method, sale_count, sales_amount, refund_count, refunds_amount. Counted/closing data
uses counted_cash, difference, reason, closed_by/name, closed_at, close_request_id.
The original cash_sessions.closing_cash stores counted_cash. Legacy summary is null.

### Task 1: Pure reconciliation amounts and preview binding

**Files:** Create internal/cash/reconciliation.go and reconciliation_test.go.

**Interfaces:** Activity{Receipts []ReceiptActivity; Refunds []RefundActivity}; SessionSnapshot{ID,OutletID,OpeningUserID,OpeningUserName,Status string; OpenedAt time.Time; OpeningCash int64; Activity Activity}; ReconciliationSummary with the JSON fields above; CloseSelection{CountedCash int64; Reason string}; ClosePreview{Summary ReconciliationSummary; CountedCash,Difference int64; Reason,PreviewHash string}; CloseCommand embeds selection and adds RequestID,PreviewHash. Produce Summarize(SessionSnapshot)(ReconciliationSummary,error), BuildClosePreview(SessionSnapshot,CloseSelection)(ClosePreview,error). ReceiptActivity includes ID,Method,Status,RefundRevision,PaidAmount,ChangeAmount,TotalAmount; RefundActivity includes ID,Method,TotalAmount. Methods use existing cash/wallet/debit_card/qris/point/transfer constants; refunds never accept point.

- [ ] Write TestSummarizeCashAndNoncash: opening100000, cash paid100000/change20000/total80000, QRIS50000, cash refund10000, transfer refund5000 => cash_sales80000, cash_refunds10000, expected170000; sale_count2/refund_count2; QRIS/transfer breakdown independent.
- [ ] Write TestRefundStatusDoesNotDoubleSubtract: original cash10000 later fully refunded plus cash refund10000 => expected equals opening, not opening-10000. Use a separately supplied older-sale refund in the new session => only new session cash decreases.
- [ ] Write zero/short/surplus fixtures: expected170000/count169000 => difference-1000, blank reason rejected; count171000 => +1000; equal accepts blank. Expected-100/count0 => difference100 with reason required. Empty/501-rune mismatch reason and negative count rejected.
- [ ] Write max-boundary/overflow cases using multiple near-limit receipts, paid<change, invalid method, invalid amount, legacy cancelled/refunded revision0 and missing IDs. Unsupported historic data gives explicit domain error, not a fabricated total.
- [ ] Write TestClosePreviewHash: order-equivalent activity gives same hash; changed count/reason, receipt/refund identity, method or money changes it; trim reason canonically. Include large integer arithmetic safe for web/JSON.
- [ ] Run `go test ./internal/cash -run 'TestSummarize|TestClosePreview|TestRefundStatus' -count=1`; expect RED for absent types/functions.
- [ ] Implement pure calculations with math/big intermediate sums, signed checked results, sorted method output and SHA-256 canonical snapshot/selection binding. Run focused tests; expect GREEN.

### Task 2: Additive schema and scoped detail/history reads

**Files:** New migration000012 up/down, reconciliation_repository.go/read tests; modify cash/entity.go, Makefile, migrations tests.

**Interfaces:** ReconciliationRepository.Detail(ctx,outletID,sessionID string)(SessionRecord,error); List(ctx,outletID string,page,pageSize int)([]SessionRecord,int64,error); PreviewSnapshot(ctx,outletID,sessionID string)(SessionSnapshot,error). SessionRecord exposes original session metadata plus nullable Closing *ClosedReconciliation; open detail includes current summary/eligibility, legacy closed detail has no invented summary. ClosedReconciliation stores summary, counted/difference/reason, close actor/time/request and preview hash.

- [ ] Add isolated-loopback PostgreSQL fixtures applying all migrations in a random schema, using the existing guarded test-DSN pattern. Test old open/closed session data survives, old opening/current behavior survives, closure metadata is null for legacy rows, and foreign-outlet detail/list are scoped.
- [ ] Test consistent open summary and paginated count without joins multiplying receipts/refunds. Closed records must use stored immutable summary JSON. Capture opener name in new closing snapshots; legacy opener display may resolve current user name.
- [ ] Run `go test ./internal/cash ./migrations` with privately loaded DIKASA_TEST_DATABASE_URL; expect RED for absent schema/reads.
- [ ] Add nullable closed_by UUID FK users, closed_by_name TEXT, closing_reason VARCHAR(500), expected_cash BIGINT, cash_difference BIGINT, close_request_id UUID, close_payload_hash CHAR(64), close_preview_hash CHAR(64), closing_summary JSONB. Add unique(outlet_id,close_request_id) partial index, signed amount checks and all-or-none new closure metadata check requiring status=closed and closing_cash-expected_cash=cash_difference. Preserve legacy all-null closed rows. Use numeric cast for check arithmetic to avoid SQL overflow. Down refuses removal when new reconciliation records exist.
- [ ] Implement repeatable-read read-only open snapshots using separate session-linked receipt/refund reads; closed detail/list use persisted JSON. Bound page1..1000000/page_size1..100 (default20), stable opened_at DESC,id order. Use a separate repository type/constructor rather than breaking cash.Repository.
- [ ] Add migration000012 to Makefile in correct forward/down order with single-transaction application. Run Go migration/read tests; expect GREEN and temporary-schema cleanup.

### Task 3: Authorized atomic close and immutable recovery

**Files:** New reconciliation_service.go/service_test.go; extend reconciliation_repository.go/postgres tests.

**Interfaces:** ReconciliationAccounts.FindByIDWithRole(context.Context,string)(*user.User,error); NewReconciliationService(repo,accounts); service Detail(ctx,actorID,sessionID), List(ctx,actorID,page,size), Preview(ctx,actorID,sessionID,CloseSelection), Close(ctx,actorID,sessionID,CloseCommand). Repository Close(ctx,outletID,actorID,sessionID string,command CloseCommand)(ClosedReconciliation,error). Define errors for forbidden, notfound, unsupported, invalid, stalepreview, alreadyclosed and requestused.

- [ ] Service tests: active cashier opener succeeds, different cashier refuses, same-outlet manager succeeds; foreign outlet404, other/inactive roles403. Reads available only to outlet cashiers/managers. No request-supplied actor/outlet accepted.
- [ ] DB tests: close matched/short/surplus, same UUID exact replay after session closed and after a new session opens, altered payload/actor or request reused for another session409, two simultaneous same-ID closes one result, distinct intents one winner. Assert new open session remains untouched.
- [ ] DB tests: fresh sale/refund after preview invalidates hash, selected reason/count bound; old sale refunded in later session changes only later expected cash; stored older closing summary remains byte-equivalent. Legacy evidence gap prevents closure and leaves session open.
- [ ] Run focused service/DB tests; expect RED for absent close behavior.
- [ ] Implement authenticated account/UUID/bounds checks and opener-or-manager check. For repository close, acquire outlet/request advisory transaction lock, find request across scoped sessions and replay immutable success before current-state checks, then lock target session FOR UPDATE. Re-read activity after lock under READ COMMITTED, rebuild preview, validate hash and permission, persist one closure and response. Never write original transactions/refunds or a replacement session.
- [ ] Inject a database write failure and assert no partial closure metadata/status; validate all new constraints directly. Run focused service/DB tests; expect GREEN.

### Task 4: Synchronize checkout/refund writers with closure

**Files:** Modify payment/repository_gorm.go; add session_lock_test.go/PostgreSQL fixtures; extend cash integration tests if shared fixture is simpler. Inspect refund/repository_gorm.go without changing its replay semantics.

**Consumes:** Task3 session row-lock protocol; existing payment.Transaction.CashSessionID and savedorder.LockForCheckout.

**Produces:** Ordinary payment CreateTransaction refuses an identified closed/wrong-outlet session inside the write transaction. Existing ErrCashSessionNotFound maps to stable session error; no frontend payment signature changes.

- [ ] Write a PostgreSQL regression: service preflight selects sessionA; closeA succeeds; payment repository CreateTransaction targetingA returns session error and creates no receipt/items/stock movements, with or without a saved order. A newly openedB must not capture that prepared payment automatically.
- [ ] Write synchronization tests using separate DB connections and explicit channels/locks: payment holds shared session lock then commits => close waits and its old preview conflicts; close commits first => later payment refuses. Equivalent refund race either commits before close (causing stale preview) or fails after closure; no movement lands after the frozen session summary.
- [ ] Test saved-order payment replay/recovery after close still returns its original receipt; refund exact-ID replay after close still returns original refund. Test failed checkout leaves saved draft and inventory intact.
- [ ] Run tests; expect RED for payment's missing transaction lock.
- [ ] Inside payment CreateTransaction, after saved-order lock/recovery checks and before receipt creation, SELECT target cash session by id/outlet/status=open FOR SHARE. Map no row to ErrCashSessionNotFound. Do not change original session ID or retry under a different one. Existing refund FOR SHARE remains the writer protocol; closure never locks receipt/product/draft rows, avoiding inverse dependencies.
- [ ] Update SQL-mock expectations only where necessary and run cash/payment/refund/savedorder suites plus actual race fixtures; expect GREEN.

### Task 5: HTTP contracts, startup and API examples

**Files:** New cash/reconciliation_handler.go/test.go; modify server/router.go/tests, cmd/api/main.go or actual dependency builder, cmd/openapi/main.go, OpenAPI, api/bruno/cash-sessions requests/environment.

**Interfaces:** NewReconciliationHandler(*ReconciliationService); RegisterReconciliationRoutes(huma.API,*ReconciliationHandler). Existing cash.NewHandler and Provider stay unchanged. New server dependency CashClosingHandler *cash.ReconciliationHandler.

- [ ] Contract tests: authenticated GET list/detail, POST preview and close; missing auth401, foreign404, permission403, invalid422, stale/alreadyclosed/requestused409; assert shared error envelope. Preserve `/cash-sessions/current` and open endpoint schema.
- [ ] Run handler/router tests; expect RED for unregistered endpoints.
- [ ] Register GET /cash-sessions, GET /cash-sessions/{session_id}, POST /cash-sessions/{session_id}/close/preview and POST /cash-sessions/{session_id}/close. Preview body counted_cash/reason; close additionally request_id UUID and preview_hash64. Return200 for preview/close including replay; list data/meta and detail data. Close output carries session ID, closing data and request UUID, never hidden hashes/internal errors. Add stable codes SESI_KAS_PRATINJAU_BERUBAH, SESI_KAS_SUDAH_DITUTUP, REQUEST_ID_DIGUNAKAN, REKONSILIASI_TIDAK_DIDUKUNG and safe validation/permission errors.
- [ ] Wire startup/generator/test fakes. `go generate ./internal/server` and focused tests must PASS. Add Bruno list/detail/preview/close/replay/stale requests with auth variables and assertions; retain fixed session UUID/body for retries and separate opening of a new session.

### Task 6: Flutter boundary, command controller and shared POS lock

**Files:** New models/cash_reconciliation.dart, services/cash_reconciliation_service.dart, cash_closing_controller.dart and tests; modify pos_service.dart, view_model.dart, saved_order_actions.dart and generated MobX.

**Interfaces:** CashReconciliationService(ApiClient) with sessions({page=1}), detail(id), preview(id,selection), close(id,command). Typed CashSessionRecord, CashSummary, CashClosePreview, CashClosedRecord, CashSessionPage. CashCloseUncertainException and stable-code CashReconciliationApiException. PosService.cashReconciliation reuses its _client. CashClosingController accepts service/accountId/acquire/release/onCommitted; exposes load, setCountedCash, setReason, preview, confirm, retryPending, resolvePending; result includes original closed session ID and close_request_id.

- [ ] Service tests: typed signed differences, nullable legacy summary, unchanged stable409 codes, malformed close200/network/5xx => uncertain; detail open/notfound is not proof close failed. Commands use counted_cash/reason/request_id/preview_hash only.
- [ ] Controller tests: zero count valid, reason required for differences, edit invalidates preview, duplicate submit blocked, stale retains count/reason but requires refreshed preview. On uncertainty freeze exact UUID/body; lookup accepts only same-session/same-request closed result. Another close's UUID is a conflict, not success. New session opening cannot redirect pending close.
- [ ] Test late detail/preview/close/recovery replies after account switch; no old result/refresh or session/cart clearing. A catalog/current-session refresh failure after accepted closure cannot misclassify closure or send a fresh command.
- [ ] POS tests: owned close lock blocks payment/refund/draft/cart mutation and lock/logout action; unrelated owner cannot release it. Closure preserves active cart lines/notes and saved-order links. On success refresh currentCash (possibly another device's new session) rather than blindly clearing a now-new session. Do not automatically set/open next opening cash.
- [ ] Run focused tests; expect RED for absent boundary/controller.
- [ ] Implement secure UUIDv4 and frozen command following refund patterns. Add cashClosingActive owner guard and incorporate it into existing draftLocked/beginRefund/openCash checks; do not treat loading history as a mutation. Reset only with existing account-change handling; regenerate MobX via existing build_runner command. Run focused tests and payment/refund/saved-order regressions; expect GREEN.

### Task 7: Cashier screens and mock session parity

**Files:** New widgets/cash_sessions_dialog.dart, cash_closing_dialog.dart, mock_cash_sessions.dart and widget/mock tests; modify view.dart menu, mock_api_interceptor.dart and mock_refunds.dart attribution.

**Interfaces:** CashSessionsDialog.show(context,vm) offers current and paginated history/detail; CashClosingDialog.show(context,vm,sessionID) returns accepted closed record. MockCashSessions owns session open/current/list/detail/preview/close/replay and reads existing mock orders/refunds by immutable cash_session_id. Expose read-only activity from MockRefunds; do not duplicate inventory state.

- [ ] Widget tests: menu opens Sesi Kas, current/history can be read, other cashier read-only, legacy closed displays unknown reconciliation. Enter cash count and discrepancy reason, preview correct signs/amounts, confirm exactly once; stale/recovery states remain actionable and uncertain flow cannot be dismissed accidentally.
- [ ] Mock tests: opening100000 + cash80000 + cash refund10000 =>170000; noncash and later-session older-sale refunds affect correct rows; exact replay and later new-session opening leave prior summary unchanged. Cash sale80 after tender100/change20 =>80 inflow. Reject close without valid permissions/session; stale preview cannot close.
- [ ] Run focused tests; expect RED.
- [ ] Implement menu entry and paginated current/history/detail using existing styling, Rupiah formatter and shared client. Show positive surplus/negative shortage explicitly, current/closed actors and timestamps, separate noncash totals, unsupported legacy warning. Retain count/reason on refresh. Confirm action says Tutup Sesi Kas; no automatic carry-forward or reopening action.
- [ ] Refactor mock current/open route handling through shared session ledger; assign session IDs on sale/refund registration, including immutable refund session association. Mock confirmation synchronously validates before mutating. Existing refunds should still require actual open mock session. BigInt constants must parse from strings when outside JavaScript safe literal range.
- [ ] Capture current/history/close matched/discrepant/closed/recovery at desktop and narrow widths with real fonts; inspect PNGs and no render exceptions. Run mock/widget/checkout/refund/saved-order regressions; expect GREEN.

### Task 8: Review, accountability, final checks and controlled migration

**Files:** New docs/development/cash-reconciliation.md; update OpenAPI/Bruno, docs/architecture/DIKASA.drawio, both READMEs, CASH_CLOSING_IMPLEMENTATION_LOG_2026-10-24.md, CHANGELOG.md, FEATURE_HISTORY.md and BACKLOG.md.

- [ ] Direct review without subagents: check original/cross-session amounts, signed safe ranges, legacy handling, role/owner scoping, immutable JSON, advisory/session lock ordering and account/uncertain guards. Add regression tests before fixing material findings; record rulings and any plan deviations in the work log.
- [ ] Extend Draw.io source additively (preserve seven existing pages) with actual new nullable columns/checks/unique request index and cash-session receipt/refund relationships. Document original receipt cash, independent return method, frozen past summaries and manual counted cash. Validate local links, XML and Bruno bodies/assertions without real credentials.
- [ ] Run `go generate ./internal/server`, `go test ./...`, then opt-in isolated PostgreSQL cash/payment/refund/migration coverage with privately loaded loopback DSN. Require PASS and no leaked random schemas. Never run down migration against user data or close a real application session for testing.
- [ ] Run `flutter test --no-pub`, `flutter analyze --no-pub`, `flutter build web --no-pub`. Require enabled tests PASS, zero analyzer issues and successful browser compilation; record exact counts/skips and build evidence. Run Windows-aware git diff --check in both repos, without forcing line-ending rewrites.
- [ ] After temporary-schema migration and all checks pass, verify loopback app destination and whether migration000012 exists, then apply only that additive up migration with psql single transaction/ON_ERROR_STOP. Record schema state without printing credentials. Preserve existing real open/closed sessions and the8081 process.
- [ ] Mark POS-07 delivered only after actual checks; log all boundaries, tests/races/screens, migration state, retained records (none expected), limits and restart instructions. Preserve CUST-02 deferred and sales reports unimplemented. No commits/pushes/deployment.

## Self-review and handoff

Spec mapping: money/signed limits and preview binding Task1; additive/legacy history
Task2; authorization/atomic immutable close/recovery Task3; concurrent writer safety
Task4; versioned authenticated contracts Task5; account-bound command/POS preservation
Task6; cashier/history/mock behavior Task7; artifacts/verification/local rollout Task8.

Interfaces remain acyclic: cash reconciliation reads session-linked SQL activity;
payment adds only a cash_sessions lock and need not import cash/refund. Existing cash
opening/current Provider/Repository do not gain methods, avoiding unrelated fake churn.
Both real and mock service outputs use the same typed JSON names. Existing minimal
CashSession used by ordinary payment remains compatible; richer history uses its own
model. Pure Go helper tests own amounts; real PostgreSQL concurrency fixtures own
serialization assertions rather than attempting to prove locks with SQL mocks.

Implementation completed inline on24 October2026 without subagents. The original
planning bullets above preserve intended checks; actual consolidated tests and
verification are recorded in CASH_CLOSING_IMPLEMENTATION_LOG_2026-10-24.md and
CASH_CLOSING_WORK_LOG.md. New closure columns live in a focused repository row
instead of expanding the original Session entity; existing interfaces stay intact.

- [x] Task1: pure calculation and preview binding
- [x] Task2: additive schema and scoped reads
- [x] Task3: authorized atomic close and immutable recovery
- [x] Task4: checkout/refund writer synchronization
- [x] Task5: HTTP contracts/startup/API examples
- [x] Task6: Flutter boundary/controller/POS lock
- [x] Task7: screens/mock parity
- [x] Task8: review/docs/final verification/local migration
