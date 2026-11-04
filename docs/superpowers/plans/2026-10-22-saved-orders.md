# Saved Orders Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [x]`) syntax for tracking. The user requires inline execution without subagents.

**Goal:** Let outlet cashiers save, reopen, edit, delete and pay persistent unpaid carts without losing work or double-paying a saved order.

**Architecture:** Add an outlet-scoped `savedorder` backend package with revision checks and immutable command replay records. Payment imports its transaction helpers to lock and complete drafts in the existing stock/receipt transaction; `savedorder` never imports payment. Flutter extends the current POS store and dialogs, with matching mock behavior.

**Tech Stack:** Existing Go/GORM/PostgreSQL, Gin/Huma, Flutter/Dart, MobX, Dio and mock interceptor. No new package dependencies.

**Spec:** `mobile-dikasa/docs/superpowers/specs/2026-10-22-saved-orders-design.md` (paths below are relative to the parent Dikasa workspace).

## Global Constraints

- Preserve prior uncommitted work and work inline without subagents.
- Saving is explicit, requires a connection and does not reserve or deduct stock.
- All routes use /dikasa/v1 and standard response/error envelopes.
- Require at most 100 lines, quantities 1..1000 and notes at most 500 characters.
- Optional order label: maximum 100 characters. Prices: integers 0..9007199254740991 with checked subtotal arithmetic, matching existing payment limits.
- Cashiers and managers can operate only on their own outlet. Cross-outlet IDs return 404.
- Updates, deletion and checkout lock the draft row and require its current revision.
- A matching successful command returns its original result; a reused UUID with different content returns 409.
- Clear the working cart only after confirmed save success. Opening requires an empty cart.
- Current outlet tax is used for checkout; the saved estimate is not a price lock.
- Apply only the new migration to the existing local database after verification; no reset.
- No commits, pushes or deployments in this increment unless separately requested. Checkpoints are plan checkboxes and retained verification evidence.

## Review Focus

1. A late save/open/payment response after logout must not clear another user's cart; Task 5 tests account switches during each request.
2. Two creates using the same UUID must create one draft even under concurrency; Task 2 integration tests command serialization.
3. A valid command replay after a later edit must return the original snapshot, not the current version; Task 2 tests immutable replay.
4. Duplicate base/variant references must not make payment matching ambiguous; Task 1 rejects duplicate product/variant keys and Task 4 tests reordered lines.
5. A refreshed catalog with a removed variation must preserve the draft until the cashier confirms removal; Tasks 5–6 cover confirmation and cancellation.

## Files and responsibilities

- `be-dikasa/internal/savedorder/{entity,errors,validation}.go`: independent domain types, validation and cart comparison.
- `be-dikasa/internal/savedorder/{repository,repository_gorm,service}.go`: outlet scope, pagination, atomic commands and replay.
- `be-dikasa/internal/savedorder/{dto,handler,routes}.go`: authenticated HTTP contract.
- `be-dikasa/internal/savedorder/checkout.go`: helpers called inside payment's GORM transaction.
- `be-dikasa/migrations/000010_add_saved_orders.{up,down}.sql`: drafts, lines, command journal; update Makefile and migration tests.
- Existing payment entity/DTO/service/handler/repository: optional draft association and checkout conflict mapping.
- Existing API startup, router, OpenAPI generator and tests: dependency wiring and schema generation.
- `mobile-dikasa/lib/data/models/saved_order.dart`, existing `pos_service.dart`: typed draft boundary and uncertain-command exception.
- Existing POS store and generated mixin: active draft/revision, save/reopen/reconcile state.
- `mobile-dikasa/lib/features/new_order/widgets/{save_order_dialog,saved_orders_browser}.dart`: focused save and browser controls.
- Existing `sales_browser.dart`, `order_panel.dart`, `payment_dialog.dart`: tab/action integration.
- `mobile-dikasa/lib/core/network/mock_saved_orders.dart` and existing interceptor: in-memory parity.
- Tests accompany each boundary; documentation/Bruno/ERD updated in Task 7.

### Task 1: Domain rules and additive schema

**Files:** Create savedorder entity/errors/validation and `validation_test.go`; migration 000010 up/down and `migrations/saved_orders_test.go`; modify Makefile.

