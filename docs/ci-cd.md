# CI/CD Android dan Firebase App Distribution

Pipeline memakai satu branch utama `main` dan GitHub Environments
`dev → sit → uat → stg → prd`. Android dikerjakan terlebih dahulu;
iOS/signing Apple dan upload Google Play belum diaktifkan.

## Alur

```text
PR ke main
  → format → analyze → unit/widget test + coverage → build DEV debug APK
Merge ke main
  → Mobile CI lulus → build/sign APK DEV → Firebase grup DEV
Promosi manual dengan CI run ID yang sama
  → SIT → UAT → STG → PRD candidate
```

- `.github/workflows/mobile-ci.yml`: validasi tanpa secret, termasuk PR dari fork.
- `.github/workflows/mobile-release.yml`: otomatis DEV setelah **push CI main**
  berhasil; promosi manual menerima target environment dan ID run Mobile CI.
- `.github/workflows/reusable-android-distribute.yml`: proses build/sign/distribusi
  yang sama untuk setiap environment.
- `tool/ci/release.py`: memverifikasi asal kandidat, urutan promosi, konfigurasi,
  manifest/checksum artifact, serta catatan distribusi berhasil.

CI harus selesai seluruhnya, termasuk build validation, sebelum distribusi DEV.
Run CI dari PR, fork, branch lain, workflow lain, atau run gagal ditolak.
Commit kandidat harus masih menjadi ancestor `main`. Jalankan promosi manual
melalui branch `main`. Tombol manual tidak bisa melewati tahap: SIT memerlukan
receipt DEV yang sukses, UAT memerlukan SIT, dan seterusnya, untuk **CI run ID dan
commit yang sama**. Receipt adalah deployment GitHub dengan task
`dikasa-android-distribution`, baru sukses setelah Firebase upload dan arsip
artifact berhasil. Deployment DEV baru tidak membatalkan kandidat lama yang
telah sukses. Kegagalan tahap tidak membuat receipt sukses; perbaiki lalu ulangi.

Flavor dan endpoint tertanam di binary. Setiap tahap membangun ulang **commit
yang sama** dengan konfigurasi tahap tersebut. APK antartahap berbeda; ini bukan
promosi binary identik. PRD menghasilkan APK konfigurasi produksi untuk tester
Firebase dan signed AAB untuk disimpan sebagai kandidat Play Store. Pengujian
SIT/UAT/regression pada perangkat tetap dilakukan tim sebelum mempromosikan;
pipeline ini tidak mengklaim menjalankan E2E terhadap backend live.

## 1. Siapkan GitHub Environments

Di repository **Settings → Environments**, buat `dev`, `sit`, `uat`, `stg`, `prd`.
Batasi deployment ke branch `main`. Pasang required reviewers pada UAT, STG,
dan PRD sesuai proses tim. Job menunggu persetujuan environment sebelum mengakses
secret dan membangun rilis; kandidat diperiksa lagi setelah approval.
Ketersediaan protection rules bergantung paket/visibilitas repo GitHub.
Pipeline memeriksa urutan tahap, sedangkan persetujuan manusia dikonfigurasi di
Settings tersebut. Jangan menganggap environment otomatis memiliki reviewer.

Tambahkan **Variables per environment**:

| Nama | Nilai |
| --- | --- |
| `API_BASE_URL` | URL HTTPS backend tahap itu, termasuk `/dikasa/v1` bila dipakai |
| `FIREBASE_APP_ID` | Firebase Android App ID, misalnya `1:123456789:android:abcdef123456` |
| `FIREBASE_GROUPS` | Alias grup tester, misalnya `dev` atau `uat,qa` |
| `ANDROID_BUILD_NUMBER_OFFSET` | Opsional; default `0`, ditambah nomor run Mobile release |

Pipeline selalu memakai `USE_MOCK_API=false` untuk distribusi dan menolak endpoint
HTTP, localhost, serta alamat loopback/link-local. API harus bisa dijangkau perangkat
tester melalui internet atau jaringan/VPN pengujian yang sesuai. Endpoint bukan
secret: nilai `--dart-define` dapat dibaca dari aplikasi.
Jangan menanam password/token server di dalam aplikasi.

