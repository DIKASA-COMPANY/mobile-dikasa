# Mobile Dikasa

> Local two-repository workspace records: [Changelog](../CHANGELOG.md),
> [Feature history](../FEATURE_HISTORY.md), [Backlog](../BACKLOG.md).
> These parent-folder documents should be shared alongside both checkouts.

## Backend lokal tanpa Firebase

Backend setup: [local auth instructions](https://github.com/DIKASA-COMPANY/be-dikasa/blob/main/docs/development/local-auth.md).
Pass `API_BASE_URL` and `USE_MOCK_API` with `--dart-define`, then fully restart
Flutter. The committed `.env.example` is only a safe development fallback.
Run the web preview on port 8080:

```powershell
flutter run -d web-server --web-hostname=127.0.0.1 --web-port=8080 `
  --dart-define=API_BASE_URL=http://localhost:8081/dikasa/v1 `
  --dart-define=USE_MOCK_API=false
```

The backend's explicit seed creates `admin` / `dikasa123`. Login reads the
access token from `/login`, then loads `/users/me`; catalog loading reads all
pages from `/products`. Mock mode remains available with `USE_MOCK_API=true`.
Local sessions expire after one hour; log in again.

## Connected cashier workflow

- Kas Awal restores the outlet's active cash session or saves a new opening amount.
- Jenis Order loads outlet IDs and labels from the API.
- Bayar loads tax, active wallets and tables, confirms the amount received,
  and saves the transaction and item snapshots through `/transactions`.
- Daftar Order reads saved receipts with search, status/order-type filters and pagination.
- Pelanggan reads registered customers with search and pagination.

Payment methods record money already received by the cashier. They do not
charge cards, initiate transfers or generate QRIS payments. Discount, tip and
rounding are currently zero. `Simpan` persists unpaid carts; reopen, update or
delete them through **Daftar Order → Tersimpan**. Customer creation/editing and
order attachment are [deferred](../BACKLOG.md#cust-02--customer-management).
Registration and password recovery remain outside this workflow.

After a lost or malformed payment response, the cart is retained. For a saved
order, recovery checks its server status and existing receipt reference; linked
checkout prevents paying that draft twice. Ordinary unsaved checkout keeps its
session guard and manual history reconciliation, without a general server
idempotency-key contract. Check the outcome before retrying or reloading.

Verification:

```powershell
flutter test
flutter analyze
flutter build web
```

The optional live integration test writes one marked transaction to a loopback
development API and opens a cash session if none exists. It is skipped by the
normal suite. Use only on your disposable local development database:

```powershell
flutter test test/integration/local_pos_live_test.dart --dart-define=DIKASA_LIVE_API_URL=http://127.0.0.1:8081/dikasa/v1
```

## Connected product management

From the cashier hamburger menu, choose **Katalog Produk** with an empty order.
The list supports search, type/category/availability filters, pagination and
manager-only inclusion of inactive products. Add or edit products, selling and
cost prices, online prices, notes, availability and variations. Existing products
can be deactivated and reactivated. **Tambah Kategori** opens category creation
and renaming by product type. Writes require a manager account on the backend.
Returning to the cashier refreshes its catalog; products marked **Habis** cannot
be added to an order. Mock mode uses a session-local editable demo catalog.

The screens follow Figma frames `1:12841` and `1:14083` and bundle their icons
and Poppins locally. Fully restart Flutter after pulling these asset changes.
Photo upload/preview/replacement/removal and XLSX downloads are connected. The local
backend can store photos in `be-dikasa/uploads/` without Firebase. Enable quantitative
inventory from **Ubah Produk → Persediaan Bersama → Atur Pelacakan**, then use
**Sesuaikan Stok** and **Riwayat Stok**. Save a new product before configuring its
initial stock. All variations share the parent balance; successful sales deduct it
atomically. Low-stock counts and inventory capital use actual tracked quantities;
missing cost prices are identified rather than treated as a complete valuation.
Choosing a cashier product with variations opens a price/availability selection
dialog. Variants remain separate cart rows and retain their selected price and
notes. **Muat ulang Katalog** refreshes stock/prices without clearing an unpaid cart;
remove/re-add any item whose price changed before paying. Online-channel automatic
price selection remains outside this flow.
The existing product PATCH API cannot clear saved optional prices to null; enter
a valid number (including zero) to change one. An uncertain save blocks another
submission until you leave the editor and verify the refreshed catalog.

The opt-in catalog test creates clearly marked local records and deactivates
them afterward; it does not create a sale:

```powershell
flutter test test/integration/local_catalog_live_test.dart --dart-define=DIKASA_LIVE_API_URL=http://127.0.0.1:8081/dikasa/v1
```

For the complete photo/XLSX/stock/variation round trip, run
`test/integration/local_completion_live_test.dart` with the same define. It writes
one explicitly marked local receipt and deactivates its test product/category.
Do not run live tests against a production database.

Photo picking and workbook saving use
[`file_picker`](https://pub.dev/documentation/file_picker/latest/). Windows plugin
setup requires Developer Mode for symlink creation. This machine downloaded the
packages but reported that prerequisite while preparing native plugins. With the
already resolved packages, Chrome was verified using:

```powershell
flutter test --no-pub
flutter build web --no-pub
flutter run -d web-server --web-hostname=127.0.0.1 --web-port=8080 --no-pub
```

Enable Windows Developer Mode before a fresh `flutter pub get` or native desktop
build if Flutter reports the symlink requirement. Native Android/iOS/desktop device
builds have not been verified in this increment.

Project kasir F&B berbasis Flutter untuk mendukung alur operasional seperti splash, login, katalog produk, order pelanggan, pembayaran, laporan, notifikasi, dan pengaturan.

## Current Scope

- Splash screen
- Login page (MVVM, terhubung ke lapisan data)
- Order page — katalog produk, keranjang pesanan, dan dialog Kas Awal
- Product management — daftar, tambah/ubah produk, harga/variasi, kategori
- Struktur assets terpusat di `assets/`
- Template PR GitHub dan template MR GitLab untuk workflow review

Tampilan Login dan Order mengikuti desain Figma pada
`DIKASA MOBILE APP/FIGMA` (`Login Page` dan `Order - Clean`),
dirancang untuk tablet landscape 1340x800.

## Arsitektur

Project ini memakai feature-based MVVM, MobX/ChangeNotifier untuk state, dan Dio
sebagai HTTP client. View tidak membuat atau memanggil service/repository; dependency
dirangkai di composition root dan async state dimiliki ViewModel.

```
View  ->  ViewModel  ->  Repository  ->  Service  ->  API
```

| Lapisan | Lokasi | Tanggung jawab |
| --- | --- | --- |
| View | `lib/features/*/view.dart` | Menggambar UI dan navigasi |
| Widget | `lib/features/*/widgets/` | Bagian UI milik satu halaman |
| ViewModel | `lib/features/*/view_model.dart` | State halaman (MobX store) |
| Repository | `lib/data/repositories/` | Sumber kebenaran tunggal, cache, session |
| Service | `lib/data/services/` | Panggilan HTTP lewat Dio |
| Model | `lib/data/models/` | Bentuk data dan parsing JSON |

Komponen lintas fitur seperti loading, async state, remote image, tabel, dan form
berada di `lib/components/`. Seluruh ukuran desain memakai
`flutter_screenutil`; `ScreenUtilInit` memakai artboard 1340×800 di atas
`MaterialApp`, sementara `LayoutBuilder`/breakpoint tetap menangani layout responsif.

## OpenAPI dan generated client

Snapshot kontrak tersimpan di `openapi/dikasa.openapi.yaml` dan client hasil
generate di `packages/dikasa_api/`. Generator dikunci ke OpenAPI Generator 7.24.0
melalui `openapitools.json`; file hasil generate tidak boleh diedit manual.

Sinkronkan selalu dari kontrak backend terbaru yang sudah dipublikasikan:

```powershell
.\tool\generate_api.ps1 -BackendSpec 'D:\path\to\be-dikasa\api\openapi.yaml'
dart analyze .\packages\dikasa_api
flutter analyze --no-pub
flutter test --no-pub
```

SHA-256 snapshot saat ini:
`9516928575677BD60440C4E04BAD714AD00D3DC4890AA9A9A9A4379604C23B7B`.
Jika kontrak backend belum committed/masih dirty, cantumkan kondisi tersebut di PR
karena snapshot mobile belum dapat dianggap reproducible dari revision backend.

## Menjalankan Project

```bash
flutter pub get
dart run build_runner build
flutter run
```

Set `USE_MOCK_API=true` untuk data tiruan
(`lib/core/network/mock_api_interceptor.dart`). Kredensial demo:

- Username: `admin`
- Password: `dikasa123`

Untuk backend lokal, gunakan `--dart-define=USE_MOCK_API=false` dan
`--dart-define=API_BASE_URL=...` seperti bagian setup di atas, lalu mulai ulang
aplikasi.

## Testing

```bash
flutter analyze
flutter test
```

## Saved orders

Choose an order type and items, then **Simpan** to park the cart. Reopen it through
**Daftar Order → Tersimpan** with an empty working cart. Drafts share across outlet
cashiers and survive restarts on the real API; mock drafts last only for the current
app process. Saving does not reserve stock. Catalog changes require review, and
stock/receipt/draft completion commit together only after successful payment.

Backend migration000010 and restart are required. For uncertain saves, retry the
exact original command with the provided button; do not change its UUID/payload.
For uncertain draft payment, use **Periksa Daftar Order** to read the receipt link.

## Refunds and cancellation

Open **Daftar Order → Dibayar → Detail** to refund remaining whole-receipt or
individual-item quantities. The preview uses original prices/tax, never today's
catalog. **Kembali ke stok** defaults to0 and is limited by the original tracked
deduction. Confirmation records money already returned manually; it sends no funds.

On an uncertain reply, use **Periksa Hasil Refund** or retry the exact same command.
Do not return money a second time because a response was lost. Existing unpaid cart
clearing/saved-order deletion remain available; paid cancellation uses full-remaining
refund. Backend migration000011 and a full backend/Flutter restart are required.

Cash closing is available in the cashier menu under **Sesi Kas / Tutup Kas**.
The opening cashier or an outlet manager counts physical cash, previews any
shortage/surplus and closes the session. Histories retain immutable summaries;
stock, carts and saved orders are preserved. Open a new Kas Awal explicitly for
later payments. After updates restart backend and Flutter. See the parent
[implementation log](../CASH_CLOSING_IMPLEMENTATION_LOG_2026-10-24.md).

Cashier menu **Laporan Penjualan** opens the four Figma reports with WIB date ranges,
refund-date deductions and XLSX export. Original category history starts with
migration000013; older uncaptured categories are labelled explicitly. Historical
profit is deferred. See the parent [reporting log](../REPORTS_IMPLEMENTATION_LOG_2026-10-24.md).


## Account settings (24 October 2026)

The cashier menu's **Pengaturan Akun** supports self-profile details, local profile
photos, PIN setup/change and local-auth password changes. Restart the backend and
Flutter after updating. Migration000014 (nullable personal address) is already
applied in this workspace's local database. Fresh installs must also apply
`migrations/000014_add_user_personal_address.up.sql` in the backend after000013.

Photos use the configured `LOCAL_IMAGE_DIRECTORY/avatars` in local storage mode.
Back up those files; changing to Firebase does not automatically copy old media.
Password changes require `can_change_password=true`, do not revoke existing JWTs,
and do not manage Firebase passwords. See the complete [account implementation
log](../ACCOUNT_SETTINGS_IMPLEMENTATION_LOG_2026-10-24.md) for contracts, tests,
configuration, restart steps and limitations.


## Cash-in/out and till activity (24 October2026)

Restart the backend and Flutter, then choose **Menu → Kas Kasir / Uang Masuk-Keluar**.
The opening cashier or manager may record movements; authenticated outlet staff
can read history. Optional evidence is private local storage, defaulting to
`LOCAL_IMAGE_DIRECTORY/cash-proofs` in local image mode; use `CASH_PROOF_DIRECTORY`
to configure it explicitly. Keep files with the database backup.

Migration000015 is applied to this workspace's local DB. Fresh backend installs
must apply `migrations/000015_create_cash_movements.up.sql` after000014. No real
cash record or till closure was created during verification. Existing frozen
closings are preserved. Pending uncertain writes must be recovered/retried with
the same intent; inspect history before re-entry after browser reload/logout.

See the [cash movement implementation log](../CASH_MOVEMENTS_IMPLEMENTATION_LOG_2026-10-24.md)
for API, permissions, corrections, tests and storage/recovery limitations. General
expense accounting and private Firebase evidence storage remain separate work.


## Figma alignment batch 1 (24 October 2026)

Payment success, Pelanggan and Daftar Order now use the Figma-based full-page
layouts. Paid/saved tabs, search, pagination and existing draft/refund actions
remain available. Restart Flutter to load the new assets; no backend migration
or restart is needed for this batch. Printing/WhatsApp sharing and deferred
customer creation/attachment remain disabled. See the [batch-1 history](../FIGMA_ALIGNMENT_BATCH_1_IMPLEMENTATION_LOG_2026-10-24.md)
for design references, adaptations, test evidence and remaining batch-2 work.
