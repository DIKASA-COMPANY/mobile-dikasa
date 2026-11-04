# Figma Sales Reports Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking. Execute inline without subagents, including review, as requested by the user.

**Goal:** Deliver the first four Figma sales reports with accurate refund-date totals, historical categories, usable filters/charts and real XLSX export.

**Architecture:** A focused Go reports package reads original receipts and current-period refund events under consistent database snapshots and calculates shared report totals/groups. New category snapshots are derived inside checkout. Flutter uses the existing authenticated client to render the four Figma layouts with account/request guards and shared mock activity.

**Tech Stack:** Existing Go, GORM/PostgreSQL, Gin/Huma, math/big, archive/zip/XML; Flutter/Dart, Dio, MobX/providers, flutter_svg, Poppins, FilePicker and a data-driven CustomPainter chart. No added dependency/service.

**Spec:** [Approved reporting design](../specs/2026-10-24-sales-reports-design.md).

Paths below are relative to the parent Dikasa workspace. Backend commands run in be-dikasa; Flutter commands run in mobile-dikasa.

## Global Constraints

- Scope: Ringkasan Penjualan, Metode Pembayaran, Penjualan Per Produk and Penjualan Per Kategori, with real export.
- Work inline, no subagents or commits; preserve prior uncommitted work and update accountability documents.
- Sales belong to original paid_at; refunds belong to their own created_at, even for receipts outside the chosen range.
- Use explicit Asia/Jakarta/WIB report dates, default today. Inclusive calendar start/end become [start midnight, next midnight after end) UTC bounds. Maximum366 dates.
- Original-money snapshots only. Never substitute today's catalog price/cost/category or erase a sale because it was later refunded.
- Replace Figma Laba Kotor with Refund; no historical profit/COGS calculation.
- Leave pre-migration category snapshots null and group as Kategori historis tidak tercatat. No guessed backfill.
- New checkout derives category snapshots from validated, locked catalog state; clients cannot supply historical category authority.
- Authenticated /dikasa/v1 routes; current outlet only, active cashiers/managers may read/export. No cross-outlet permission is introduced.
- Money/aggregate integers bounded within +/-9007199254740991 using checked intermediates. Refund-only periods can be negative.
- Export literal text and numeric XLSX cells with filters, definitions, timezone and generation time; no formula execution.
- Reuse original Figma static assets or exact existing matches, with local assets only; render API-driven charts dynamically.
- Preserve cart/saved-order contents, cash closing/refund behavior and original receipt values. Reporting itself is read-only.
- Other Figma report types, customer management, cash-in/out, profit, PDF/printing and general accounting remain outside scope.
- Verify in temporary PostgreSQL schemas before applying only additive migration000013 locally. Preserve normal8081 process and real data.
- No new dependencies, commits, pushes or deployment.

## Review Focus

1. A Wednesday cash refund of a Monday QRIS sale must appear Wednesday and in the cash-return method, including when Monday is outside the range: Tasks1/3 pin independent date/method rules.
2. Two partial refunds must not multiply original sale/group totals or change original prices: Tasks1/3 assert exact header/line/group conservation.
3. Editing category/name/price after checkout must not rewrite the historical category report; legacy unknowns must remain visibly unknown: Tasks2/3 cover this.
4. A WIB midnight event, leap year or refund-only/no-sale period must not shift dates, divide by zero or clamp negative values: Tasks1/6 cover this.
5. Fast filter changes or account switches must not show/export an old account's data, and report navigation must preserve its cart: Tasks6/7 cover every async boundary.

## File map and shared contracts

