import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/cash_reconciliation.dart';
import 'package:mobile_dikasa/data/services/cash_reconciliation_service.dart';

/// Account-bound physical count and frozen uncertain command for one session.
class CashClosingController extends ChangeNotifier {
  CashClosingController({
    required this.service,
    required this.accountId,
    required this.acquire,
    required this.release,
    required this.onCommitted,
  }) : _account = accountId();
  final CashReconciliationService service;
  final String? Function() accountId;
  final bool Function(Object) acquire;
  final void Function(Object) release;
  final Future<void> Function() onCommitted;
  final String? _account;
  CashSessionRecord? detail;
  CashClosePreview? quote;
  CashClosedRecord? result;
  String? error;
  String countedText = '', reason = '';
  bool busy = false, uncertain = false, _owns = false, _disposed = false;
  String? _id;
  Map<String, dynamic>? _pending;
  bool get current => !_disposed && accountId() == _account;
  bool get locked => busy || uncertain;
  void _notify() {
    if (current) notifyListeners();
  }

  Future<void> load(String id) async {
    if (!current || locked || result != null) return;
    if (_id != null && _id != id) return;
    _id = id;
    if (!_owns) {
      _owns = acquire(this);
      if (!_owns) {
        error = 'Selesaikan operasi kasir yang sedang berjalan.';
        _notify();
        return;
      }
    }
    busy = true;
    error = null;
    quote = null;
    _notify();
    try {
      final d = await service.detail(id);
      if (current) detail = d;
    } on ApiException catch (e) {
      if (current) error = e.message;
    } finally {
      if (current) {
        busy = false;
        _notify();
      }
    }
  }

  void setCountedCash(String v) {
    if (!current || locked || result != null) return;
    countedText = v;
    quote = null;
    _notify();
  }

  void setReason(String v) {
    if (!current || locked || result != null) return;
    reason = v;
    quote = null;
    _notify();
  }

  Map<String, dynamic>? get _selection {
    final n = int.tryParse(countedText.replaceAll('.', ''));
    if (n == null || n < 0 || n > 9007199254740991) return null;
    return {'counted_cash': n, 'reason': reason};
  }

  Future<void> preview() async {
    if (!current || locked || detail?.canClose != true || result != null) {
      return;
    }
    final b = _selection;
    if (b == null) {
      error = 'Masukkan jumlah kas yang dihitung, termasuk 0.';
      _notify();
      return;
    }
    busy = true;
    quote = null;
    error = null;
    _notify();
    try {
      final p = await service.preview(_id!, b);
      if (current) quote = p;
    } on ApiException catch (e) {
      if (current) error = e.message;
    } finally {
      if (current) {
        busy = false;
        _notify();
      }
    }
  }

  String _uuid() {
    final r = Random.secure();
    final b = List.generate(16, (_) => r.nextInt(256));
    b[6] = (b[6] & 15) | 64;
    b[8] = (b[8] & 63) | 128;
    final h = b.map((v) => v.toRadixString(16).padLeft(2, '0')).join();
    return '${h.substring(0, 8)}-${h.substring(8, 12)}-${h.substring(12, 16)}-${h.substring(16, 20)}-${h.substring(20)}';
  }

  Future<bool> confirm() async {
    if (!current || locked || quote == null || result != null) return false;
    _pending =
        jsonDecode(
              jsonEncode({
                ..._selection!,
                'request_id': _uuid(),
                'preview_hash': quote!.hash,
              }),
            )
            as Map<String, dynamic>;
    return _send();
  }

  Future<bool> _accepted(CashClosedRecord r) async {
    if (!current) return false;
    if (r.sessionId != _id || r.requestId != _pending!['request_id']) {
      uncertain = true;
      error = 'Hasil penutupan berbeda. Periksa sesi ini sebelum melanjutkan.';
      return false;
    }
    result = r;
    quote = null;
    _pending = null;
    uncertain = false;
    try {
      await onCommitted();
    } on ApiException {
      if (current) {
        error =
            'Sesi ditutup. Muat ulang status kas sebelum transaksi berikutnya.';
      }
    }
    return current;
  }

  Future<bool> _send() async {
    busy = true;
    error = null;
    _notify();
    try {
      return await _accepted(await service.close(_id!, _pending!));
    } on CashCloseUncertainException {
      if (current) {
        uncertain = true;
        error =
            'Hasil penutupan belum pasti. Periksa sesi ini atau ulangi permintaan yang sama.';
      }
      return false;
    } on ApiException catch (e) {
      if (current) {
        error = e.message;
        quote = null;
        _pending = null;
        uncertain = false;
      }
      return false;
    } finally {
      if (current) {
        busy = false;
        _notify();
      }
    }
  }

  Future<bool> retryPending() async {
    if (!current || busy || _pending == null) return false;
    return _send();
  }

  Future<bool> resolvePending() async {
    if (!current || busy || _pending == null) return false;
    busy = true;
    error = null;
    _notify();
    try {
      final d = await service.detail(_id!);
      if (!current) return false;
      if (d.closing != null) {
        if (d.closing!.requestId != _pending!['request_id']) {
          detail = d;
          uncertain = false;
          _pending = null;
          quote = null;
          error =
              'Sesi sudah ditutup melalui permintaan lain. Periksa ringkasan.';
          return false;
        }
        return await _accepted(d.closing!);
      }
      error =
          'Belum ada hasil terkonfirmasi. Sesi mungkin masih diproses; coba ulangi ID yang sama.';
      return false;
    } on ApiException catch (e) {
      if (current) error = e.message;
      return false;
    } finally {
      if (current) {
        busy = false;
        _notify();
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    if (_owns) release(this);
    super.dispose();
  }
}
