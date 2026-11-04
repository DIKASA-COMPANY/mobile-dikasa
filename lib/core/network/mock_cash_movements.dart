part of 'mock_cash_sessions.dart';

extension MockCashMovementActions on MockCashSessions {
  Map<String, int> movementSummary(Map<String, dynamic> s) {
    var incoming = 0, outgoing = 0, count = 0;
    for (final m in _movements.where((m) => m['session_id'] == s['id'])) {
      count++;
      if (m['kind'] == 'in') {
        incoming = _sum(incoming, m['amount'] as int);
      } else {
        outgoing = _sum(outgoing, m['amount'] as int);
      }
    }
    return {'cash_in': incoming, 'cash_out': outgoing, 'movement_count': count};
  }

  Map<String, dynamic> movementCreate(
    String sid,
    Map<String, dynamic> b, {
    Uint8List? proof,
  }) => _movementWrite(sid, b, null, proof);
  Map<String, dynamic> movementReverse(
    String sid,
    String mid,
    Map<String, dynamic> b,
  ) => _movementWrite(sid, b, mid, null);
  Map<String, dynamic> _movementWrite(
    String sid,
    Map<String, dynamic> b,
    String? original,
    Uint8List? proof,
  ) {
    final s = _session(sid);
    final request = b['request_id'] as String;
    final body = {
      ...b,
      'session_id': sid,
      'actor': actorId,
      'reverse': original,
      'proof': proof == null ? null : base64Encode(proof),
    };
    final hash = _hash(body);
    final replay = _movementRequests[request];
    if (replay != null) {
      if (replay.hash != hash) {
        _fail('CASH_MOVEMENT_REQUEST_USED', 'ID sudah dipakai.');
      }
      return _copy(replay.response);
    }
    if (s['status'] != 'open') {
      _fail('SESI_KAS_SUDAH_DITUTUP', 'Sesi sudah ditutup.');
    }
    if (!_can(s)) {
      _fail(
        'CASH_MOVEMENT_FORBIDDEN',
        'Hanya kasir pembuka atau manager.',
        403,
      );
    }
    final reason = (b['reason'] as String? ?? '').trim();
    var name = (b['name'] as String? ?? '').trim(),
        kind = b['kind'] as String? ?? '';
    var amount = b['amount'] as int? ?? 0;
    if (original != null) {
      final o = movementDetail(sid, original);
      if (o['can_reverse'] != true) {
        _fail('CASH_MOVEMENT_ALREADY_REVERSED', 'Entri tidak dapat dikoreksi.');
      }
      final m = o['movement'] as Map;
      kind = m['kind'] == 'in' ? 'out' : 'in';
      amount = m['amount'] as int;
      name = m['name'] as String;
    }
    if (reason.isEmpty ||
        reason.runes.length > 500 ||
        name.isEmpty ||
        name.runes.length > 120 ||
        !['in', 'out'].contains(kind) ||
        amount < 1 ||
        amount > 9007199254740991) {
      _fail('CASH_MOVEMENT_INVALID', 'Periksa data kas.', 422);
    }
    final expected = _summary(s)['expected_cash'] as int;
    if (kind == 'out' && amount > expected) {
      _fail('CASH_MOVEMENT_INSUFFICIENT_CASH', 'Nominal keluar melebihi kas.');
    }
    if (proof != null && proof.length > 3145728) {
      _fail('CASH_PROOF_TOO_LARGE', 'Bukti maksimal3 MiB.', 413);
    }
    final m = <String, dynamic>{
      'id': 'mock-movement-${_movements.length + 1}',
      'outlet_id': 'mock-outlet',
      'session_id': sid,
      'request_id': request,
      'created_by': actorId,
      'created_by_name': 'Jane Doe',
      'created_at': DateTime.now().toUtc().toIso8601String(),
      'kind': kind,
      'amount': amount,
      'name': name,
      'reason': reason,
      'reverses_id': original,
      'has_proof': proof != null,
    };
    _movements.add(m);
    try {
      final summary = _summary(s);
      _sum(
        _sum(summary['opening_cash'] as int, summary['cash_sales'] as int),
        summary['cash_in'] as int,
      );
    } catch (e) {
      _movements.removeLast();
      rethrow;
    }
    if (proof != null) {
      _movementProofs[m['id'] as String] = Uint8List.fromList(proof);
    }
    _movementRequests[request] = (hash: hash, response: _copy(m));
    return _copy(m);
  }

