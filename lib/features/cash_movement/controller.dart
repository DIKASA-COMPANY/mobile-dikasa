import 'dart:math';
import 'package:flutter/foundation.dart';
import '../../data/models/cash_movement.dart';
import '../../data/services/cash_movement_service.dart';
import '../../data/repositories/auth_repository.dart';
import '../../core/network/api_exception.dart';

/// POS-owned pending intent survives view disposal, but never account changes.
class CashMovementController extends ChangeNotifier {
  CashMovementController({
    required this.service,
    required this.auth,
    required this.acquire,
    required this.release,
  }) : generation = auth.sessionGeneration {
    auth.addListener(_accountChanged);
  }
  final CashMovementService service;
  final AuthRepository auth;
  final bool Function(Object) acquire;
  final void Function(Object) release;
  final int generation;
  CashActivity? activity;
  PendingCashMovement? pending;
  bool busy = false, uncertain = false, disposed = false, _owns = false;
  String? error;
  String? sessionId;
  int page = 1;
  int _readRequest = 0;
  bool get current =>
      !disposed && generation == auth.sessionGeneration && auth.isLoggedIn;
  bool get locked => busy || uncertain;
  void _notify() {
    if (current) notifyListeners();
  }

  void _accountChanged() {
    if (generation != auth.sessionGeneration && !disposed) {
      pending = null;
      activity = null;
      uncertain = false;
      busy = false;
      _readRequest++;
      _unlock();
      notifyListeners();
    }
  }

  void _unlock() {
    if (_owns) {
      release(this);
      _owns = false;
    }
  }

  String _message(Object e) => e is ApiException
      ? e.message
      : 'Data kas gagal diproses. Coba muat ulang.';
  static String requestUUID() {
    final b = List.generate(16, (_) => Random.secure().nextInt(256));
    b[6] = (b[6] & 15) | 64;
    b[8] = (b[8] & 63) | 128;
    final h = b.map((v) => v.toRadixString(16).padLeft(2, '0')).join();
    return '${h.substring(0, 8)}-${h.substring(8, 12)}-${h.substring(12, 16)}-${h.substring(16, 20)}-${h.substring(20)}';
  }

  Future<void> load(String id, {int requestedPage = 1}) async {
    if (!current || locked) return;
    final r = ++_readRequest;
    if (activity?.session.id != id) activity = null;
    sessionId = id;
    page = requestedPage;
    busy = true;
    error = null;
    _notify();
    try {
      final a = await service.activity(id, page: page);
      if (a.session.id != id) throw const FormatException('Wrong cash session');
      if (current && r == _readRequest) activity = a;
    } catch (e) {
      if (current && r == _readRequest) error = _message(e);
    } finally {
      if (current && r == _readRequest) {
        busy = false;
        _notify();
      }
    }
  }

  Future<bool> create({
    required String kind,
    required String name,
    required int amount,
    required String reason,
    Uint8List? bytes,
    String? filename,
  }) async {
    if (!current || locked || pending != null || sessionId == null) {
      return false;
    }
    if (!_owns) {
      _owns = acquire(this);
      if (!_owns) {
        error = 'Selesaikan operasi kasir yang sedang berjalan.';
        _notify();
        return false;
      }
    }
    pending = PendingCashMovement(
      sessionId: sessionId!,
      requestId: requestUUID(),
      kind: kind,
      name: name.trim(),
      amount: amount,
      reason: reason.trim(),
      proofBytes: bytes,
      proofName: filename,
    );
    return _send();
  }

  Future<bool> reverse(CashMovementRecord original, String reason) async {
    if (!current || locked || pending != null) return false;
    _owns = acquire(this);
    if (!_owns) return false;
    pending = PendingCashMovement(
      sessionId: original.sessionId,
      requestId: requestUUID(),
      kind: '',
      name: '',
      amount: 0,
      reason: reason.trim(),
      reverseId: original.id,
    );
    return _send();
  }

  Future<bool> _send() async {
    final p = pending;
    if (p == null || !current) return false;
    busy = true;
    error = null;
    _notify();
    try {
      final m = p.reverseId == null
          ? await service.create(p.sessionId, p)
          : await service.reverse(p.sessionId, p.reverseId!, p);
      if (!current) return false;
      if (m.requestId != p.requestId || m.sessionId != p.sessionId) {
        throw const CashMovementUncertainException();
      }
      pending = null;
      uncertain = false;
      _unlock();
      return true;
    } on CashMovementUncertainException {
      if (current) {
        uncertain = true;
        error =
            'Hasil belum pasti. Pulihkan permintaan asli atau kirim ulang dengan ID yang sama. Jangan buat transaksi baru.';
      }
    } catch (e) {
      if (current) {
        error = _message(e);
        if (!uncertain) {
          pending = null;
          _unlock();
        }
      }
    } finally {
      if (current) {
        busy = false;
        _notify();
      }
    }
    return false;
  }

  Future<bool> recover() async {
    final p = pending;
    if (!current || busy || p == null) return false;
    busy = true;
    error = null;
    _notify();
    try {
      final m = await service.byRequest(p.sessionId, p.requestId);
      if (!current) return false;
      if (m.requestId != p.requestId || m.sessionId != p.sessionId) {
        throw const FormatException('Wrong recovery');
      }
      pending = null;
      uncertain = false;
      _unlock();
      return true;
    } catch (e) {
      if (current) {
        error =
            'Belum dapat memastikan hasil. Permintaan asli tetap terkunci; coba pemulihan atau kirim ulang yang sama.';
      }
    } finally {
      if (current) {
        busy = false;
        _notify();
      }
    }
    return false;
  }

  Future<bool> retry() async {
    if (!current || busy || pending == null) return false;
    return _send();
  }

  @override
  void dispose() {
    disposed = true;
    auth.removeListener(_accountChanged);
    pending = null;
    activity = null;
    _unlock();
    super.dispose();
  }
}
