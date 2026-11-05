import 'package:biometric_signature/biometric_signature.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

abstract class FingerprintService {
  Future<bool> available();
  Future<String> enroll(String accountId);
  Future<String> sign(String accountId, String payload);
}

class FingerprintFailure implements Exception {
  const FingerprintFailure(this.message);
  final String message;
}

/// Uses a biometric-gated P-256 key; the backend verifies every signed challenge.
class DeviceFingerprintService implements FingerprintService {
  DeviceFingerprintService(this._plugin);
  final BiometricSignature _plugin;
  bool get _supported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);
  String _alias(String accountId) => 'dikasa-attendance-$accountId';

  @override
  Future<bool> available() async {
    if (!_supported) return false;
    try {
      final availability = await _plugin.biometricAuthAvailable();
      return availability.canAuthenticate == true &&
          (availability.availableBiometrics?.contains(
                BiometricType.fingerprint,
              ) ??
              false);
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  String _value(String? value, BiometricError? code) {
    if (code == BiometricError.success && value != null && value.isNotEmpty) {
      return value;
    }
    throw FingerprintFailure(switch (code) {
      BiometricError.userCanceled || BiometricError.systemCanceled =>
        'Pemindaian dibatalkan. Silakan coba lagi.',
      BiometricError.keyInvalidated || BiometricError.keyNotFound =>
        'Daftarkan ulang fingerprint perangkat ini menggunakan PIN.',
      BiometricError.lockedOut || BiometricError.lockedOutPermanent =>
        'Sensor terkunci. Gunakan PIN atau coba lagi nanti.',
      _ =>
        'Fingerprint tidak tersedia. Periksa sensor dan sidik jari di pengaturan perangkat.',
    });
  }

  @override
  Future<String> enroll(String accountId) async {
    if (!await available()) {
      throw const FingerprintFailure(
        'Perangkat ini belum memiliki fingerprint yang siap digunakan. Gunakan PIN.',
      );
    }
    final result = await _plugin.createKeys(
      keyAlias: _alias(accountId),
      keyFormat: KeyFormat.pem,
      promptMessage: 'Daftarkan fingerprint absensi',
      config: CreateKeysConfig(
        signatureType: SignatureType.ecdsa,
        enforceBiometric: true,
        requireAuthentication: true,
        useDeviceCredentials: false,
        setInvalidatedByBiometricEnrollment: true,
      ),
    );
    return _value(result.publicKey, result.code);
  }

  @override
  Future<String> sign(String accountId, String payload) async {
    final result = await _plugin.createSignature(
      keyAlias: _alias(accountId),
      payload: payload,
      signatureFormat: SignatureFormat.base64,
      promptMessage: 'Verifikasi fingerprint untuk absensi',
      config: CreateSignatureConfig(allowDeviceCredentials: false),
    );
    return _value(result.signature, result.code);
  }
}