- New be-dikasa/internal/reports/{entity,filter,calculate}.go and focused tests: domain, WIB dates, exact original allocations and shared aggregates.
- New internal/reports/{repository_gorm,service,handler}.go plus tests: snapshot reads, authorization, pagination/search/sort and HTTP.
- New internal/reports/export.go/export_test.go: one literal-cell XLSX writer for all four report types, following existing catalog workbook conventions.
- New migration000013_add_sale_category_snapshots.{up,down}.sql; modify payment/entity.go and repository_gorm.go; add catalog/sale_categories.go with checkout snapshot helper/tests; update Makefile/migration tests.
- Modify server/router.go, cmd/api/main.go, cmd/openapi/main.go and schema/router tests: ReportsHandler dependency and route registration.
- New Flutter data/models/sales_report.dart, data/services/report_service.dart and report_files.dart; expose PosService.reports from its existing authenticated client.
- Implement the empty features/report/main.dart and add view_model.dart, widgets/report_header.dart, report_selector.dart, summary_chart.dart and report_tables.dart. Integrate cashier menu entry.
- New core/network/mock_reports.dart; extend mock sale category capture and report routing using current mock sales/refunds without copied inventory.
- New focused Go/PostgreSQL/Flutter/service/controller/widget/mock/export tests; API/Bruno/ERD/docs/logs in Task8.

Shared types: Kind enum values summary, methods, products, categories. Filter has
StartDate,EndDate,Query,Sort string; Page,PageSize int. Window has Start,EndExclusive
time.Time; StartDate,EndDate,Timezone string. Snapshot has original []Receipt and
[]RefundEvent plus GeneratedAt. Receipt wraps original payment.Transaction (including
category snapshots) and InRange bool. RefundEvent wraps original refund header/items;
its parent receipt is available in Snapshot even when that sale is outside the range.

Totals JSON: gross_sales, discount_amount, sales_after_discount, charged_sales,
refund_net, refund_tax, refund_amount, net_sales, sale_tax, net_tax,
value_after_refunds, sale_count, refund_count, sold_quantity, returned_quantity,
net_quantity, average_transaction (nullable rounded whole Rupiah), excluded_receipts,
unknown_category_quantity. Six summary cards: gross_sales, refund_amount, net_sales,
average_transaction, sale_count, sold_quantity. Methods rows: method, sale_count,
sales_amount (charged), refund_count, refund_amount, net_amount.

Daily rows: date, sale_count, charged_sales, refund_amount, net_sales. Product/group
rows: stable key, original product/variant/category IDs and snapshot name as relevant,
sold_quantity, returned_quantity, net_quantity, gross_sales, discount_amount,
sales_after_discount, sale_tax, refund_net, refund_tax, refund_amount, net_sales,
net_tax, value_after_refunds, unit_price_min/max (products only). Unknown category key
is a reserved non-UUID token, not a forged category identity.

Response envelope: data{kind,totals,daily,methods,rows}; meta{start_date,end_date,
timezone,generated_at,page,page_size,total}. Each endpoint fills its applicable arrays
with [] rather than null. total counts grouped table rows; summary total is daily rows.
Group search limits rows AND totals, pagination limits rows only. Summary/methods do
not accept search; report filters are endpoint-validated, not silently ignored.

### Task 1: WIB dates and exact aggregation engine

**Files:** Create reports/entity.go, filter.go, calculate.go and corresponding tests.
**Interfaces:** NormalizeFilter(kind Kind,f Filter,now time.Time)(Filter,Window,error);
Calculate(kind Kind,s Snapshot,f Filter,w Window)(Report,error). Report contains
Totals,Daily,Methods,Rows and metadata defined above. Reuse refund.Allocate for original
line discounts/tax; reports may import payment/refund, never the reverse.

- [ ] Write date tests: 2026-10-24 WIB begins 2026-10-23T17:00:00Z; an event at end-exclusive is excluded. Leap2024 Feb29 works; reversed dates, malformed YYYY-MM-DD and367 dates fail;366 succeeds. Empty dates default to the provided clock's WIB date.
- [ ] Write fixture: Monday QRIS sale subtotal300/discount30/tax27/charged297, three units. Wednesday one-unit cash refund net90/tax9/total99. Monday report gross300/net270/refund0/count1; Wednesday gross0/net-90/refund99/value-99/sale_count0/average null, cash method refund99 and no QRIS sale. Combined report net180/net_tax18/value198; sold3/returned1/net2.
- [ ] Assert largest-remainder/cumulative original fixtures including Rp1 tax, free items, separate base/variation IDs and repeated partial refunds. Header/line/product/category totals reconcile exactly; original totals never fan out through refund joins.
- [ ] Test empty periods/daily zero-fill, method independence, signed totals, max/overflow, unsupported original snapshots and legacy cancelled/refunded revision0 exclusion counts. Product name/price ranges come from original snapshots; unknown-category units remain counted and grouped explicitly.
- [ ] Run `go test ./internal/reports -count=1`; expect RED for missing domain/engine.
- [ ] Implement checked math/big sums/rounding, embedded time/tzdata for IANA timezone on Windows, consistent labels and deterministic row identities/names. Most-recent original paid_at then item ID chooses a display name; price min/max includes original lines contributing sale or refund activity. Query matches original product+variant/category display names; sort whitelist quantity_desc/net_desc/name_asc, with stable key tie-breaks. Bound page1..1000000/page_size1..100 (default20).
- [ ] Run focused tests; expect GREEN. Search-filter totals derive from all matching groups, including refund-only groups; do not compute totals from a paginated page.

