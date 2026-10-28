import 'package:flutter/foundation.dart';
import '../../data/models/account_profile.dart';
import '../../data/models/catalog_product.dart';
import '../../data/services/account_service.dart';
import '../../data/services/account_files.dart';
import '../../data/repositories/auth_repository.dart';
import '../../core/network/api_exception.dart';

class AccountSettingsViewModel extends ChangeNotifier {
  AccountSettingsViewModel(
    this.service,
    this.auth, {
    AccountFiles files = const AccountFiles(),
  }) : _files = files,
       generation = auth.sessionGeneration {
    auth.addListener(accountChanged);
  }
  void accountChanged() {
    if (!disposed && generation != auth.sessionGeneration) {
      profile = null;
      busy = false;
      notifyListeners();
    }
  }

  final AccountService service;
  final AuthRepository auth;
  final AccountFiles _files;
  final int generation;
  AccountProfile? profile;
  List<GenderOption> genders = [];
  bool busy = false, disposed = false;
  String? message;
  bool get active =>
      !disposed && generation == auth.sessionGeneration && auth.isLoggedIn;
  String error(Object e) => e is ApiException
      ? e.message
      : 'Data akun gagal diproses. Silakan muat ulang.';

  Future<CatalogImage?> pickProfileImage() => _files.pickImage();
  Future<void> load() async {
    if (!active) return;
    busy = true;
    message = null;
    notifyListeners();
    try {
      final p = await service.profile();
      final g = await service.genders();
      if (!active) return;
      profile = p;
      genders = g;
      auth.replaceUser(p.user, expectedGeneration: generation);
    } catch (e) {
      if (active) message = error(e);
    } finally {
      if (active) {
        busy = false;
        notifyListeners();
      }
    }
  }

  Future<bool> save(
    Map<String, String> fields, {
    Uint8List? bytes,
    String? filename,
  }) async {
    if (!active || busy) return false;
    busy = true;
    message = null;
    notifyListeners();
    try {
      final p = await service.updateProfile(
        fields,
        avatarBytes: bytes,
        avatarFilename: filename,
      );
      if (!active) return false;
      profile = p;
      auth.replaceUser(p.user, expectedGeneration: generation);
      message = 'Profil berhasil disimpan.';
      return true;
    } catch (e) {
      if (active) message = error(e);
      return false;
    } finally {
      if (active) {
        busy = false;
        notifyListeners();
      }
    }
  }

  Future<void> credential(
    bool pin,
    String old,
    String next,
    String confirmation,
  ) async {
    if (!active || busy) return;
    busy = true;
    message = null;
    notifyListeners();
    try {
      if (pin) {
        await service.changePIN(old, next, confirmation);
      } else {
        await service.changePassword(old, next, confirmation);
      }
      if (!active) return;
      message = pin
          ? 'PIN berhasil disimpan.'
          : 'Password berhasil diubah. Gunakan password baru saat login berikutnya.';
      if (pin) {
        final p = await service.profile();
        if (active) profile = p;
      }
    } on CredentialOutcomeUncertainException {
      if (active) {
        message =
            'Hasil perubahan belum dapat dipastikan. Perubahan mungkin sudah tersimpan. Jangan ulangi otomatis; gunakan kredensial baru jika sudah berubah.';
      }
    } catch (e) {
      if (active) message = error(e);
    } finally {
      if (active) {
        busy = false;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    disposed = true;
    auth.removeListener(accountChanged);
    super.dispose();
  }
}
