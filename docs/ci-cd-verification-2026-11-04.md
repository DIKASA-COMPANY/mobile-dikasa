# Verifikasi CI/CD Android — 4 November 2026

Perubahan workflow diuji menggunakan Flutter 3.44.2 / Dart 3.12.2.
Working tree awal memiliki perubahan absensi dan regenerasi API yang belum selesai;
perubahan tersebut dipertahankan. Untuk mengisolasi validasi pipeline, source
commit `5bafdc3e4ed3328e084e6b6e0ab9d2174fe91f5d` diekstrak ke folder build
sementara, lalu konfigurasi Android dan perbaikan formatter diterapkan di sana.

Branch PR `codex/firebase-app-distribution` kemudian dibuat terpisah dari
`main` terbaru, commit `ef736c6a24f0425604044260866b5913214029d8`. Perubahan
absensi, izin biometrik, dan perubahan minimum SDK dari working tree awal tidak
disertakan. Format, analyze aplikasi/generated API, test guard promosi, unit/widget
test, dan audit arsitektur diperiksa ulang pada branch PR ini.

| Pemeriksaan | Hasil |
| --- | --- |
| Actionlint 1.7.7 | Lulus untuk seluruh workflow |
| Bash syntax build script | Lulus |
| Test guard provenance/promosi/konfigurasi | 10 test lulus, termasuk subtest input tidak valid |
| Dart format aplikasi/test | Lulus setelah formatter memperbaiki enam file test |
| Flutter analyze pada salinan commit bersih | Lulus |
| Generated API analyze pada salinan commit bersih | Lulus |
| Unit/widget test pada salinan commit bersih | 155 lulus, 10 optional/live/capture dilewati |
| Audit arsitektur working tree | Lulus |
| Release tanpa signing key, Gradle offline dry-run | Ditolak dengan pesan `Release signing is required`, sesuai harapan |
| Evaluasi Gradle flavor/signing | Skrip Kotlin berhasil dikompilasi dan project app dikonfigurasi |
| APK native DEV | Belum terverifikasi; dependency Android file picker belum tersedia di cache lokal |

Enam file test hanya disesuaikan formatter agar gate format menggunakan versi SDK
yang dipin dapat lulus. Kode fitur absensi dan generated client yang sudah dirty
tidak diubah oleh implementasi CI/CD ini.

Pada pemeriksaan awal, `flutter analyze` dan full test working tree absensi gagal karena
serializer `attendance_*.g.dart` yang belum tersedia, serializer yang belum sinkron,
dan adapter absensi yang masih memakai nama generated API lama. Gate CI tetap
menolak kondisi ini. Hasil lulus pada salinan commit bersih tidak berarti source
absensi yang belum selesai sudah tervalidasi.

Dependency resolution dengan `--enforce-lockfile` berhasil pada salinan bersih;
langkah persiapan plugin Windows kemudian melaporkan Developer Mode/symlink belum
tersedia. Analyze dan test dijalankan dengan `--no-pub` menggunakan hasil resolution
tersebut. Runner CI memakai Ubuntu.

Percobaan build native pertama memakai JDK 25 bawaan Android Studio dan gagal
karena kompatibilitas Gradle. Validasi Gradle selanjutnya memakai JDK 23 yang
tersedia lokal; workflow CI secara eksplisit memasang Java 17.

Percobaan online berikutnya dihentikan setelah unduhan dependency tidak selesai.
Pemeriksaan offline kemudian gagal pada classpath plugin `android_file_picker`:
`com.android.tools.build:gradle:8.5.2`, `com.android.tools.build:builder:8.5.2`,
dan `com.android.tools.analytics-library:protos:31.5.2` belum tersedia di cache.
Karena itu keberhasilan APK/AAB native dan instalasi pada perangkat belum diklaim;
gate build di GitHub Actions tetap wajib lulus sebelum distribusi.

Distribusi Firebase, approval GitHub Environments, dan upload Play Store tidak
dijalankan: belum ada konfigurasi akun, endpoint, App ID, grup tester, maupun secret
signing/distribusi untuk pipeline ini. Workflow diajukan melalui PR terpisah;
aktivasi distribusi tetap memerlukan konfigurasi akun. Lihat [panduan aktivasi](ci-cd.md).
