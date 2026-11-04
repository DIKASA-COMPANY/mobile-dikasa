# Figma sales reporting — first four reports

Date: 24 October 2026 (Asia/Jakarta).
Status: approved and implemented locally on24 October2026. See the workspace reporting implementation log for actual verification and limits.
User authorized proceeding with reporting and selected refund deductions on the
actual refund date (Monday sale/Wednesday refund => Wednesday deduction).

## Goal and scope

Build real, outlet-scoped reporting from the four existing Figma screens, replacing
the empty Flutter report module. Deliver Ringkasan Penjualan, Metode Pembayaran,
Penjualan Per Produk and Penjualan Per Kategori, with date range, applicable search/
sort, real charts/tables and export. Current stock, cash sessions and saved orders
remain integrated as previously delivered. Work inline, no subagents or commits;
keep a dated implementation log, changelog, feature history and backlog accurate.

Figma source file jgBLUfP6OXyxmErwgTjfIT, Page1:

| Report | Frame |
| --- | --- |
| Ringkasan Penjualan | [1:3998](https://www.figma.com/design/jgBLUfP6OXyxmErwgTjfIT/aiuiuiu?node-id=1-3998) |
| Metode Pembayaran | [1:4204](https://www.figma.com/design/jgBLUfP6OXyxmErwgTjfIT/aiuiuiu?node-id=1-4204) |
| Penjualan Per Produk | [1:4309](https://www.figma.com/design/jgBLUfP6OXyxmErwgTjfIT/aiuiuiu?node-id=1-4309) |
| Penjualan Per Kategori | [1:4450](https://www.figma.com/design/jgBLUfP6OXyxmErwgTjfIT/aiuiuiu?node-id=1-4450) |

Read high-fidelity design contexts and screenshots for all four during discovery.
Figma task session: 4a2cd29c-835f-4dc1-9c54-63ced2610c44. Reuse that session for this
report feature. Those reference contexts/images are also retained in tool-session
storage keys salesReportDesign0..3. Source links remain the durable references.

## Approach

Recommend backend-calculated reporting with one shared calculation model and
consistent database snapshots per response. Flutter renders the returned totals,
series and rows. XLSX export uses the same server calculation and filter rules.
This reuses existing Go/Flutter/Dio/SVG/Poppins/download conventions without a new
chart package, external reporting service or duplicated financial data warehouse.

Client-side aggregation of existing history is unsuitable: it is paginated, lacks
original item/category allocations and misses current-period refunds of older sales.
An asynchronously maintained reporting warehouse is unnecessary for the present
local POS. It adds synchronization/rebuild work without a current scale requirement.
These alternatives were considered; the backend approach is the recommendation.

## Time, event and amount rules

Use explicit Asia/Jakarta/WIB report dates, default today. Accept inclusive calendar
start/end dates, convert to a half-open UTC interval [start midnight, next midnight
after end), and cap one request at366 dates. Reject invalid/reversed/out-of-range
dates. Do not depend on the browser/device timezone. Display WIB and generation time.

Sales belong to original paid_at; refunds belong to their own created_at, even for
receipts outside the chosen range. Include original paid/partially_refunded and
new-ledger refunded receipts as original sales; never erase them or subtract the
same refund again. Legacy cancelled/refunded rows without trustworthy ledger must
be excluded from verifiable totals with explicit affected-record counts/warning.
A returned-quantity row may exist even when its original sale is outside the range.
Empty ranges show zeros/empty tables, not fabricated example figures.

Define and label amounts consistently:

- Penjualan Kotor: original line subtotal before discounts/tax, for sales in range.
- Diskon: original receipt discount for sales in range.
- Penjualan setelah diskon: gross minus original discount, excluding tax.
- Refund: actual recorded refunded net+tax amount for refund events in range.
- Penjualan Bersih: sales after discount minus refunded NET amount, excluding tax.
- Pajak bersih: original sale tax minus refunded tax in the range.
- Nilai transaksi dibayar: original charged total, not tendered cash before change.
- Nilai setelah refund: charged totals minus actual refund totals; may be negative.
- Total Transaksi: count original paid receipts in range, independently of refunds.
- Produk Terjual: sold unit quantity; returned quantity and net units stay separate.
- Rata-rata Transaksi: original charged total divided by sale count, displayed as
  rounded whole Rupiah; absent when no original sales. Do not divide by zero.

Money comes from original snapshots, never current catalog prices. Reuse the exact
refund allocation rules for line-level discounts/tax: largest remainder with canonical
line-ID tie-breaks, then existing committed refund-item net/tax amounts. Product and
category sums must reconcile with header totals without item/refund join fan-out.
Use overflow-safe intermediates and +/-9007199254740991 bounds for exposed integer
amounts. Quantities and transaction counts are integers with checked aggregate bounds.

Payment-method reporting groups original sales by original payment method and
refunds by actual return method. A QRIS sale refunded by cash appears as QRIS sale
and cash refund. Expose sale count/charged amount, refund count/amount and signed
net value per method; show an explicit total. Point receipts represent recorded
sale value, not a new claim that money was transferred. Cash-session reconciliation
remains its separate physical-till workflow and frozen summaries.

## Historical category and product correctness

Receipts currently snapshot product/variant names, unit prices and quantities, but
not historical categories or product costs. Catalog cost fields exist today; those
are not reliable historical costs. This increment does not calculate profit from
current costs. Replace the Figma Laba Kotor card with a Refund card, retaining the
six-card layout and using clearly defined gross/net/average/count/quantity labels.

Add migration000013 with nullable original category ID/name snapshots on transaction
items. At new checkout, derive them from the validated, locked catalog state inside
the existing transaction, never accept client-supplied historical category authority.
Capture the same data in mock sales. Category edits after checkout must not rewrite
historical rows. Leave pre-migration receipt categories unfilled and group those as
**Kategori historis tidak tercatat**, with an explanatory count. Never invent/backfill
an old category from today's catalog. Existing sale prices/quantities/refunds stay
unchanged. Refund items resolve through their original transaction item snapshots.

Product rows group by original product+variant identity, preserve variations, and
retain inactive/removed catalog items. Display names from original sale snapshots;
when names/prices vary within the range, choose a deterministic original display
name and show a price range/varied-price indicator rather than a current catalog
price. SKU is absent from receipt snapshots; do not invent a historical SKU. Category
rows use recorded category identity/name, with the explicit unknown-history bucket.

## Screens and interaction

Add Laporan to the existing cashier menu, available to outlet cashiers/managers.
Use the existing shared authenticated ApiClient and current-user identity. Back
returns to the same cart; report browsing/export never clears or mutates it.

Match Figma's top bar, blue filter strip, right report selector, cards/table styles,
fonts, colors, icons and spacing on the1340x800 reference layout. Reuse exact local
assets when they match a design node, download any missing static assets and retain
no temporary Figma URLs in runtime code. Charts render API-driven data, not the
Figma's example line/marker images or reference screenshot. Dynamic avatars use
current account data/initials instead of a hardcoded demo person.

The selector offers the four delivered report types. Existing cash-session reports
remain reachable through their working menu. Other Figma reports (tax/attendance/
customer/discount/options) stay future work, rather than new nonfunctional controls.
The all-outlet sample filter becomes the current authorized outlet label because
accounts currently belong to one outlet; no cross-outlet reporting permission is
introduced. Notification behavior stays consistent with the existing header.

Summary: daily series and six cards for gross sales, refund amount, net sales,
average transaction, transaction count and sold units. Provide charged/refunded tax
and final value in an explanatory totals area. Chart transactions and monetary
amounts with clearly distinct units/scales; include daily values/tooltips or an
accessible daily table, never plot Rupiah as though it were a transaction count.
Fill days with no activity as zero. Refund-only dates may have negative net values.

Method screen: method rows, original sales/refunds and signed net, matching the
blue-header table treatment. Product/category screens: Figma cards, date range,
search, server sort and paginated rows, showing gross, refunds, net amounts and sold/
returned quantities with clear tax treatment. Use horizontal table scrolling where
needed; on narrow screens stack controls/cards and use a compact report selector.

Search applies to original displayed product/variant or category names, not current
catalog text; sort supports quantity/net amount/name with stable identity tie-breaks.
Cards/totals and exports follow the selected date/search scope, while pagination
limits only displayed rows. Reload and filter changes preserve meaningful selection,
clear obsolete data as needed and guard against older responses overwriting a newer
request or another account's results. Loading, empty, error and retry states must
remain usable. Show unsupported historical-data notices without hiding known totals.

Export real XLSX for the selected report/date/search/sort scope, all matching rows
and explicit totals/definitions/timezone/generated time. Use literal text cells
and numeric integer cells; protect against spreadsheet formula injection in names.
Export is freshly calculated at generation time, so concurrently arriving activity
can make it newer than the last screen refresh; label the timestamp. Export is
read-only and must use the same outlet/role scoping as the screen.

## Backend and verification boundaries

New focused reports package: authorization, filter/date normalization, consistent
snapshot reads, shared pure aggregation/allocation, paginated response contracts and
XLSX output. Authenticated routes under /dikasa/v1/reports cover summary, methods,
products, categories and report export; exact DTO/file names belong to the plan.
No new transaction/refund mutations, customer editing or report cache writes.

Tests must cover calendar boundaries in WIB, empty/refund-only dates, cross-period
refunds, original/refund-method independence, partial/full repeated allocations,
discounts/free units, header/line/group total conservation, variations and historical
category snapshots/unknown bucket, later catalog/category edits, pagination/search/
sort, overflow, legacy exclusions and role/outlet scope. Test checkout snapshot
capture with stock/saved-order rollback and concurrent category changes. Inspect
XLSX contents/types and real-font screen renders against all four Figma references.

Use isolated temporary PostgreSQL schemas for live integration. Run full backend/
Flutter regressions, analyzer/web build, API schema sync, Bruno validation, ERD XML
and local-link/diff checks. No real application sale/refund needed for testing.
Verify migration000013 in temporary schemas before applying only its additive up
locally. Preserve the normal8081 process and existing application data.

Update OpenAPI, Bruno, Go docs, Draw.io source, both READMEs, dated reporting log,
CHANGELOG, FEATURE_HISTORY RPT-01 and BACKLOG. Record exact test counts/skips,
migration state, design adaptations and source/asset mapping. No commits, pushes,
deployment or new dependencies expected.

## Builder choices and non-goals

Builder chooses exact package splits, DTO names, pagination limits, safe integer
helpers, chart painter and asset composition consistent with existing code. These
are proposals/implementation choices, not additional user requirements.

Profit/COGS, all-outlet permissions, tax/attendance/customer/discount/options reports,
scheduled reports, printing/PDF, a data warehouse, expenses and reopening cash
sessions are outside this four-report increment. Customer management stays deferred.

Direct design review performed without subagents: all four references map to a
screen; each displayed number has a defined source; refund date and original-money
rules match the user choice; unknown category/cost history is never guessed.