Tambahkan **Secrets per environment**:

| Nama | Isi |
| --- | --- |
| `ANDROID_KEYSTORE_BASE64` | Seluruh file signing keystore yang dienkode base64 satu baris |
| `ANDROID_KEYSTORE_PASSWORD` | Password keystore |
| `ANDROID_KEY_ALIAS` | Alias key |
| `ANDROID_KEY_PASSWORD` | Password key |
| `FIREBASE_SERVICE_ACCOUNT_JSON` | JSON utuh service account untuk distribusi Firebase |

Pisahkan signing/credential produksi dari nonproduksi. Pertahankan key yang
sama untuk update aplikasi dengan package ID yang sama dan cadangkan key secara
aman. Build release tidak lagi fallback ke debug signing. Secret ditulis ke
file sementara dengan permission `0600`, tidak masuk artifact, lalu dibersihkan
melalui langkah `always()`.

Lindungi `main`: wajib review dan required status checks **Analyze and test** serta
**Android build validation**. Batasi hak mengubah workflow dan pengaturan environment.
Untuk menjalankan distribusi, workflow baru harus sudah tersedia di default branch.

## 2. Siapkan Firebase

Daftarkan aplikasi Android untuk setiap package berikut (identitas produksi yang
sudah ada dipertahankan):

| Environment | Package ID saat ini | Nama aplikasi | Grup contoh |
| --- | --- | --- | --- |
| dev | `com.example.mobile_dikasa.dev` | DIKASA DEV | dev |
| sit | `com.example.mobile_dikasa.sit` | DIKASA SIT | sit |
| uat | `com.example.mobile_dikasa.uat` | DIKASA UAT | uat |
| stg | `com.example.mobile_dikasa.stg` | DIKASA STG | stg |
| prd | `com.example.mobile_dikasa` | DIKASA | prd |

Base application ID repo masih berupa placeholder `com.example.mobile_dikasa`.
Sepakati ID permanen sebelum pendaftaran app baru atau publikasi Play Store.
Jika diubah di `android/app/build.gradle.kts`, sesuaikan kelima registrasi Firebase
dan variabel App ID; jangan mengubah ID aplikasi yang sudah dipakai pengguna
tanpa rencana migrasi. Kotlin namespace/activity tetap mengikuti konfigurasi repo.

Aktifkan **App Distribution** di Firebase Console, buat grup tester, lalu undang
tester ke grup. Isi `FIREBASE_GROUPS` menggunakan **alias grup**, bukan email
atau nama tampilan. App ID Firebase berbeda dari project ID/package ID.

Buat service account pada project Firebase terkait dengan role
**Firebase App Distribution Admin** (`roles/firebaseappdistro.admin`), aktifkan
Firebase App Distribution API, lalu simpan JSON key hanya dalam GitHub Secret.
Gunakan service account berbeda untuk project/environment yang dipisahkan.
CLI menggunakan Application Default Credentials melalui
`GOOGLE_APPLICATION_CREDENTIALS`; tidak memakai token login pribadi `FIREBASE_TOKEN`.

Firebase hanya dipakai sebagai distributor hasil build. Aplikasi tidak memerlukan
Firebase SDK atau `google-services.json` untuk alur upload APK ini; backend,
autentikasi, dan database tetap mengikuti konfigurasi aplikasi yang ada.

## 3. Buat signing key

Contoh PowerShell (sesuaikan lokasi penyimpanan aman):

```powershell
keytool -genkeypair -v -keystore "$env:USERPROFILE/dikasa-upload.jks" `
  -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias dikasa