### Task 2: Server-derived category snapshots at checkout

**Files:** New migration000013 up/down and catalog/sale_categories.go/tests; modify payment/entity.go/repository_gorm.go and tests, Makefile/migration tests.
**Interfaces:** TransactionItem gains CategoryIDSnapshot *string and
CategoryNameSnapshot *string, persisted as category_id_snapshot/category_name_snapshot.
Catalog SaleCategory{ID,Name string}; CaptureSaleCategories(ctx,tx,outlet string,
items []StockSaleItem)(map[string]SaleCategory,error), keyed by parent product ID.
Caller must already hold product locks acquired by DeductSaleStock.

- [ ] Write PostgreSQL/checkout tests: sale records actual server category on base and variant lines; spoofed extra client category fields cannot control it. Renaming/reassigning product category after checkout leaves receipt snapshot unchanged. Old items remain null and report in unknown bucket.
- [ ] Test disabled/deleted category during checkout yields existing catalog error and rolls back receipt/items/stock/saved-draft transition. Verify concurrent category rename either precedes snapshot or waits for its category shared lock, with a consistent committed name.
- [ ] Run tests with isolated schema; expect RED for absent columns/helper.
- [ ] Add nullable UUID/name snapshot columns with both-null-or-both-present/nonempty-name check. Do not backfill/FK to mutable category history. Down refuses dropping populated snapshots. Makefile adds000013 forward/reverse single-transaction order.
- [ ] After DeductSaleStock inside payment transaction, read the now-locked parents, lock distinct category IDs FOR SHARE in sorted order and validate outlet/active state. Capture ID/name and fill original item snapshots before INSERT. Do not change existing stock helper's public signature. Keep payment/refund/cash/saved-order lock/replay semantics.
- [ ] Update necessary SQL-mock expectations and run checkout, stock, saved-order, cash/refund and migration suites; expect GREEN. Mock snapshot capture follows in Task7.

### Task 3: Consistent report reads and outlet authorization

**Files:** Create reports/repository_gorm.go, service.go and PostgreSQL/service tests.
**Interfaces:** Repository.ReadSnapshot(ctx,outletID string,w Window)(Snapshot,error);
NewGORMRepository(*gorm.DB). Accounts.FindByIDWithRole(ctx,id)(*user.User,error).
Service.Read(ctx,userID string,kind Kind,f Filter)(Report,error) normalizes filters,
scopes active cashier/manager and calls Task1 engine. Inject clock for deterministic
default date. Snapshot never joins current catalog prices/categories for history.

- [ ] Create guarded loopback temporary-schema fixtures applying all migrations, following existing cash/refund patterns. Create own marked sale/refund/category fixtures only there.
- [ ] Test selected-date receipts, selected-date refund headers/items and their older original parent receipts are all included without duplication. Return InRange=false for out-of-range parent sales so they supply identity/line evidence only. Header/refund values appear exactly once; grouped sums and row counts match pure fixtures.
- [ ] Test inactive/other-role403, other-outlet IDs/data absent, original inactive/renamed product still reported, unknown-category bucket, legacy exclusion notices, pagination/sort/search totals and generated timestamp. Verify a consistent read cannot mix a new refund header with missing items.
- [ ] Run focused service/PostgreSQL tests; expect RED.
- [ ] Implement one repeatable-read read-only transaction: query receipt IDs paid in window and refund headers created in window, union parent IDs, load original headers/items and selected refund items separately. No broad transaction-item/refund join that multiplies rows; all predicates include outlet. Calculate from that snapshot and set generation timestamp consistently.
- [ ] Run `go test ./internal/reports` plus opt-in PostgreSQL tests; expect GREEN. Leave original receipts/refunds/categories and user sessions untouched.