**Interfaces:** Produces `Item` with product/optional variant IDs, snapshot names, int64 unit price, int quantity, notes and position; `Order` with identity/scope/creator, label, order type, int64 revision, status, optional transaction ID, timestamps and items; `Mutation{RequestID, Label, OrderTypeID string; ExpectedRevision int64; Items []Item}`. Produces `ValidateMutation(Mutation) error`, `SameCart(orderTypeID string, items []Item, order *Order) bool`. Errors: `ErrValidation`, `ErrNotFound`, `ErrForbidden`, `ErrConflict`, `ErrAlreadyPaid`.

- [x] Write `TestValidateMutation` table cases: 100 lines accepted/101 rejected; quantities 0/1001 rejected; 501-rune notes and 101-rune labels rejected; invalid UUIDs, negative/unsafe prices and overflowing subtotal rejected; duplicate product/variant key rejected while base plus variation accepted. Names bounded to existing 150/100 limits. Missing label allowed.
- [x] Write `TestSameCart`: line order does not matter; a changed product, variant, quantity, note, price or order type fails; duplicate keys cannot bypass comparison. Use exact integer arithmetic and normalized optional strings.
- [x] Run `go test ./internal/savedorder ./migrations` from backend. Expected: RED for missing domain functions/migration, not environmental errors.
- [x] Implement domain types, rune-aware validation, comparison and migration. Keep user-entered display text separate from authoritative outlet/catalog checks. Label fallback: `Order ` plus first 8 characters of draft UUID.
- [x] SQL: statuses open/paid/deleted; positive revision; paid iff transaction_id nonnull; unique transaction link; item position unique per draft; bounded quantity/price; UUID foreign keys; command primary key `(outlet_id, request_id)` and nonnull actor/operation/hash/immutable JSON response. Index `(outlet_id,status,updated_at DESC,id)`. Keep deleted snapshots. No internal BEGIN/COMMIT in migration.
- [x] Update Makefile forward/down ordering using `psql -1` for migration 000010. Run focused tests. Expected: GREEN; existing migrations untouched.

### Task 2: Persistent commands, outlet scope and browsing

**Files:** Create savedorder repository/service files, `service_test.go`, `repository_gorm_test.go`, `postgres_test.go`.

**Interfaces:** Consumes Task 1 domain. `AccountFinder.FindByIDWithRole(context.Context,string)(*user.User,error)`. `Repository.Execute(ctx context.Context,outletID,actorID,operation,id string,mutation Mutation)(*Order,error)`, `Get(ctx,outletID,id)(*Order,error)`, `List(ctx,outletID,search string,page,pageSize int)([]Order,int64,error)`. `NewService(repository Repository,accounts AccountFinder)*Service`; service `Create(ctx,userID string,mutation Mutation)`, `Update(ctx,userID,id string,mutation Mutation)`, `Delete(ctx,userID,id,requestID string,revision int64)` return `(*Order,error)`; `Get(ctx,userID,id)` same; `List(ctx,userID,search string,page,pageSize int)([]Order,int64,error)`.

- [x] Write unit tests showing derived outlet/actor, 404 cross-outlet reads, rejected unsupported roles/no-outlet users, bounds, and pagination page>=1/page size<=100. Run `go test ./internal/savedorder`. Expected: RED for missing service/repository.
- [x] Implement scope and command validation. Validate order type and product/variant ownership inside the mutation transaction. Allow inactive-but-existing references for saving stale drafts; never permit foreign-outlet references. Do not read or mutate stock balances.
- [x] Serialize commands by `(outlet UUID,request UUID)` using PostgreSQL transaction advisory lock derived from both UUIDs, then consult the command journal before checking draft revision. Include actor, operation, target ID, expected revision and canonical payload in SHA-256 hash. Hash collision of advisory keys merely serializes unrelated requests; journal uniqueness remains authoritative.
- [x] Lock existing draft with `FOR UPDATE`; require open status and exact revision for update/delete; increment revision once. Replace items atomically. Journal success response in the same transaction. Failed commands leave no journal entry. Replay returns stored JSON even after later updates/deletion. A changed actor/payload under the same UUID returns409.
- [x] Add PostgreSQL tests using the existing loopback-only, unique temporary-schema approach. Assertions: concurrent same-ID creates yield one draft; same-ID replay after a second edit returns original revision/items; changed payload409; competing updates one winner; update/delete one winner; cross-outlet read/update/delete404; no stock movement or paid receipt from saves; invalid references roll back all rows.
- [x] Run `go test ./internal/savedorder`; then with securely loaded `DIKASA_TEST_DATABASE_URL`, run `go test ./internal/savedorder -run TestSavedOrdersPostgres -count=1 -v`. Expected: PASS, unique test schema removed. Never print the DSN.

