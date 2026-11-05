# Summary

Integrasi Supabase dan signed image upload ke `main` terbaru, dengan mempertahankan fitur kasir, akun, katalog, laporan, ScreenUtil, serta komponen/getter yang masih dipakai. Avatar, gambar produk, dan bukti kas sekarang memakai upload intent → PUT langsung ke Storage → generated mutation dengan object name.

## Changes

- Gabungkan `main` (`ef736c6`) ke branch PR tanpa menimpa perubahan lokal attendance/CI di checkout lain.
- Pertahankan `table`, `screen_utils`, laporan, `User.initials`, dan `AuthRepository.isLoggedIn`. Hapus hanya komponen, login duplikat, utility, dan placeholder yang tidak direferensikan.
- Gunakan `supabaseBearer` dan fixture login `supabase_user_id`.
- Gunakan generated upload intents dan generated mutation akun, produk, serta kas. Byte gambar tidak dikirim ke mutation API.
- Pisahkan Dio Storage dari autentikasi/logging API. Upload gagal atau sesi berubah menghentikan penyimpanan. Retry kas memakai kembali object bukti dan request ID yang sama setelah respons hilang.
- Tambahkan adapter JSON multipart untuk variasi produk: edit biasa mengabaikan variasi, penggantian eksplisit mengirim JSON, dan daftar kosong menghapus variasi. Generated source tidak diedit manual.
- Mock mengikuti flow intent/PUT/adopt yang sama. Fresh checkout memakai `.env.example` bawaan `main`.

## Contract and generation

- Sumber: kontrak backend committed `5277d6a`, bukan perubahan attendance backend yang belum di-commit.
- SHA-256: `3c266e1652f974627e56a4d1edd2bd2996d54c3b7e0c837b2faa5ed4bbee495f`.
- OpenAPI Generator **7.24.0**, CLI **2.41.0**.
- Dua regenerasi menghasilkan hash output identik; tidak ada generated file di luar manifest.

## Validation

- `flutter test --no-pub`: **171 passed, 0 failed, 10 skipped**. Skip adalah tes opt-in screenshot dan backend lokal.
- `flutter analyze --no-pub`: **No issues found**.
- `dart analyze` di generated package: **No issues found**.
- `flutter build web --no-pub`: berhasil, tanpa `.env` lokal.
- Format file yang berubah, `git diff --check`, dan audit arsitektur: lulus. Satu raw inset lama masih terdeteksi oleh audit; tidak diperkenalkan perubahan ini.
- Cakupan regresi mencakup tiga upload intents, byte stream Storage, pemisahan bearer, upload gagal tanpa mutation, logout saat upload, retry bukti kas, JSON variasi, dan respons mutation rusak.
- Pengujian perangkat fisik dan Supabase/backend produksi belum dilakukan. Tidak ada perubahan backend.

## Figma Reference

- Flow: login, akun, katalog produk, dan kas; tidak ada perubahan desain layar.
- Mengikuti implementasi Figma yang sudah ada di `main`; tidak melakukan verifikasi Figma terbaru.

## Related task

- Perbaikan PR #8 berdasarkan review relevansi terhadap mobile DIKASA terbaru.
