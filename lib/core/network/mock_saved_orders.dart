import 'dart:convert';

/// Deterministic mock API rejection with the same recovery codes as PostgreSQL.
class MockSavedOrderError implements Exception {
  const MockSavedOrderError(this.status, this.code, this.message);
  final int status;
  final String code, message;
}

/// Demo outlet draft storage; real persistence and concurrent locking are server-owned.
class MockSavedOrders {
  final _orders = <String, Map<String, dynamic>>{};
  final _commands = <String, ({String hash, Map<String, dynamic> result})>{};
  int _next = 0;
  Map<String, dynamic> _copy(Map<String, dynamic> j) =>
      jsonDecode(jsonEncode(j)) as Map<String, dynamic>;
  Never _conflict() => throw const MockSavedOrderError(
    409,
    'PESANAN_TERSIMPAN_BERUBAH',
    'Pesanan berubah. Muat ulang.',
  );
  Map<String, dynamic> get(String id) {
    final o = _orders[id];
    if (o == null) {
      throw const MockSavedOrderError(
        404,
        'TIDAK_DITEMUKAN',
        'Pesanan tidak ditemukan.',
      );
    }
    return _copy(o);
  }

  Map<String, dynamic> list(String search, int page) {
    final rows = _orders.values
        .where(
          (o) =>
              o['status'] == 'open' &&
              (o['label'] as String).toLowerCase().contains(
                search.toLowerCase(),
              ),
        )
        .toList()
        .reversed
        .toList();
    return {
      'data': rows.skip((page - 1) * 20).take(20).map(_copy).toList(),
      'meta': {'page': page, 'page_size': 20, 'total': rows.length},
    };
  }

  Map<String, dynamic> execute(
    String method,
    String? id,
    Map<String, dynamic> body,
  ) {
    final request = body['request_id'] as String?;
    if (request == null || request.isEmpty) {
      throw const MockSavedOrderError(
        422,
        'VALIDASI_GAGAL',
        'ID permintaan wajib diisi.',
      );
    }
    final hash = jsonEncode([method, id, body]);
    final previous = _commands[request];
    if (previous != null) {
      if (previous.hash != hash) {
        throw const MockSavedOrderError(
          409,
          'REQUEST_ID_DIGUNAKAN',
          'ID permintaan sudah digunakan.',
        );
      }
      return _copy(previous.result);
    }
    final o = method == 'POST'
        ? <String, dynamic>{
            'id': 'mock-saved-${++_next}',
            'created_by': 'mock-user',
            'creator_name': 'Demo Cashier',
            'created_at': DateTime.now().toUtc().toIso8601String(),
            'status': 'open',
            'revision': 1,
            'transaction_id': null,
          }
        : get(id!);
    if (method != 'POST') {
      if (o['status'] == 'paid') {
        throw const MockSavedOrderError(
          409,
          'PESANAN_SUDAH_DIBAYAR',
          'Pesanan sudah dibayar.',
        );
      }
      if (o['status'] != 'open' || o['revision'] != body['expected_revision']) {
        _conflict();
      }
      o['revision'] = (o['revision'] as int) + 1;
    }
    if (method == 'DELETE') {
      o['status'] = 'deleted';
    } else {
      final items = body['items'] as List?;
      final label = body['label'] as String? ?? '';
      int total = 0, quantity = 0;
      final keys = <String>{};
      if (items == null ||
          items.isEmpty ||
          items.length > 100 ||
          label.runes.length > 100 ||
          body['order_type_id'] == null) {
        throw const MockSavedOrderError(
          422,
          'VALIDASI_GAGAL',
          'Pesanan tidak valid.',
        );
      }
      for (final i in items) {
        final q = i['quantity'];
        final p = i['unit_price'];
        final key = '${i['product_id']}:${i['product_variant_id'] ?? 'base'}';
        if (q is! int ||
            q < 1 ||
            q > 1000 ||
            p is! int ||
            p < 0 ||
            p > 9007199254740991 ~/ q ||
            (i['notes'] as String? ?? '').runes.length > 500 ||
            !keys.add(key)) {
          throw const MockSavedOrderError(
            422,
            'VALIDASI_GAGAL',
            'Item tidak valid.',
          );
        }
        total += p * q;
        quantity += q;
        if (total > 9007199254740991) {
          throw const MockSavedOrderError(
            422,
            'VALIDASI_GAGAL',
            'Total terlalu besar.',
          );
        }
      }
      o.addAll({
        'label': label.trim().isEmpty ? 'Order ${o['id']}' : label.trim(),
        'order_type_id': body['order_type_id'],
        'items': items,
        'estimated_subtotal': total,
        'total_quantity': quantity,
      });
    }
    o['updated_at'] = DateTime.now().toUtc().toIso8601String();
    _orders[o['id'] as String] = _copy(o);
    _commands[request] = (hash: hash, result: _copy(o));
    return _copy(o);
  }

  void validatePayment(Map<String, dynamic> p) {
    final id = p['saved_order_id'] as String?;
    if (id == null) {
      if (p['saved_order_revision'] != null) _conflict();
      return;
    }
    final o = get(id);
    if (o['status'] == 'paid') {
      throw const MockSavedOrderError(
        409,
        'PESANAN_SUDAH_DIBAYAR',
        'Pesanan sudah dibayar.',
      );
    }
    if (o['status'] != 'open' ||
        o['revision'] != p['saved_order_revision'] ||
        o['order_type_id'] != p['order_type_id']) {
      _conflict();
    }
    final saved = {
      for (final i in o['items'] as List)
        '${i['product_id']}:${i['product_variant_id'] ?? 'base'}': i,
    };
    final items = p['items'] as List;
    if (items.length != saved.length) _conflict();
    for (final i in items) {
      final s = saved.remove(
        '${i['product_id']}:${i['product_variant_id'] ?? 'base'}',
      );
      if (s == null ||
          i['quantity'] != s['quantity'] ||
          i['unit_price'] != s['unit_price'] ||
          (i['notes'] ?? '').toString().trim() !=
              (s['notes'] ?? '').toString().trim()) {
        _conflict();
      }
    }
  }

  void completePayment(Map<String, dynamic> p, String receipt) {
    final id = p['saved_order_id'] as String?;
    if (id == null) return;
    final o = _orders[id]!;
    o['status'] = 'paid';
    o['revision'] = (o['revision'] as int) + 1;
    o['transaction_id'] = receipt;
    o['updated_at'] = DateTime.now().toUtc().toIso8601String();
  }
}
