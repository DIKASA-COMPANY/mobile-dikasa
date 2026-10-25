import 'dart:convert';
import 'dart:typed_data';
part 'mock_cash_movements.dart';

class MockCashError implements Exception {
  const MockCashError(this.status, this.code, this.message);
  final int status;
  final String code, message;
}

/// Memory-only session ledger sharing the existing sale/refund collections.
class MockCashSessions {
  MockCashSessions(
    this.sales,
    this.refunds, {
    this.actorId = '1',
    this.role = 'cashier',
  });
  final List<Map<String, dynamic>> sales;
  final List<Map<String, dynamic>> Function() refunds;
  final String actorId, role;
  final _sessions = <Map<String, dynamic>>[];
  final _movements = <Map<String, dynamic>>[];
  final _movementRequests =
      <String, ({String hash, Map<String, dynamic> response})>{};
  final _movementProofs = <String, Uint8List>{};
  final _requests = <String, ({String hash, Map<String, dynamic> response})>{};
  Map<String, dynamic> _copy(Map<String, dynamic> m) =>
      jsonDecode(jsonEncode(m)) as Map<String, dynamic>;
  Never _fail(String c, String m, [int status = 409]) =>
      throw MockCashError(status, c, m);
  Map<String, dynamic>? get current {
    for (final s in _sessions) {
      if (s['status'] == 'open') return _copy(s);
    }
    return null;
  }

  Map<String, dynamic> open(int n) {
    if (n < 0 || n > 9007199254740991) {
      _fail('HITUNGAN_KAS_TIDAK_VALID', 'Nominal tidak valid.', 422);
    }
    final active = current;
    if (active != null) return active;
    final s = <String, dynamic>{
      'id': 'mock-cash-${_sessions.length + 1}',
      'user_id': actorId,
      'opening_user_name': 'Jane Doe',
      'outlet_id': 'mock-outlet',
      'opening_cash': n,
      'opened_at': DateTime.now().toUtc().toIso8601String(),
      'status': 'open',
      'closing': null,
    };
    _sessions.insert(0, s);
    return _copy(s);
  }

  Map<String, dynamic> _session(String id) => _sessions.firstWhere(
    (s) => s['id'] == id,
    orElse: () => throw const MockCashError(
      404,
      'SESI_KAS_TIDAK_DITEMUKAN',
      'Sesi tidak ditemukan.',
    ),
  );
  int _n(dynamic v) {
    if (v is! int || v.abs() > 9007199254740991) {
      _fail(
        'REKONSILIASI_TIDAK_DIDUKUNG',
        'Nominal tidak dapat diverifikasi.',
        422,
      );
    }
    return v;
  }

  int _sum(int a, int b) {
    final n = BigInt.from(a) + BigInt.from(b);
    if (n.abs() > BigInt.parse('9007199254740991')) {
      _fail('REKONSILIASI_TIDAK_DIDUKUNG', 'Nominal melebihi batas.', 422);
    }
    return n.toInt();
  }

  bool _can(Map<String, dynamic> s) =>
      role == 'manager' || role == 'cashier' && s['user_id'] == actorId;
  Map<String, dynamic> _summary(Map<String, dynamic> s) {
    var cashSales = 0, cashRefunds = 0, sc = 0, rc = 0;
    final methods = <String, Map<String, dynamic>>{};
    Map<String, dynamic> method(String key) => methods.putIfAbsent(
      key,
      () => {
        'method': key,
        'sale_count': 0,
        'sales_amount': 0,
        'refund_count': 0,
        'refunds_amount': 0,
      },
    );
    for (final a in sales.where((a) => a['cash_session_id'] == s['id'])) {
      if ((a['status'] == 'refunded' || a['status'] == 'cancelled') &&
          (a['refund_revision'] ?? 0) == 0) {
        _fail(
          'REKONSILIASI_TIDAK_DIDUKUNG',
          'Catatan lama tidak lengkap.',
          422,
        );
      }
      final k = a['payment_method'] as String;
      if (![
        'cash',
        'wallet',
        'debit_card',
        'qris',
        'transfer',
        'point',
      ].contains(k)) {
        _fail('REKONSILIASI_TIDAK_DIDUKUNG', 'Metode tidak dikenal.', 422);
      }
      final m = method(k);
      sc++;
      m['sale_count']++;
      m['sales_amount'] = _sum(m['sales_amount'] as int, _n(a['total_amount']));
      if (k == 'cash') {
        final paid = _n(a['paid_amount']), change = _n(a['change_amount']);
        if (change > paid || change < 0 || paid < 0) {
          _fail('REKONSILIASI_TIDAK_DIDUKUNG', 'Kembalian tidak valid.', 422);
        }
        cashSales = _sum(cashSales, paid - change);
      }
    }
    for (final a in refunds().where((a) => a['cash_session_id'] == s['id'])) {
      final k = a['method'] as String;
      final m = method(k);
      rc++;
      m['refund_count']++;
      m['refunds_amount'] = _sum(
        m['refunds_amount'] as int,
        _n(a['total_amount']),
      );
      if (k == 'cash') cashRefunds = _sum(cashRefunds, _n(a['total_amount']));
    }
    final keys = methods.keys.toList()..sort();
    final manual = movementSummary(s);
    final expected =
        BigInt.from(_n(s['opening_cash'])) +
        BigInt.from(cashSales) -
        BigInt.from(cashRefunds) +
        BigInt.from(manual['cash_in']!) -
        BigInt.from(manual['cash_out']!);
    if (expected.abs() > BigInt.parse('9007199254740991')) {
      _fail('REKONSILIASI_TIDAK_DIDUKUNG', 'Nominal melebihi batas.', 422);
    }
    return {
      'session_id': s['id'],
      'opening_user_id': s['user_id'],
      'opening_user_name': s['opening_user_name'],
      'opened_at': s['opened_at'],
      'opening_cash': s['opening_cash'],
      'cash_sales': cashSales,
      ...manual,
      'cash_refunds': cashRefunds,
      'expected_cash': expected.toInt(),
      'sale_count': sc,
      'refund_count': rc,
      'methods': [for (final k in keys) methods[k]],
    };
  }