### Task 3: HTTP contract and API wiring

**Files:** Create savedorder DTO/handler/routes and `handler_test.go`; modify server router/tests, cmd/api/main.go, cmd/openapi/main.go and generated api/openapi.yaml.

**Interfaces:** Consumes Task 2 service. Produces `NewHandler(*Service)*Handler` and `RegisterRoutes(huma.API,*Handler)`. Add `SavedOrderHandler *savedorder.Handler` to server dependencies. All route IDs are UUIDs, JSON is snake_case. Responses `{data: OrderData}`; list `{data: [], pagination:{page,page_size,total,total_pages}}` following existing list conventions.

- [x] Write HTTP tests for authenticated create200, list/detail200, update200, delete200; unauthenticated401; malformed UUID/limits422; missing/foreign404; stale revision409; changed command payload409. Include multibyte labels/notes at and beyond the rune limits. Run `go test ./internal/savedorder ./internal/server`. Expected: RED for missing transport/wiring.
- [x] Implement POST/GET `/saved-orders`, GET/PUT/DELETE `/saved-orders/{saved_order_id}`. DELETE uses request_id and expected_revision query parameters. No outlet/creator/status fields accepted as authoritative input. `OrderData` includes created_by, creator_name, estimated_subtotal, total_quantity, revision/status, nullable transaction_id and items. List includes snapshots needed by browser.
- [x] Error codes: `PESANAN_TERSIMPAN_BERUBAH`, `REQUEST_ID_DIGUNAKAN`, `PESANAN_SUDAH_DIBAYAR` (409); generic404 for inaccessible IDs. Keep internal SQL details out of responses. Add exported Go comments and non-obvious rule comments.
- [x] Wire runtime dependencies and schema-only generator/router fixtures consistently. Run `go generate ./internal/server` and `go test ./internal/savedorder ./internal/server ./cmd/...`. Expected: PASS and OpenAPI sync test green.

### Task 4: Atomic saved-order checkout

**Files:** Create savedorder checkout.go/tests; modify payment entity/DTO/service/handler/repository and focused tests; extend savedorder postgres_test.go.

**Interfaces:** `LockForCheckout(ctx context.Context,tx *gorm.DB,outletID,id string,revision int64,orderTypeID string,items []Item)(*Order,error)` and `CompleteCheckout(ctx context.Context,tx *gorm.DB,order *Order,transactionID string) error` in savedorder. Payment `TransactionMutation`/request receive `SavedOrderID *string`, `SavedOrderRevision *int64`. Transaction receives transient fields with `gorm:"-"`; the persisted unique receipt link lives in saved_orders.

- [x] Write tests: association fields required together; revision positive; changed/reordered cart matching; missing/deleted/stale draft rejected; paid draft returns stable409. Run `go test ./internal/payment ./internal/savedorder`. Expected: RED for missing association/helpers.
- [x] Pass optional association from DTO through service to repository. Within CreateTransaction's DB transaction, lock/check draft before inserting receipt or acquiring stock locks. Convert payment item snapshots to Task 1 Item without importing payment from savedorder. Compare order type/items, ignoring payment-time table and tax fields. Use existing payment amount/cash-session validation.
- [x] After existing receipt/items/stock writes succeed, mark draft paid and link receipt using CompleteCheckout in the same transaction. Map savedorder failures through payment HTTP errors. Unsaved checkout takes the existing path unchanged.
- [x] Add PostgreSQL concurrent tests with independent connections: payment/payment yields one receipt/deduction; update/payment and delete/payment allow one valid winner; payment failure on later item rolls back draft status, all stock movements and receipt; price conflict leaves draft open; cross-outlet draft cannot pay. Lock order: command advisory lock if any, draft row, sorted product rows; no reverse acquisition.
- [x] Run focused and opt-in PostgreSQL tests, then `go test ./...`. Expected: PASS; no test paid receipts in the application's public schema.

