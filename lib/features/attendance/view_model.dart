import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'fingerprint_service.dart';
import 'models.dart';
import 'repository.dart';

class AttendanceViewModel extends ChangeNotifier {
  AttendanceViewModel({
    required AttendanceRepository repository,
    required FingerprintService fingerprint,
    required this.accountId,
    DateTime Function()? now,
  }) : _repository = repository,
       _fingerprint = fingerprint,
       _now = now ?? DateTime.now;
  final AttendanceRepository _repository;
  final FingerprintService _fingerprint;
  final DateTime Function() _now;
  final String accountId;
  List<StaffMember> staff = const [];
  StaffMember? selected;
  AttendanceEntry? entry;
  AttendanceMethod? method;
  String pin = '';
  String? error, success;
  bool busy = false,
      statusReady = false,
      fingerprintAvailable = false,
      uncertain = false;
  bool _disposed = false;
  DateTime? _serverTime, _receivedAt;
  DateTime get serverTime => _serverTime == null
      ? _now()
      : _serverTime!.add(_now().difference(_receivedAt!));
  bool get isSelf => selected?.id == accountId;
  bool get canClockIn =>
      statusReady &&
      !busy &&
      !uncertain &&
      (entry == null ||
          (entry!.clockOut != null && entry!.workDate != workDate(serverTime)));
  bool get canClockOut =>
      statusReady &&
      !busy &&
      !uncertain &&
      entry != null &&
      entry!.clockOut == null;
  bool get canFingerprint => isSelf && fingerprintAvailable;
  void _emit() {
    if (!_disposed) notifyListeners();
  }

  Future<void> _run(Future<void> Function() task) async {
    if (busy || _disposed) return;
    busy = true;
    error = null;
    success = null;
    _emit();
    try {
      await task();
    } on AttendanceOutcomeUncertain {
      uncertain = true;
      statusReady = false;
      error =
          'Hasil pengiriman belum pasti. Tekan Muat ulang untuk memeriksa absensi sebelum mencoba lagi.';
    } on ApiException catch (e) {
      error = e.message;
    } on FingerprintFailure catch (e) {
      error = e.message;
    } on PlatformException {
      error = 'Sensor fingerprint gagal diakses. Silakan gunakan PIN.';
    } catch (_) {
      error = 'Absensi gagal diproses. Silakan muat ulang dan coba lagi.';
    } finally {
      pin = '';
      busy = false;
      _emit();
    }
  }

  Future<void> load() => _run(() async {
    statusReady = false;
    staff = await _repository.employees();
    fingerprintAvailable = await _fingerprint.available();
    final previous = selected?.id;
    selected = staff.where((s) => s.id == (previous ?? accountId)).firstOrNull;
    entry = null;
    statusReady = false;
    if (selected != null) await _status();
  });
  Future<void> select(StaffMember value) => _run(() async {
    selected = value;
    method = null;
    entry = null;
    statusReady = false;
    uncertain = false;
    await _status();
  });
  Future<void> _status() async {
    final status = await _repository.status(selected!.id);
    entry = status.entry;
    _serverTime = status.serverTime;
    _receivedAt = _now();
    statusReady = true;
    uncertain = false;
  }

  Future<void> refresh() => _run(() async {
    statusReady = false;
    if (selected != null) {
      await _status();
    } else {
      staff = await _repository.employees();
    }
  });
  void chooseMethod(AttendanceMethod? value) {
    if (busy) return;
    method = value;
    pin = '';
    error = null;
    success = null;
    _emit();
  }

  void digit(String value) {
    if (!busy && pin.length < 6 && RegExp(r'^\d$').hasMatch(value)) {
      pin += value;
      _emit();
    }
  }

  void clear() {
    if (!busy) {
      pin = '';
      _emit();
    }
  }

  void backspace() {
    if (!busy && pin.isNotEmpty) {
      pin = pin.substring(0, pin.length - 1);
      _emit();
    }
  }

  Future<void> submit(AttendanceAction action) async {
    final enabled = action == AttendanceAction.clockIn
        ? canClockIn
        : canClockOut;
    if (!enabled || selected == null || method == null) return;
    if (method == AttendanceMethod.pin && pin.length != 6) {
      error = 'Masukkan 6 digit PIN absensi.';
      _emit();
      return;
    }
    await _run(() async {
      if (method == AttendanceMethod.pin) {
        entry = await _repository.pin(selected!.id, action, pin);
      } else {
        if (!canFingerprint || !selected!.fingerprintEnrolled) {
          throw const FingerprintFailure(
            'Daftarkan fingerprint akun sendiri menggunakan PIN terlebih dahulu.',
          );
        }
        final challenge = await _repository.challenge(action);
        final signature = await _fingerprint.sign(accountId, challenge.payload);
        entry = await _repository.biometric(challenge.id, signature);
      }
      success = action == AttendanceAction.clockIn
          ? 'Absen masuk berhasil. Selamat bekerja!'
          : 'Absen pulang berhasil. Selamat istirahat!';
    });
  }

  Future<void> enrollFingerprint() async {
    if (!canFingerprint || pin.length != 6) {
      error =
          'Masukkan 6 digit PIN akun sendiri untuk mendaftarkan fingerprint.';
      _emit();
      return;
    }
    await _run(() async {
      final key = await _fingerprint.enroll(accountId);
      await _repository.enroll(pin, key);
      staff = await _repository.employees();
      selected = staff.where((s) => s.id == accountId).firstOrNull;
      if (selected == null) {
        statusReady = false;
        throw const FingerprintFailure(
          'Akun tidak lagi tersedia pada outlet ini.',
        );
      }
      success = 'Fingerprint perangkat berhasil didaftarkan.';
    });
  }

  @override
  void dispose() {
    _disposed = true;
    pin = '';
    super.dispose();
  }
}