### Task 4: Authenticated endpoints and genuine XLSX export

**Files:** Create reports/handler.go/export.go and contract/workbook tests; modify server/router.go, cmd/api/main.go, cmd/openapi/main.go, router/schema fixtures, OpenAPI and Bruno report examples.
**Interfaces:** Service.Export(ctx,userID string,kind Kind,f Filter)([]byte,error)
uses the same snapshot/calculation, all matching rows, and report definitions metadata.
NewHandler(*Service); RegisterRoutes(huma.API,*Handler); ReportsHandler dependency.

- [ ] HTTP tests for GET /reports/summary, /reports/methods, /reports/products, /reports/categories and /reports/{report_kind}/export.xlsx beneath /dikasa/v1. Assert role/auth/errors, filter validation, date/timezone/generation metadata, integer/nullable averages and empty arrays. Unsupported kind/filter422; no leaks on internal errors.
- [ ] Write workbook ZIP/XML assertions: real XLSX content type/disposition, same query/window/kind semantics, all rows beyond first page, exact numeric values including negatives, definitions/WIB/generation metadata; names like =HYPERLINK(...), +SUM(...), @... remain literal inline strings with escaped XML and no formula nodes.
- [ ] Run contracts/export tests; expect RED.
- [ ] Implement shared per-kind Report response and one report XLSX writer using standard-library ZIP/XML conventions from catalog/export.go. Numeric integer cells stay numeric, labels/text stay inlineStr. Use Excel column references correctly beyondZ if needed, deterministic ZIP member order, and explicit report title. Do not alter the existing product workbook contract for convenience.
- [ ] Wire authenticated router/startup/schema dependencies. Validate dates/query/sort/page and reject extraneous search on summary/methods. Export ignores page slicing intentionally while retaining search/sort/date scope; document fresh generation time versus previous screen snapshot.
- [ ] Generate OpenAPI with `go generate ./internal/server`; add Bruno success/empty/invalid-range/outlet-safe export examples with variable dates and assertions. Run backend contract/schema/export tests; expect GREEN.

### Task 5: Figma assets and Flutter reporting data boundary

**Files:** New models/sales_report.dart, services/report_service.dart, services/report_files.dart and tests; modify PosService getter; new local report assets only where missing.
**Interfaces:** ReportKind enum summary/methods/products/categories; ReportFilter
with yyyy-MM-dd dates/query/sort/page and request serialization; typed ReportData,
ReportTotals,DailyReportPoint,PaymentMethodReportRow,SalesGroupReportRow,ReportMeta.
ReportService(ApiClient).read(kind,filter), export(kind,filter)->Uint8List.
ReportFiles.saveWorkbook(bytes,{required filename})->Future<bool> uses FilePicker.

- [ ] Inventory stored high-fidelity design contexts/screenshots for frames1:3998/4204/4309/4450. Reuse task Figma session4a2cd29c-835f-4dc1-9c54-63ced2610c44, or create a new session only if inaccessible. If references expire/incomplete, refresh context via figma-design-to-code skill; request screenshot with it. Do not build from sparse output alone.
- [ ] Record visible static design node -> exact local asset -> callsite -> intended root/effective geometry in a manifest. Inspect existing assets/icons/reports_* and shared header/calendar/search/export/lock assets first. Download only missing static assets using the context's download instructions. Reference screenshots are visual targets, never runtime assets; chart grid/lines/markers driven by real data use chart code rather than example image downloads.
- [ ] Service/model tests: valid signed money/counts/null average, empty arrays, preserved filter/meta, schema/malformed values become parsing errors, server business errors retained; export requests bytes and exact filters without page slicing. File cancel returnsfalse without pretending a file was saved.
- [ ] Run focused Flutter tests; expect RED for absent boundary.
- [ ] Implement typed parsing with safe integer checks, use PosService.reports on its existing _client, isolate file saving with report/date filenames. No new auth client/provider/dependency or access outside current outlet.
- [ ] Run service/model tests; expect GREEN. Verify each required static asset exists locally and manifest excludes temporary runtime URLs.

