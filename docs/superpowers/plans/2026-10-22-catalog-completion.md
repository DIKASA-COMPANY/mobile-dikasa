# Catalog Completion Implementation Plan

**Goal:** Finish product photos, Excel export, shared stock tracking and checkout variations.
**Spec:** `../specs/2026-10-22-catalog-completion-design.md`, approved by the user on 22 October 2026.
**Execution:** Inline in the existing workspace; user explicitly prohibits subagents. Preserve earlier uncommitted work. No commits or deployments are requested.
**Architecture:** Extend the Go image adapter, add an inventory boundary backed by PostgreSQL, generate XLSX through an authenticated export handler, and reuse the Flutter catalog/cashier components. Stock and receipt writes share a database transaction. Normal product edits never write inventory columns.
**Stack:** Go/Gin/Huma/GORM/PostgreSQL and Flutter/Dio/Provider/MobX.

## Tasks and verification

- [x] **Local photos:** Write failing storage/config/router tests, then add `catalog/image_local.go`, shared image validation, local configuration, safe image serving and wiring in `cmd/api`. Test size/type/dimension/path/symlink rejection and existing image cleanup behavior. Add a Flutter file boundary and image upload/preview/removal, model image URLs and cashier rendering. Test multipart data and picker cancellation.
- [x] **Stock persistence:** Write migration and domain tests, then migration 000009 adds product stock columns and scoped movement records. Add `internal/inventory` service/repository/DTO/handler/routes for manager configuration, deduplicated adjustments and recent movement reads. Test authorization, enable/disable transitions, repeated request IDs, nonnegative balances and stale ordinary edits.
- [x] **Atomic checkout:** Write failing payment repository tests for aggregate stock and catalog/variant checks. Extend receipt persistence to lock products in ID order, verify references/current prices/availability, deduct shared quantities and insert movements before commit. Test concurrency/rollback with a temporary PostgreSQL schema and retain the uncertain-payment guard.
- [x] **Checkout variations:** Test distinct cart keys, line notes and selected prices, then extend cashier product/variant models, selection dialog and payment snapshots. Limit aggregate cart quantity by product and refresh after confirmed sale. Update mock mode accordingly.
- [x] **Excel:** Test workbook ZIP/XML content, filters/pagination, literal strings/numbers and role scope, then add a manager export handler and workbook generator. Connect both export buttons through a testable save boundary.
- [x] **Inventory UI:** Test management controls, derived statuses and missing-cost valuation, then connect tracking setup, adjustments, movement history, low-stock count and inventory capital display. Preserve responsive Figma-based layouts.
- [x] **Documentation and acceptance:** Regenerate OpenAPI, update Bruno, Draw.io, setup docs and handoff. Apply only the new migration locally, enable local images, run focused and full Go/Flutter checks, build web, inspect rendered screens and exercise marked live fixtures. Record results and limitations.

## Review focus

- Lost write responses never trigger automatic POST retries.
- Ordinary catalog changes never reset quantities, including concurrent sales.
- Two variants share one balance and remain separate cart rows.
- Workbook user strings cannot become formulas; variant rows do not duplicate inventory.
- Public image access is limited to generated product image paths, with no file listing or filesystem traversal.
- Local image files remain local when selecting Firebase later; no automatic data migration is claimed.

## Completion evidence and decisions

- Full Go suite passed; isolated PostgreSQL migration/concurrency/rollback tests passed.
- Flutter with capture: 76 passed, 3 live tests skipped; separate completion live test passed.
- Analyzer clean and final web build passed. Actual catalog/editor renders were inspected.
- Local migration 000009 applied and local image storage enabled; previous data was preserved.
- Ruling: inventory setup follows the initial product save through an explicit manager action. Product edits remain independent of quantity writes.
- Ruling: Windows native symlink setup is unavailable on this machine. Packages were resolved and Chrome checks/builds used --no-pub; native builds remain unverified.
- Ruling: the existing backend occupied port 8081. A separate temporary API on 18081 was used and stopped; the user must restart the normal backend to load new code.
- No subagents, commits, pushes or deployments. See the workspace CATALOG_COMPLETION_LOG_2026-10-22.md for the handoff and live verification receipt.
