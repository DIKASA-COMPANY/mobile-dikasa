import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/refund.dart';
import 'package:mobile_dikasa/data/services/refund_service.dart';

/// Account-bound refund form; uncertainty always retains the original command.
class RefundController extends ChangeNotifier {
  RefundController({
    required this.service,
    required this.accountId,
    required this.acquire,
    required this.release,
    required this.onCommitted,
  }) : _account = accountId();
  final RefundService service;
  final String? Function() accountId;
  final bool Function(Object) acquire;
  final void Function(Object) release;
  final Future<void> Function() onCommitted;
  final String? _account;
  ReceiptRefundDetail? detail;
  RefundPreview? quote;
  RefundRecord? result;
  String? error;
  String mode = 'items', reason = '', method = '';
  bool busy = false, uncertain = false, _disposed = false, _owns = false;
  int _generation = 0;
  Map<String, dynamic>? _pending;
  final quantities = <String, int>{}, returns = <String, int>{};
  bool get current => !_disposed && accountId() == _account;
  bool get locked => busy || uncertain;
  Map<String, dynamic> get selection => {
    'mode': mode,
    'method': method,
    'reason': reason,
    'expected_refund_revision': detail!.revision,
    'items': [
      for (final i in detail!.items)
        if ((quantities[i.id] ?? 0) > 0)
          {
            'transaction_item_id': i.id,
            'quantity': quantities[i.id],
            'restock_quantity': returns[i.id] ?? 0,
          },
    ],
  };
  void _notify() {
    if (current) notifyListeners();
  }

  Future<void> load(String id, String initialMode) async {
    if (!current || locked) return;
    if (!_owns) {
      _owns = acquire(this);
      if (!_owns) {
        error = 'Selesaikan operasi kasir yang sedang berjalan.';
        _notify();
        return;
      }
    }
    final g = ++_generation;
    busy = true;
    _notify();
    try {
      final d = await service.detail(id);
      if (!current || g != _generation) return;
      detail = d;
      mode = initialMode;
      method =
          [
            'cash',
            'wallet',
            'debit_card',
            'qris',
            'transfer',
          ].contains(d.method)
          ? d.method
          : '';
      quantities.clear();
      returns.clear();
      for (final i in d.items) {
        quantities[i.id] = mode == 'full' ? i.remaining : 0;
        returns[i.id] = 0;
      }
      quote = null;
      error = null;
    } on ApiException catch (e) {
      if (current) error = e.message;
    } finally {
      if (current && g == _generation) {
        busy = false;
        _notify();
      }
    }
  }

  void setQuantity(String id, int q) {
    if (!current || locked || detail == null) return;
    final i = detail!.items.firstWhere((i) => i.id == id);
    quantities[id] = q.clamp(0, i.remaining);
    returns[id] = (returns[id] ?? 0).clamp(0, quantities[id]!);
    quote = null;
    _notify();
  }

  void setReturn(String id, int q) {
    if (!current || locked) return;
    returns[id] = q.clamp(0, quantities[id] ?? 0);
    quote = null;
    _notify();
  }

  void setReason(String value) {
    if (!current || locked) return;
    reason = value;
    quote = null;
    _notify();
  }

  void setMethod(String value) {
    if (!current || locked) return;
    method = value;
    quote = null;
    _notify();
  }

  Future<void> preview() async {
    if (!current || locked || detail == null) return;
    busy = true;
    error = null;
    quote = null;
    _notify();
    try {
      final p = await service.preview(detail!.id, selection);
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
    final b = List<int>.generate(16, (_) => r.nextInt(256));
    b[6] = (b[6] & 15) | 64;
    b[8] = (b[8] & 63) | 128;
    final h = b.map((v) => v.toRadixString(16).padLeft(2, '0')).join();
    return '${h.substring(0, 8)}-${h.substring(8, 12)}-${h.substring(12, 16)}-${h.substring(16, 20)}-${h.substring(20)}';
  }

  Future<bool> confirm() async {
    if (!current || locked || quote == null || detail == null) return false;
    _pending =
        jsonDecode(
              jsonEncode({
                ...selection,
                'request_id': _uuid(),
                'preview_hash': quote!.hash,
              }),
            )
            as Map<String, dynamic>;
    return _send();
  }

  Future<bool> retryPending() async {
    if (busy || _pending == null || !current) return false;
    return _send();
  }

  Future<bool> _accepted(RefundRecord r) async {
    if (!current) return false;
    if (r.transactionId != detail!.id ||
        r.requestId != _pending!['request_id']) {
      uncertain = true;
      error =
          'Hasil refund tidak sesuai. Periksa riwayat; jangan kembalikan uang lagi.';
      return false;
    }
    result = r;
    _pending = null;
    uncertain = false;
    quote = null;
    // A refresh failure cannot undo the server's committed refund.
    try {
      await onCommitted();
    } on ApiException {
      if (current) {
        error = 'Refund tercatat. Muat ulang katalog untuk saldo terbaru.';
      }
    }
    if (!current) return false;
    return true;
  }

  Future<bool> _send() async {
    busy = true;
    error = null;
    _notify();
    try {
      return await _accepted(await service.confirm(detail!.id, _pending!));
    } on RefundUncertainException {
      if (current) {
        uncertain = true;
        error =
            'Status pencatatan refund belum pasti. Periksa hasil atau ulangi permintaan yang sama. Jangan kembalikan uang lagi.';
      }
      return false;
    } on ApiException catch (e) {
      if (current) {
        error = e.message;
        uncertain = false;
        _pending = null;
        quote = null;
      }
      return false;
    } finally {
      if (current) {
        busy = false;
        _notify();
      }
    }
  }

  Future<bool> resolvePending() async {
    if (busy || _pending == null || !current) return false;
    busy = true;
    error = null;
    _notify();
    try {
      final r = await service.byRequest(_pending!['request_id'] as String);
      if (!current) return false;
      if (r == null) {
        error =
            'Belum ada hasil terkonfirmasi. Permintaan mungkin masih berjalan; coba ulang ID yang sama.';
        return false;
      }
      return await _accepted(r);
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
    _generation++;
    if (_owns) release(this);
    super.dispose();
  }
}