### Task 6: Request-safe report state and cashier navigation

**Files:** New features/report/view_model.dart/tests; modify cashier view.dart menu and implement report/main.dart entry wiring. Keep existing cart store signatures compatible.
**Interfaces:** ReportViewModel(service,accountId,clock) extends ChangeNotifier;
fields kind/filter/report/loading/exporting/error; methods setKind, setDateRange,
setQuery,setSort,setPage,reload,export; account/request generations guard every await.
SalesReportsView({service,files,user,accountId}) is pushed from existing cashier
menu using vm.posService.reports and current account getter.

- [ ] Tests: default today based on WIB even when device date differs, inclusive leap range validation, switching report preserves date but resets irrelevant query/sort/page. Older search/filter replies cannot overwrite the latest; account change/dispose blocks late data/errors/export file handoff. No export of a stale account result.
- [ ] Test zero/refund-only signed values and null average renderable. Changing search affects full filtered totals; changing page preserves them. Export uses a captured report/filter/account intent and suppresses file handoff after any account change; prevent duplicate export taps.
- [ ] Navigation/POS tests: enter reports/back with a nonempty cart and saved-order metadata unchanged; reading does not acquire refund/close mutation locks or change stock/session state. Existing lock/logout behavior remains protected during uncertain POS writes.
- [ ] Run focused tests; expect RED.
- [ ] Implement account-scoped generations, filter normalization and current-user checks before dispatch and after responses. Add Laporan menu entry using existing navigation patterns; existing read-only report browsing may preserve an unpaid cart. Do not navigate away from in-flight/uncertain payment/draft/refund/close flows that require resolution.
- [ ] Run focused state/navigation and existing POS regressions; expect GREEN.

### Task 7: Four Figma screens, dynamic chart and shared mock parity

**Files:** Implement report/main.dart; new widgets/report_header.dart, report_selector.dart, summary_chart.dart, report_tables.dart and widget/capture tests; new core/network/mock_reports.dart and tests; modify mock_api_interceptor.dart/mock_refunds.dart sale snapshot capture.
**Interfaces:** Report widgets consume Task5 typed data and Task6 state. DailySalesChart
receives DailyReportPoint[] with independent transaction/Rupiah scales plus accessible
daily values. MockReports reads existing orders/refund records, filters the same WIB
window and produces real DTO shapes; it never owns a copied inventory/sales ledger.

- [ ] Widget tests: date picker/search/sort/pagination trigger correct reads; four report selectors switch active layout; refund-only negative values and null averages remain explicit; loading/empty/error retry work; export save/cancel and duplicate taps behave correctly.
- [ ] Write mock parity fixtures matching Task1 Monday/Wednesday QRIS/cash refund values. New mock sales copy category ID/name during successful sale registration, not at read time; later mock category edits do not rewrite snapshots. Repeated partial refunds total exactly once. Search/sort/pages and full XLSX export use the same results.
- [ ] Run widget/mock tests; expect RED.
- [ ] Build responsive layouts from Figma high-fidelity context, reusing existing AppColors/Poppins/tables and exact assets. Desktop1340x800: top bar, filter strip, main chart/table and right selector. Narrow widths: stacked controls/cards, compact selector, horizontal table scrolling. Display actual current outlet/account; no demo person/numbers or unauthorized all-outlet selector.
- [ ] Summary has six approved cards, daily chart/table and defined tax/final-value explanation; replace profit card with Refund. Product/category tables expose sold/returned/net quantities and refunds alongside gross/net values; no invented SKU or single current price when historic prices vary. Method report separates original method and actual return method. Other unfinished Figma report controls stay outside this four-report selector.
- [ ] Draw API-driven series with labeled independent units/scales; fill empty dates, allow negative net values, expose hover/tap/accessible daily values. Preserve Figma appearance without using its static example series as application data.
- [ ] Route /reports requests before generic mock fallbacks, use existing mock paid_at/ordered_at and refund.created_at consistently, BigInt allocation/bounds and literal-text workbook output. Shared mock modes remain memory-only.
- [ ] Capture all four loaded screens plus empty/error/refund-only/narrow states with real fonts and deterministic fixtures. Inspect every static asset/node slot/callsite/effective geometry and visual comparison to the four Figma screenshots; fix in-scope overflow/mismatches. Run widget/mock/POS/catalog/refund/cash/saved-order regressions; expect GREEN.