  Map<String, dynamic> detail(String id) {
    final s = _session(id);
    final d = _copy(s);
    d['can_close'] = s['status'] == 'open' && _can(s);
    d['reconciliation_supported'] = true;
    try {
      d['summary'] = s['closing'] != null
          ? s['closing']['summary']
          : _summary(s);
    } on MockCashError catch (e) {
      d['summary'] = null;
      d['can_close'] = false;
      d['reconciliation_supported'] = false;
      d['unsupported_reason'] = e.message;
    }
    return _copy(d);
  }

  Map<String, dynamic> list(int page) => {
    'data': _sessions
        .skip((page - 1) * 20)
        .take(20)
        .map((s) => detail(s['id'] as String))
        .toList(),
    'meta': {'total': _sessions.length, 'page': page, 'page_size': 20},
  };
  String _hash(Object value) {
    var h = BigInt.parse('1469598103934665603');
    for (final b in utf8.encode(jsonEncode(value))) {
      h =
          ((h ^ BigInt.from(b)) * BigInt.from(1099511628211)) &
          ((BigInt.one << 64) - BigInt.one);
    }
    return List.filled(4, h.toRadixString(16).padLeft(16, '0')).join();
  }

  Map<String, dynamic> preview(String id, Map<String, dynamic> b,{bool allowMissingReason=false}) {
    final s = _session(id);
    if (!_can(s)) {
      _fail('AKSES_DITOLAK', 'Hanya kasir pembuka atau manager.', 403);
    }
    if (s['status'] != 'open') {
      _fail('SESI_KAS_SUDAH_DITUTUP', 'Sesi sudah ditutup.');
    }
    final summary = _summary(s);
    final counted = _n(b['counted_cash']);
    final reason = (b['reason'] as String).trim();
    if (counted < 0 || reason.runes.length > 500) {
      _fail('HITUNGAN_KAS_TIDAK_VALID', 'Periksa nominal dan alasan.', 422);
    }
    final difference = _sum(counted, -_n(summary['expected_cash']));
    if (difference != 0 && reason.isEmpty && !allowMissingReason) {
      _fail('HITUNGAN_KAS_TIDAK_VALID', 'Alasan selisih wajib.', 422);
    }
    final activity = [
      for (final a in sales.where((a) => a['cash_session_id'] == id))
        [
          'sale',
          a['id'],
          a['payment_method'],
          a['paid_amount'],
          a['change_amount'],
          a['total_amount'],
        ],
      for (final a in refunds().where((a) => a['cash_session_id'] == id))
        ['refund', a['id'], a['method'], a['total_amount']],
    ]..sort((a, b) => jsonEncode(a).compareTo(jsonEncode(b)));
    return {
      'summary': summary,
      'counted_cash': counted,
      'difference': difference,
      'reason': reason,
      'preview_hash': _hash([id, summary, activity, counted, reason,_movements.where((m)=>m['session_id']==id).toList()]),
    };
  }

  Map<String, dynamic> close(String id, Map<String, dynamic> b) {
    final key = b['request_id'] as String;
    final hash = _hash([
      actorId,
      id,
      b['counted_cash'],
      (b['reason'] as String).trim(),
      b['preview_hash'],
    ]);
    final old = _requests[key];
    if (old != null) {
      if (old.hash != hash) _fail('REQUEST_ID_DIGUNAKAN', 'ID sudah dipakai.');
      return _copy(old.response);
    }
    final p = preview(id, b,allowMissingReason:true);
    if (p['preview_hash'] != b['preview_hash']) {
      _fail('SESI_KAS_PRATINJAU_BERUBAH', 'Aktivitas berubah. Muat ulang.');
    }
    if(p['difference']!=0&&(p['reason'] as String).isEmpty)_fail('HITUNGAN_KAS_TIDAK_VALID','Alasan selisih wajib.',422);
 final s = _session(id);
    final r = <String, dynamic>{
      ...p,
      'session_id': id,
      'closed_by': actorId,
      'closed_by_name': 'Jane Doe',
      'closed_at': DateTime.now().toUtc().toIso8601String(),
      'close_request_id': key,
    };
    s['status'] = 'closed';
    s['closing_cash'] = p['counted_cash'];
    s['closed_at'] = r['closed_at'];
    s['closing'] = _copy(r);
    _requests[key] = (hash: hash, response: _copy(r));
    return _copy(r);
  }
}