### Task 5: Flutter service and saved-cart state

**Files:** Create data/models/saved_order.dart; modify pos_service.dart, new_order/view_model.dart and generated view_model.g.dart; create test/data/saved_order_service_test.dart and test/features/new_order/saved_order_test.dart.

**Interfaces:** `SavedOrder`/`SavedOrderItem` mirror Task 3; `SavedOrderPage`. PosService adds `savedOrders({String search='',int page=1})`, `savedOrder(String id)`, `createSavedOrder(Map<String,dynamic>)`, `updateSavedOrder(String id,Map<String,dynamic>)`, `deleteSavedOrder(String id,{required String requestId,required int revision})`. Store exposes `Future<bool> saveOrder({String? label,bool clearOnSuccess=true})`, `Future<bool> openSavedOrder(String id,{bool acceptChanges=false})`, `Future<bool> deleteSavedOrder(SavedOrder order)`, `Future<bool> reconcileSavedPayment()`, plus observable draft ID/revision/label, busy, uncertain-command and reopen-warning state.

- [x] Write HTTP/state tests: malformed envelope considered uncertain after mutation; timeout retains exact UUID/body; retry sends identical request; new deliberate edit gets a new UUID; initial save/update clears only on confirmed success; nonempty open refused; uncertain save freezes edits; base+variation/notes round-trip; stale revision retains cart and asks reload. Run focused Flutter tests. Expected: RED for missing models/actions.
- [x] Implement typed service parsing and uncertainty classification (timeouts/5xx/malformed successful mutation replies). Generate UUIDv4 using existing secure-random approach, with no new dependency. Store immutable pending command for same-ID retry. Block mutation/payment while busy or outcome uncertain.
- [x] Reopen fetches current catalog and order types before replacing an empty cart. Build candidate lines separately; removed/inactive item, missing variant, changed price or order type produces an explicit review result. `acceptChanges:true` applies only the exact reviewed candidate snapshot; do not silently accept changes from a second refresh. Short stock is a warning and preserved quantity, not silent clipping. Block pay until unresolved references are corrected.
- [x] Existing draft edits/repricing call saveOrder(clearOnSuccess:false) before checkout, then send its confirmed ID/revision. Only clear after confirmed payment. For uncertain/already-paid draft payment, fetch draft status and receipt ID; a paid draft resolves success, an open draft permits deliberate retry, a deleted/inaccessible draft remains blocked pending explicit resolution. Never fall back to unrelated unsaved pay.
- [x] Test account switches during save/open/payment: late completions cannot clear current cart, attach old draft, set errors or return old-account receipts. Reset association on clear/new cart/account change; guard asynchronous finally blocks with account/request generation. Keep unsaved-payment reconciliation tests passing.
- [x] Regenerate with `dart run build_runner build --delete-conflicting-outputs`; run `flutter test --no-pub test/data/saved_order_service_test.dart test/features/new_order/saved_order_test.dart test/features/new_order/checkout_test.dart`. Expected: GREEN; generated changes limited to intentional MobX store additions.

### Task 6: Cashier dialogs, saved browser and mock parity

**Files:** Create save_order_dialog.dart, saved_orders_browser.dart, core/network/mock_saved_orders.dart and test/features/new_order/saved_order_widgets_test.dart; modify sales_browser/order_panel/payment_dialog and mock interceptor; create test/data/mock_saved_orders_test.dart.

**Interfaces:** `SaveOrderDialog.show(BuildContext,NewOrderViewModel)`; `SavedOrdersBrowser({required NewOrderViewModel viewModel})` embedded as Tersimpan tab; consumes Task 5 models/actions. MockSavedOrders stores snapshots and command results scoped by outlet and enforces the same revisions/status/cart-match rules.