### Task 8: Review, documentation, final checks and controlled migration

**Files:** New docs/development/sales-reports.md and REPORTS_WORK_LOG.md; update OpenAPI,
Bruno, docs/architecture/DIKASA.drawio, both READMEs, REPORTS_IMPLEMENTATION_LOG_2026-10-24.md,
CHANGELOG.md, FEATURE_HISTORY.md RPT-01 and BACKLOG.md.

- [ ] Direct final review without subagents: audit time boundaries, original/refund independent dates/methods, integer/allocation conservation, unknown category handling, locks/snapshots, outlet/role scope and account/export guards. Reproduce material findings with failing regression tests before fixes; record rulings rather than silently changing scope.
- [ ] Extend Draw.io additively, preserving eight existing pages, with actual snapshot columns/check and their historical meaning. Document no category backfill/profit, exact total definitions, export freshness/WIB, unknown/legacy notices and safe sample flows. Keep Go docs, OpenAPI and Bruno synchronized for every endpoint.
- [ ] Run `go generate ./internal/server`, `go test ./...` and opt-in isolated PostgreSQL reports/checkout/catalog/refund/cash/saved-order/migrations tests. Require PASS, preserved checkout rollback/replay and cleaned temporary schemas. Do not create public application test sales/refunds.
- [ ] Run full `flutter test --no-pub`, `flutter analyze --no-pub`, `flutter build web --no-pub`; require enabled tests PASS, analyzer zero issues and successful browser compilation. Record exact pass/skip counts and visual/asset evidence. Validate XLSX ZIP/XML/literal cells, Bruno bodies, local links, ERD XML and Windows-aware git diff --check in both repos.
- [ ] Only after temporary-schema migration and checks pass, guard loopback app destination, check whether000013 exists and apply only its additive up with psql single transaction/ON_ERROR_STOP. Never backfill guessed categories or reset/down-migrate user data. Verify original receipt/category values remain unchanged and preexisting items have null snapshots; no app test fixture or normal8081 restart.
- [ ] Update feature/changelog/backlog only from actual results; log endpoints/files/tests/screens/assets/migration state and limitations. Keep profit/customer management/other report types deferred. Preserve previous uncommitted work; no commits/pushes/deployment.

## Self-review and execution handoff

Spec coverage: date/money/refund conventions Task1; historical categories and atomic
checkout Task2; consistent reads/scope Task3; endpoints/export Task4; assets/typed
client Task5; safe navigation/filter/export state Task6; four layouts/mock parity/
visual proof Task7; artifacts/review/verification/local migration Task8.

Dependency check: reports imports original payment/refund domain types and allocation,
never the reverse. Checkout snapshot helper belongs to catalog and is called only
inside existing payment transaction after product locks. It shares no report state.
Refund rows refer to unchanged original item IDs; new nullable category fields do not
alter existing preview hashes or refund snapshots. Existing cash summaries remain
immutable and reporting does not modify those ledgers. ReportFiles reuses FilePicker
conventions without changing CatalogFiles' product export naming.

Execution completed inline on24 October2026 without subagents. Original planning
bullets retain intended checks; actual consolidated tests, design adaptations and
verification are recorded in REPORTS_IMPLEMENTATION_LOG_2026-10-24.md and the work
ledger. File boundaries stayed focused; no warehouse/new dependency or commits.

- [x] Task1: WIB dates and aggregation
- [x] Task2: original category checkout snapshots
- [x] Task3: consistent reads/outlet authorization
- [x] Task4: endpoints and literal XLSX
- [x] Task5: local Figma assets and typed client
- [x] Task6: account/request-safe state and navigation
- [x] Task7: four screens/chart/shared mock parity
- [x] Task8: review/docs/final checks/local migration