# Salin nilai ke ANDROID_KEYSTORE_BASE64 di GitHub Secret; jangan commit hasilnya.
[Convert]::ToBase64String([IO.File]::ReadAllBytes("$env:USERPROFILE/dikasa-upload.jks")) | Set-Clipboard
```

Untuk release lokal, salin `android/key.properties.example` menjadi
`android/key.properties` dan isi path/password yang sesuai. File asli diabaikan
Git. CI memasok nilai lewat environment, sehingga tidak perlu menulis password
ke Gradle properties. Jangan commit keystore/JSON credential.

## 4. Menjalankan dan mempromosikan

1. Merge kode yang sudah direview ke `main`; tunggu **Mobile CI** sukses.
2. **Mobile release** otomatis mengirim DEV ke Firebase. Catat **ID run Mobile CI**
   dari URL `.../actions/runs/<ID>` atau summary distribusi, bukan nomor build
   maupun ID run Mobile release.
3. Di **Actions → Mobile release → Run workflow**, pilih branch `main`, target
   `sit`, dan CI run ID tersebut.
4. Setelah pengujian SIT lulus, ulangi dengan `uat`, kemudian `stg`, lalu `prd`.
   Gunakan CI run ID yang sama, dan selesaikan approval environment bila diminta.
5. Ambil signed APK/AAB dan `release.json` dari artifact run. Manifest memuat
   source SHA, CI/release run ID, build number, endpoint, Firebase App ID,
   SHA-256 kontrak OpenAPI, dan SHA-256 binary. Release notes Firebase memuat
   environment, commit, dan build.

Run aktif tidak dibatalkan oleh rilis berikutnya. GitHub menyimpan satu run
pending per environment; dispatch baru dapat mengganti run yang masih pending.
Build number menggunakan nomor run
workflow release ditambah offset. Jangan menurunkan offset atau membuat ulang
workflow dengan penghitung baru tanpa memperhitungkan versionCode sebelumnya.
Rerun memakai build number yang sama; buat dispatch baru jika perlu versi baru.
Artifact distribusi disimpan 30 hari, debug APK 7 hari, coverage 14 hari;
arsipkan kandidat produksi lebih lama di tempat penyimpanan tim bila diperlukan.

Contoh Android lokal setelah ada flavor:

```powershell
flutter run --flavor dev --dart-define=USE_MOCK_API=true
flutter build apk --release --flavor uat `
  --dart-define=API_BASE_URL=https://api-uat.example.com/dikasa/v1 `
  --dart-define=USE_MOCK_API=false
flutter build appbundle --release --flavor prd `
  --dart-define=API_BASE_URL=https://api.example.com/dikasa/v1 `
  --dart-define=USE_MOCK_API=false
```

`--flavor` wajib untuk build/run Android. Perintah Flutter web/test tetap sama.
Manifest utama menyertakan izin `INTERNET` agar build release dapat mengakses API;
nama launcher mengikuti flavor yang dipilih.
Flutter dipin `3.44.2`, Java `17`, Node `22`, Firebase CLI `15.34.2`.
Lockfile aplikasi dilacak dan CI memakai `flutter pub get --enforce-lockfile`.
Action pihak ketiga dikunci ke commit SHA yang terverifikasi; Dependabot
memeriksa pembaruannya setiap bulan. Generated client tetap
divalidasi dari file committed; CI tidak menyembunyikan serializer yang hilang
dengan regeneration atau mengabaikan error analyzer. Regenerate melalui tool
repo, review, dan commit hasilnya sebelum merge jika kontrak berubah.

## Referensi

- [Flutter Android release dan signing](https://docs.flutter.dev/deployment/android)
- [Firebase CLI untuk distribusi Android](https://firebase.google.com/docs/app-distribution/android/distribute-cli)
- [Autentikasi service account Firebase](https://firebase.google.com/docs/app-distribution/authenticate-service-account?platform=android)
- [GitHub deployment environments](https://docs.github.com/en/actions/reference/workflows-and-actions/deployments-and-environments)

Aktivasi GitHub Environments, secret, registrasi Firebase, serta undangan tester
merupakan konfigurasi akun dan tidak otomatis dibuat oleh file repo ini.
Upload Play Store dapat ditambahkan setelah akun Play Console, service account,
dan track rilis ditentukan; AAB PRD saat ini disiapkan sebagai artifact.

Hasil dan batas pemeriksaan lokal dicatat di
[laporan verifikasi 4 November 2026](ci-cd-verification-2026-11-04.md).