- [x] Write widget/mock tests: Simpan disabled on empty/busy cart; label entry; confirmed save clears; failure retains dialog/cart; Tersimpan listing/search/pagination; paid-history/customer views retained; open refuses occupied cart; conflict reload; delete requires confirmation; removed-variation review cancellation retains server draft; repricing requires confirmation; pending mutation cannot dismiss into editable cart. Run tests. Expected: RED.
- [x] Connect Simpan, add Dibayar/Tersimpan tabs only for order browsing, preserving customers. Use existing visual tokens/layout, no Figma import. Browser offers open/delete and clear conflict/error messages, never automatic overwrites. Add a visible active-draft label and retry/recovery controls. Ensure a reopened draft can be updated and parked again.
- [x] Extend mock interceptor to route draft APIs before generic order paths and link draft completion to mock payment. Validate all inputs/revision/cart before mock stock mutation; make synchronous commit order atomic within interceptor execution. Maintain immutable command responses and paid receipt links.
- [x] Run focused widget/mock and existing POS-flow tests. Expected: GREEN; opening stale drafts and switching tabs produce no exceptions or lost carts. Render representative saved-list and review dialogs for visual inspection at the existing desktop web viewport.

### Task 7: Documentation, migration and final verification

**Files:** Backend docs/development/saved-orders.md, README, api/README, api/bruno requests and local environment variables, docs/architecture/DIKASA.drawio; mobile README; parent SAVED_ORDERS_IMPLEMENTATION_LOG_2026-10-22.md; update this plan's checkboxes/evidence.

**Interfaces:** Consumes Tasks 1–6, no new application interface.

- [x] Add Bruno create/list/detail/update/delete requests, draft-backed payment example, replay/stale-revision assertions and variable capture for savedOrderId/revision/command UUIDs. Document new-ID versus same-ID retry rules and no stock reservation.
- [x] Add ERD page for actual saved-order tables/constraints/FKs while preserving existing pages. Document run/restart requirements, commands, recovery, no offline guarantee and general unsaved-payment limitation. Check OpenAPI examples against actual DTOs.
- [x] Run `go generate ./internal/server`, `go test ./...`, opt-in savedorder PostgreSQL tests and full migration integration tests. Expected: all PASS; opt-in schema cleanup succeeds. Retain logs without credentials.
- [x] Run `flutter test --no-pub`, `flutter analyze --no-pub`, `flutter build web --no-pub` using installed Flutter binary. Expected: all enabled tests pass, analyzer no issues, web build succeeds. Report opt-in skips explicitly. Do not rerun older live payment tests just for coverage.
- [x] Review diff directly without subagents; check authorization, command replay, transaction locks and account-generation guards. Run `git diff --check` in both repositories (using explicit git-dir/work-tree if required). Expected: no whitespace errors. Fix material findings with regression tests before claiming completion.
- [x] Apply only migration000010 with psql single transaction/ON_ERROR_STOP after safe loopback connection validation. Load credentials from existing ignored .env without printing. Verify new tables/constraints, no reset. If user API process needs restart, report it; do not stop an unrelated process. A live smoke check may save/open/delete a uniquely labelled draft; retain its soft-delete audit record and document it. No live payment required.
- [x] Write handoff log: behavior, touched boundaries, migration applied/not applied, exact test counts/commands, known limitations, review findings and retained test records. Mark only verified steps complete and link the log in final response.

## Plan self-review

Checked against approved spec: workflow, persistence, outlet isolation, replay,
concurrency, atomic payment, recovery, frontend, mock, migration and documentation
requirements each have an owning task. Shared types flow from savedorder to payment
and HTTP to Flutter without circular imports. No feature implementation, migration
execution or runtime changes occur until the user reviews this plan. Execution
method is already selected: inline, without subagents.

## Completion evidence — 23 October 2026

Implemented and verified inline without subagents. Full Flutter suite with saved
screen capture:97passed/4skipped; analyzer clean; webbuild and Wasm dryrun PASS.
Full Go suite/OpenAPI sync and opt-in saved-order/migration PostgreSQL tests PASS.
Applied migration000010 only to app database; no reset. Live unpaid API smoke test
passed and soft-deleted its fixture; temporary18081 API stopped,8081 left running.
See parent SAVED_ORDERS_IMPLEMENTATION_LOG_2026-10-23.md and SAVED_ORDERS_WORK_LOG.md.

Rulings: preserve existing checkout/uncommitted dependencies; no commits/subagents.
Use existing POS `meta` envelope. Server owns optional input line positions.
Repository tests are consolidated in postgres_test.go and service/domain tests;
existing migration integration discovers the new SQL, avoiding SQL-string mirror
tests. Some planned file splits were unnecessary: service.go declares the small
Repository interface, and validation_test.go owns domain/cart tests.
