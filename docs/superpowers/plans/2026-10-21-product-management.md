# Product Management Implementation Plan

**Goal:** Connect product list, creation, editing, and categories using the existing catalog API and Figma frames 1:12841 and 1:14083.

**Architecture:** Dedicated catalog management models and Dio service preserve all commerce fields. Stateful Flutter screens compose existing components and local Figma assets. The cashier catalog refreshes when returning from management.

**Tech Stack:** Flutter, Dart, Dio, Provider, flutter_svg. No backend contract changes.

**Spec:** https://www.figma.com/design/jgBLUfP6OXyxmErwgTjfIT/aiuiuiu?node-id=1-12841

## Constraints and review focus

- Work directly; user explicitly prohibits subagents. Preserve existing uncommitted work.
- Writes require manager authorization enforced by the backend. Surface API errors without losing input.
- No stock quantity or low-stock API exists. Show supported availability only; never invent totals.
- Image storage is disabled locally. Keep upload disabled with a clear explanation.
- Preserve variations and optional prices on edits; optional numeric fields cannot be cleared to null by the existing PATCH contract, so explain this limitation.
- Prevent duplicate saves. On ambiguous write failures instruct users to reload and verify before retrying.
- Do not allow catalog editing while an unpaid/uncertain payment is pending.

## Tasks

- [x] Write failing service tests for pagination, multipart JSON variations, omitted optional prices, category writes, and backend errors. Implement `catalog_product.dart` and `catalog_service.dart` and pass tests.
- [x] Build list, editor, variations, and category dialogs under `lib/features/product/`; use local Figma assets and Poppins. Add widget tests for validation, edit preservation, save errors, and rendering.
- [x] Connect navigation from the cashier menu; refresh on return using `forceRefresh: true`, which replaces the existing cache. Check supported stock status before sale.
- [x] Run all Flutter tests, analyzer and web build; inspect rendered screenshots and validate tablet/narrow layouts. Run opt-in local API smoke test.
- [x] Review diff directly and write a developer handoff log with limits and reproduction steps.

## Results

- Full suite with screenshot capture: 69 passed, 2 opt-in live tests skipped.
- Separate local catalog integration: 1 passed; test fixtures deactivated afterward.
- Analyzer clean; web build passed; direct diff review and whitespace checks complete.
- Screenshots are in ignored `build/catalog-qa/`; handoff is `../PRODUCT_MANAGEMENT_LOG_2026-10-21.md` from the repository root.
- Ruling: Keep the existing workspace because it contains the earlier authorized local-auth/POS work needed by this increment. Preserve that work and perform direct review; user prohibits subagents.
- Ruling: Use a forced cashier reload on return instead of separately clearing the cache; the existing repository replaces its cache on a successful forced request.
