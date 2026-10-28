# Complete product photos, Excel export, stock and checkout variations

Status: approved by the user on 22 October 2026.

## Agreed scope

Finish the four outstanding product/POS features: product photo upload, real Excel
export, stock quantities and choosing variations at checkout. Keep the current
local PostgreSQL/Go/Flutter setup usable without Firebase. The user chose **one
shared stock balance per product**, used by the base product and all variations.
Existing uncommitted local-auth, cashier and product-management work must remain
intact. Work directly in this chat without subagents.

Success means a manager can upload a photo, download a usable workbook, enable and
adjust a product's stock, and sell a chosen variation at its own price. A successful
sale deducts the right shared quantity; a failed sale deducts nothing. Existing
products and historical receipts continue to work.

## Approach

Extend the existing catalog, image-store adapter and payment transaction rather
than introducing another service. Keep local and Firebase image storage selectable
through configuration. Add inventory persistence and validation to PostgreSQL;
Flutter displays the server's current stock and availability. Preserve the current
Figma layouts and add compatible stock controls and a variation-selection dialog.

Alternatives considered: restoring Firebase now adds an external setup dependency;
independent balances for variations were considered and rejected by the user's
choice. A separate inventory service is unnecessary for this application's current
architecture.

## 1. Product photos

- Add `IMAGE_STORAGE_MODE=local`, alongside the existing `disabled` and `firebase`
  modes. Configure a persistent local upload directory and a trusted public API
  base URL; document the local port-8081 values. Do not construct stored URLs from
  an arbitrary incoming Host header.
- Reuse and strengthen the existing PNG/JPEG validation: maximum 3 MiB, allowed
  extension, declared/detected MIME agreement and valid image content. Inspect
  dimensions before decoding to reject excessive decoded image sizes.
- Generate storage names on the server. Keep reads/writes/deletes inside the
  configured directory, reject invalid path components and symlinks, and expose
  only the expected image routes. No directory listing or generic file serving.
- Product images use public, unpredictable URLs, like the existing Firebase
  product-image URLs. They contain no credentials. Manager authorization remains
  required for upload/replacement/removal. All routes stay under `/dikasa/v1`.
- Write a new image before committing its database reference; remove it if the
  database mutation fails. Remove an old image only after a successful replacement
  or removal. Deactivating a product retains its image.
- Enable **Upload Foto** with a PNG/JPEG picker, local preview, replacement and
  removal. Cancelling the picker leaves the current image unchanged. The existing
  product multipart API carries the image; selected files persist in the form on
  ordinary save errors. Disable duplicate saves.
- Show returned images in both management and cashier cards. Retain the existing
  placeholder for missing or failed images. Mock mode keeps demo images in memory.
- A later switch to Firebase uses the same image-store interface. Existing local
  files are not automatically copied to Firebase; an actual data migration is
  separate from changing the configured provider.

## 2. Excel export

- Enable the list's **Export / Download** and the editor's **Export File Excel**.
  List export includes every matching product, across pages, using the current
  search, type, category, availability and inactive-product filters. Editor export
  exports the saved product; unsaved edits are not represented as persisted data.
- Add a manager-only, outlet-scoped workbook endpoint under `/dikasa/v1`. It
  returns an actual `.xlsx` workbook with the correct content type and attachment
  filename, not CSV renamed to Excel. Use the existing catalog service's filtering
  and authorization rules.
- Include product/category/type, base and online prices, cost prices, activation,
  manual and effective availability, stock tracking/quantity/threshold, and
  variation rows with their names and prices. Shared stock appears once per product
  so variant rows cannot be mistaken for additional inventory.
- Use numeric cells for quantities and prices and literal text cells for names
  and notes. User text must never become an executable spreadsheet formula. Blank
  optional prices remain blank. Preserve Indonesian characters.
- Flutter downloads/saves the response through a platform-capable file boundary.
  Keep API, workbook generation and file-save code separate so tests do not need
  a real desktop dialog. Cancelling a save is a normal outcome.

## 3. Shared stock tracking

### Data and management

- Add an opt-in tracking flag, nonnegative whole-unit balance and nonnegative
  low-stock threshold on products. A migration defaults existing products to
  **untracked**; it does not infer inventory from past sales or reset existing data.
- Base product and every variation share the same balance. No ingredient recipes,
  fractional units, warehouses, suppliers or purchasing system are added.
- On a new tracked product, the manager enters the initial quantity and threshold.
  Existing products enable tracking through an explicit setup action. Disabling
  tracking requires an explicit manager action and leaves its audit history intact.
- Change an established balance through a dedicated manager stock-adjustment action,
  with a signed integer change, a reason and a client request identifier. Reject
  negative resulting stock. A repeated adjustment identifier returns the original
  result rather than applying the change twice; reusing it with a different payload
  returns a conflict.
- Record stock movements with outlet, product, signed quantity, resulting balance,
  reason, actor, timestamp and an optional transaction reference. Managers can see
  recent movements from the product editor. Initial setup and sale deductions are
  also recorded.