  Map<String, dynamic> movementDetail(String sid, String mid) {
    final s = _session(sid);
    final m = _movements
        .where((m) => m['id'] == mid && m['session_id'] == sid)
        .firstOrNull;
    if (m == null) _fail('DATA_TIDAK_DITEMUKAN', 'Entri tidak ditemukan.', 404);
    final reversed = _movements
        .where((r) => r['reverses_id'] == mid)
        .firstOrNull;
    return {
      'movement': _copy(m),
      'can_reverse':
          s['status'] == 'open' &&
          _can(s) &&
          (role == 'manager' || m['created_by'] == actorId) &&
          m['reverses_id'] == null &&
          reversed == null,
      'reversed_by_id': reversed?['id'],
    };
  }

  Map<String, dynamic> movementByRequest(String sid, String id) {
    final m = _movementRequests[id]?.response;
    if (m == null || m['session_id'] != sid || m['created_by'] != actorId) {
      _fail('DATA_TIDAK_DITEMUKAN', 'Belum ditemukan.', 404);
    }
    return _copy(m);
  }

  Uint8List movementProof(String sid, String mid) {
    movementDetail(sid, mid);
    final b = _movementProofs[mid];
    if (b == null) _fail('DATA_TIDAK_DITEMUKAN', 'Bukti tidak ditemukan.', 404);
    return Uint8List.fromList(b);
  }

  Map<String, dynamic> movementActivity(String sid, int page) {
    final d = detail(sid);
    final summary = d['summary'] as Map<String, dynamic>?;
    Map<String, dynamic>? totals;
    if (summary != null) {
      final incoming = _sum(
        _sum(summary['opening_cash'] as int, summary['cash_sales'] as int),
        (summary['cash_in'] as int?) ?? 0,
      );
      final outgoing = _sum(
        summary['cash_refunds'] as int,
        (summary['cash_out'] as int?) ?? 0,
      );
      totals = {
        'opening': summary['opening_cash'],
        ...summary,
        'total_in': incoming,
        'total_out': outgoing,
        'cash_in': summary['cash_in'] ?? 0,
        'cash_out': summary['cash_out'] ?? 0,
        'movement_count': summary['movement_count'] ?? 0,
      };
    }
    final events = <Map<String, dynamic>>[
      {
        'id': 'opening/$sid',
        'source_id': sid,
        'kind': 'opening',
        'direction': 'in',
        'amount': d['opening_cash'],
        'name': 'Modal Awal',
        'reason': '',
        'occurred_at': d['opened_at'],
        'created_by': d['user_id'],
        'created_by_name': d['opening_user_name'],
      },
    ];
    for (final s in sales.where(
      (s) => s['cash_session_id'] == sid && s['payment_method'] == 'cash',
    )) {
      events.add({
        'id': 'sale/${s['id']}',
        'source_id': s['id'],
        'kind': 'sale',
        'direction': 'in',
        'amount': (s['paid_amount'] as int) - (s['change_amount'] as int),
        'name': 'Penjualan ${s['receipt_number']}',
        'reason': '',
        'occurred_at': s['ordered_at'],
        'created_by_name': 'Jane Doe',
      });
    }
    for (final r in refunds().where(
      (r) => r['cash_session_id'] == sid && r['method'] == 'cash',
    )) {
      events.add({
        'id': 'refund/${r['id']}',
        'source_id': r['id'],
        'kind': 'refund',
        'direction': 'out',
        'amount': r['total_amount'],
        'name': 'Refund',
        'reason': r['reason'] ?? '',
        'occurred_at': r['created_at'],
        'created_by_name': r['actor_name'] ?? '',
      });
    }
    for (final m in _movements.where((m) => m['session_id'] == sid)) {
      events.add({
        ...m,
        'id': 'movement/${m['id']}',
        'source_id': m['id'],
        'kind': m['reverses_id'] == null ? 'movement' : 'reversal',
        'direction': m['kind'],
        'occurred_at': m['created_at'],
      });
    }
    events.sort((a, b) {
      final order = (a['occurred_at'] as String).compareTo(
        b['occurred_at'] as String,
      );
      return order == 0
          ? (a['id'] as String).compareTo(b['id'] as String)
          : order;
    });
    return {
      'data': {
        'session': d,
        'totals': totals,
        'capabilities': {
          'can_create':
              d['status'] == 'open' &&
              d['reconciliation_supported'] == true &&
              _can(d),
          'can_upload_proof':
              d['status'] == 'open' &&
              d['reconciliation_supported'] == true &&
              _can(d),
        },
        'events': events.skip((page - 1) * 20).take(20).toList(),
      },
      'meta': {'page': page, 'page_size': 20, 'total': events.length},
    };
  }
}
