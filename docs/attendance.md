# Absensi pegawai

Menu **Pegawai** pada sidebar kasir membuka absensi masuk/pulang melalui PIN
enam digit atau fingerprint. PIN dapat dipakai untuk pegawai satu outlet;
fingerprint hanya untuk akun yang sedang login dan perangkat yang mendukungnya.
Laporan menampilkan rentang maksimal 31 hari dengan waktu Asia/Jakarta.

ViewModel menangani status dan operasi async. `ApiAttendanceRepository` memetakan
model dari generated `AbsensiApi`; view tidak memanggil HTTP secara langsung.
Fingerprint memakai kunci ECDSA P-256 yang dilindungi biometrik dan menandatangani
challenge server. PIN tidak disimpan setelah operasi, pergantian metode/pegawai,
atau penutupan layar. Jika hasil pengiriman tidak pasti, aplikasi mewajibkan
pemuatan ulang status sebelum mengizinkan absen berikutnya.

## Ketergantungan backend

Snapshot kontrak dalam perubahan ini berasal dari working tree backend
`be-dikasa/api/openapi.yaml`, SHA-256:

`916ac0748495202338df14184f53abf62f29592cca02acdf2a8035dfee047e5f`

Saat integrasi mobile disiapkan, kontrak absensi ini **belum di-commit dan belum
ada di main backend**. Perubahan mobile tetap draft sampai kontrak backend
dipublikasikan dan hash dibandingkan kembali. Tidak ada source backend yang
diubah dalam pekerjaan mobile ini. Snapshot yang disimpan dapat diregenerate,
tetapi belum dapat ditelusuri ke commit backend yang memuat absensi.

OpenAPI Generator 7.24.0 dan CLI 2.41.0 dipin. Jalankan dari PowerShell 7:

```powershell
./tool/generate_api.ps1 -BackendSpec '../be-dikasa/api/openapi.yaml'
```

Sesuaikan lokasi backend. Generator membangun package di direktori kosong,
menjalankan serializer dan formatter, lalu menyalin hasil yang berhasil. File
generated yang tidak ada pada hasil baru dihapus, termasuk serializer model lama.
Jangan mengedit generated source secara manual.

## Pemeriksaan kode yang tidak terpakai

```shell
flutter analyze --no-pub
dart analyze packages/dikasa_api
python tool/check_dead_code.py
python -m unittest discover -s tool/ci -p 'test_*.py' -v
flutter test --no-pub
```

Analyzer memeriksa deklarasi yang tidak terpakai. Pemeriksaan Python melengkapi
dengan penelusuran import/export/part dari `lib/main.dart` dan penolakan serializer
tanpa model. Conditional import diperiksa untuk seluruh platform. Generated API
merupakan kontrak publik; endpoint yang belum dipakai UI bukan otomatis dead code.

Untuk screenshot widget opsional:

```shell
flutter test --no-pub --dart-define=CAPTURE_ATTENDANCE=true test/features/attendance/view_test.dart
```

Screenshot disimpan di `build/attendance/`. Test normal tetap memeriksa layout
1340×800, 800×600, dan 390×844 tanpa menulis screenshot.

## Batas validasi

Test repository menggunakan transport tiruan untuk memeriksa bearer, body JSON,
respons kosong/nullable, mapping model, dan hasil mutasi yang tidak pasti.
Test widget dan ViewModel tidak menggantikan pemeriksaan fingerprint di perangkat
fisik atau integrasi dengan backend yang sudah dipublikasikan. Keduanya masih
diperlukan sebelum fitur dinyatakan siap produksi.
