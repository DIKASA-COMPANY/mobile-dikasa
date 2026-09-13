# Mobile Dikasa

Project kasir F&B berbasis Flutter untuk mendukung alur operasional seperti splash, login, katalog produk, order pelanggan, pembayaran, laporan, notifikasi, dan pengaturan.

## Current Scope

- Splash screen
- Login page (MVVM, terhubung ke lapisan data)
- Order page — katalog produk, keranjang pesanan, dan dialog Kas Awal
- Struktur assets terpusat di `assets/`
- Template PR GitHub dan template MR GitLab untuk workflow review

Tampilan Login dan Order mengikuti desain Figma pada
`DIKASA MOBILE APP/FIGMA` (`Login Page` dan `Order - Clean`),
dirancang untuk tablet landscape 1340x800.

## Arsitektur

Project ini memakai MVVM dengan MobX sebagai state management dan Dio sebagai HTTP client.

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

## Menjalankan Project

```bash
cp .env.example .env
flutter pub get
dart run build_runner build
flutter run
```

Untuk pengembangan tanpa backend, ubah `USE_MOCK_API=true` agar request
dilayani data tiruan (`lib/core/network/mock_api_interceptor.dart`). Kredensial
demo:

- Username: `admin`
- Password: `dikasa123`

Untuk memakai `be-dikasa` lokal dari Android emulator, isi `.env`:

```dotenv
API_BASE_URL=http://10.0.2.2:8080/dikasa/v1
USE_MOCK_API=false
```

Gunakan `localhost` sebagai host saat menjalankan Flutter desktop/web.

## OpenAPI Code Generation

Kontrak backend disimpan sebagai snapshot di `openapi/dikasa.openapi.yaml`.
Seluruh DTO dan service Dio di `packages/dikasa_api/` dihasilkan otomatis;
jangan mengedit file Dart di package tersebut secara manual.

Setelah `api/openapi.yaml` pada backend berubah, sinkronkan dan generate ulang
dengan PowerShell:

```powershell
.\tool\generate_api.ps1 -BackendSpec "D:\Golang Project\be-dikasa\api\openapi.yaml"
```

Tanpa `-BackendSpec`, script memakai snapshot yang sudah ada. Generator dipin
ke OpenAPI Generator `7.24.0`, membuat model/service, menjalankan serializer,
format, dan `flutter pub get`. Dibutuhkan Node.js serta Java 11+; bila `java`
tidak ada di `PATH`, script otomatis mencoba runtime Java bawaan Android Studio
pada instalasi Windows standar.

Kode aplikasi memakai package generated lewat adapter Service/Repository. Alur
yang sudah terhubung ke backend adalah login dan profil pengguna, katalog
produk (termasuk gambar URL dan status stok), jenis order, serta sesi kas awal.

## Testing

```bash
flutter analyze
flutter test
```