- Keep stock configuration and adjustments separate from ordinary product edits.
  Editing a name, price, image or variation must never overwrite a balance changed
  by a sale in the meantime. Balance updates and movements commit together.

### Availability and catalog summary

- Retain the existing manual `available` / `out_of_stock` switch for untracked
  products and deliberate sales pauses. Add a derived availability field to the
  API without silently changing the existing manual-status contract.
- Manual sold-out status or tracked quantity zero means **Habis**. Otherwise a
  tracked balance at or below its threshold means **Menipis**. Remaining available
  products mean **Tersedia**. A variation's own sold-out setting can additionally
  disable that variation without changing the shared balance.
- Replace the placeholder low-stock counter with actual counts. Inventory capital
  value uses tracked quantity × base product cost, counted once per product.
  Explicitly identify tracked products with missing cost so the UI does not present
  an incomplete subtotal as a complete inventory valuation.
- Cart limits apply to the sum of all lines for the same product, including different
  variations. The server remains authoritative if another cashier sells stock while
  a cart is open.

### Saving a sale

- Within the same PostgreSQL transaction as receipt creation, lock involved product
  rows in a stable order, validate outlet/category/product/variation activation and
  availability, aggregate quantities by product and reject insufficient balances.
- Validate that each variation belongs to the supplied product and outlet and that
  the submitted base/variation price matches the currently applicable catalog price.
  A changed price is a conflict requiring cart review, not a silent charge change.
- Decrement tracked balances and write movement records in that transaction.
  Roll back receipt, items and all deductions on any failure. Untracked products
  incur no inventory deduction.
- Stock conflicts have a specific API error and keep the cart available for review.
  Network failures retain the existing uncertain-payment guard: no automatic retry,
  cart retained, verify the saved receipt before reconciliation. This increment
  does not claim a cross-restart exactly-once payment guarantee.

## 4. Variation selection at checkout

- Preserve actual variant IDs, names, prices, active state and availability in the
  cashier catalog model. Keep base product IDs separate from variant IDs.
- Clicking a product with active variations opens a selection dialog containing
  the base product and named variations, their prices and availability. Clicking
  a product without variations keeps the current one-tap add behavior.
- A cart line is identified by `(product ID, variant ID or base)`. Two variations
  remain distinct; adding the same variation increments its own quantity. Quantity
  controls and notes operate on the correct line.
- Line subtotal, tax and payment totals use the selected variation price. Send the
  existing `product_variant_id` and `variant_name` snapshot fields with the real
  product ID to the current transaction API. Receipts preserve the selected name
  and price even when the catalog is changed later.
- This scope uses the ordinary selling price. Automatically selecting online prices
  by sales channel is not included because no channel-selection flow is defined.
- Refresh catalog stock after a confirmed sale and when returning from management.
  Mock mode mirrors selection, shared balances, conflicts and successful deductions.

## Compatibility and delivery

- Add a forward/down migration after migration 000008. Apply only the new forward
  migration to the configured local development database after verification; do not
  drop/recreate tables or rerun historical migrations as a reset.
- Synchronize OpenAPI, Bruno examples and the Draw.io ERD with each API/schema
  change. Follow the repository's Go TDD/API-documentation skill.
- Use a maintained file picker/save boundary for Flutter. Verify platform support
  from its official documentation before selecting the dependency. Chrome/Windows
  is the primary live acceptance environment; record any untested device platforms.
- Continue using the existing Figma product list/editor and shared styles. New
  controls must fit tablet and narrow layouts and report server errors without
  losing ordinary form edits. Do not introduce external Figma writes.
- Preserve local authentication. Do not require Firebase, SMTP, cloud deployment,
  registration, or another account to try these four features.

## Verification and acceptance

Write focused tests before production changes and observe their expected failures.

1. Storage: valid PNG/JPEG upload/read/replace/remove, MIME/size/dimension rejection,
   path and symlink rejection, authorization and cleanup after database failure.
2. Workbook: valid XLSX package/worksheets, complete pagination/filtering, correct
   numeric/blank cells, non-ASCII text, literal formula-looking text and outlet scope.
3. Stock: migration compatibility, opt-in setup, adjustment deduplication, permission
   checks, nonnegative balances, low-stock derivation and no stale product-edit reset.
4. Sales: summed base/variant deductions, simultaneous last-unit purchases, inactive
   or foreign variants, changed prices, insufficient stock and complete rollback.
5. Flutter: photo picker cancellation/preview/save, file-save cancellation, selection
   of separate variants, line-specific notes/quantity, shared cart limits, stock
   controls, loading/error states and tablet/narrow layout checks.
6. Run relevant Go and Flutter suites, analyzer and web build. Exercise a live local
   round trip covering photo upload, workbook download, stock setup, variation sale
   and final stock. Use explicitly marked fixtures and document persistent results.
7. Review the actual rendered screens and write a developer handoff with commands,
   API/schema changes, evidence, storage directory and remaining material limits.

## Outside this increment

Reports, expenses, supplier/purchasing workflows, customer editing, unpaid drafts,
notifications, account registration/recovery, refunds/restocking, online channel
pricing and a Firebase file-migration utility are not part of these four features.
