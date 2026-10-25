import 'dart:convert';
import 'mock_catalog.dart';

/// Demo-only rejection mirrors refund HTTP status and stable codes.
class MockRefundError implements Exception {
  const MockRefundError(this.status, this.code, this.message);
  final int status;
  final String code, message;
}

/// In-memory refund ledger sharing the existing demo receipts and catalog.
class MockRefunds {
  MockRefunds(this.orders, this.catalog, this.hasCash, {this.currentSessionId});
 final String? Function()? currentSessionId;
 List<Map<String,dynamic>> get cashActivity=>_records.map(_copy).toList();
  final List<Map<String, dynamic>> orders;
  final MockCatalog catalog;
  final bool Function() hasCash;
  final _records = <Map<String, dynamic>>[];
  final _requests = <String, ({String hash, Map<String, dynamic> response})>{};
  final _deductions = <String, Map<String, int>>{};
  Map<String, dynamic> _copy(Map<String, dynamic> m) =>
      jsonDecode(jsonEncode(m)) as Map<String, dynamic>;
  Never _error(String code, String message, [int status = 409]) =>
      throw MockRefundError(status, code, message);
  Map<String, dynamic> _sale(String id) {
    final s = orders.where((s) => s['id'] == id).firstOrNull;
    if (s == null) {
      _error('DATA_TIDAK_DITEMUKAN', 'Transaksi tidak ditemukan.', 404);
    }
    return s;
  }

  void registerSale(Map<String, dynamic> sale) {
    final id = sale['id'] as String;
    final units = <String, int>{};
    final lines = <Map<String, dynamic>>[];
    for (final (index, item) in (sale['items'] as List).indexed) {
      final i = Map<String, dynamic>.from(item as Map);
      i['id'] = '$id-item-$index';
      lines.add(i);
      final p = catalog.products
          .where((p) => p['id'] == i['product_id'])
          .firstOrNull;
      final category=p?['category'] as Map?;
      if(category!=null){i['category_id_snapshot']=category['id'];i['category_name_snapshot']=category['name'];}
      if (p?['track_stock'] == true) {
        units[i['product_id'] as String] =
            (units[i['product_id']] ?? 0) + (i['quantity'] as int);
      }
    }
    sale['items'] = lines;
    sale.addAll({
      'transaction_number': sale['receipt_number'],
      'refund_revision': 0,
      'refunded_amount': 0,
      'net_after_refund': sale['total_amount'],
      'refunds_supported': true,
    });
    _deductions[id] = units;
  }

  Map<String, dynamic> detail(String id) {
    final s = _sale(id);
    final records = _records.where((r) => r['transaction_id'] == id);
    final refunded = <String, int>{},
        returned = <String, int>{},
        parentReturns = <String, int>{};
    var total = 0;
    final originals = (s['items'] as List).cast<Map<String, dynamic>>();
    for (final r in records) {
      total += r['total_amount'] as int;
      for (final i in r['items'] as List) {
        final key = i['transaction_item_id'] as String;
        refunded[key] = (refunded[key] ?? 0) + (i['quantity'] as int);
        returned[key] = (returned[key] ?? 0) + (i['restock_quantity'] as int);
        final p =
            originals.firstWhere((o) => o['id'] == key)['product_id'] as String;
        parentReturns[p] =
            (parentReturns[p] ?? 0) + (i['restock_quantity'] as int);
      }
    }
    return {
      ...s,
      'refunds_supported':
          s['status'] != 'cancelled' &&
          !(s['status'] == 'refunded' && s['refund_revision'] == 0),
      'refunded_amount': total,
      'items': [
        for (final i in originals)
          {
            ...i,
            'refunded_quantity': refunded[i['id']] ?? 0,
            'returned_quantity': returned[i['id']] ?? 0,
            'restock_budget':
                (_deductions[id]?[i['product_id']] ?? 0) -
                (parentReturns[i['product_id']] ?? 0),
            'track_stock':
                catalog.products
                    .where((p) => p['id'] == i['product_id'])
                    .firstOrNull?['track_stock'] ==
                true,
            'stock_quantity':
                catalog.products
                    .where((p) => p['id'] == i['product_id'])
                    .firstOrNull?['stock_quantity'] ??
                0,
          },
      ],
    };
  }

  Map<String, dynamic> history(String id, int page) {
    _sale(id);
    final rows = _records
        .where((r) => r['transaction_id'] == id)
        .toList()
        .reversed
        .toList();
    return {
      'data': rows.skip((page - 1) * 20).take(20).map(_copy).toList(),
      'meta': {'page': page, 'page_size': 20, 'total': rows.length},
    };
  }

  Map<String, dynamic>? byRequest(String id) =>
      _requests[id] == null ? null : _copy(_requests[id]!.response);
  // Mock protocol uses a deterministic demo hash; real API uses SHA-256.
  String _hash(String id, Map<String, dynamic> b) {
    final items =
        (b['items'] as List)
            .map(
              (i) => {
                'transaction_item_id': i['transaction_item_id'],
                'quantity': i['quantity'],
                'restock_quantity': i['restock_quantity'],
              },
            )
            .toList()
          ..sort(
            (a, b) => (a['transaction_item_id'] as String).compareTo(
              b['transaction_item_id'] as String,
            ),
          );
    final text = jsonEncode([
      id,
      b['expected_refund_revision'],
      b['mode'],
      b['method'],
      (b['reason'] as String).trim(),
      items,
    ]);
    var h = BigInt.parse('1469598103934665603');
    final mask = (BigInt.one << 64) - BigInt.one;
    for (final byte in utf8.encode(text)) {
      h = ((h ^ BigInt.from(byte)) * BigInt.from(1099511628211)) & mask;
    }
    return List.filled(4, h.toRadixString(16).padLeft(16, '0')).join();
  }

  List<int> _allocate(int total, List<int> weights, List<String> keys) {
    final sum = weights.fold<BigInt>(BigInt.zero, (s, w) => s + BigInt.from(w));
    final out = <int>[];
    final remainders = <BigInt>[];
    for (final w in weights) {
      final n = BigInt.from(total) * BigInt.from(w);
      out.add((n ~/ sum).toInt());
      remainders.add(n % sum);
    }
    final ids = List<int>.generate(weights.length, (i) => i)
      ..sort((a, b) {
        final c = remainders[b].compareTo(remainders[a]);
        return c == 0 ? keys[a].compareTo(keys[b]) : c;
      });
    final remaining = total - out.fold<int>(0, (a, b) => a + b);
    for (var i = 0; i < remaining; i++) {
      out[ids[i]]++;
    }
    return out;
  }

  int _component(int b, int k, int q, int n) =>
      (BigInt.from(b) * BigInt.from(k + q) ~/ BigInt.from(n) -
              BigInt.from(b) * BigInt.from(k) ~/ BigInt.from(n))
          .toInt();
  Map<String, dynamic> preview(String id, Map<String, dynamic> b) {
    final s = detail(id);
    if (s['refunds_supported'] != true) {
      _error(
        'TRANSAKSI_REFUND_TIDAK_DIDUKUNG',
        'Status transaksi lama tidak mendukung refund.',
        422,
      );
    }
    if (s['refund_revision'] != b['expected_refund_revision']) {
      _error('REFUND_REVISI_BERUBAH', 'Muat ulang transaksi.');
    }
    final items = (s['items'] as List).cast<Map<String, dynamic>>();
    final selected = b['items'] as List?;
    if (!['full', 'items'].contains(b['mode']) ||
        ![
          'cash',
          'wallet',
          'debit_card',
          'qris',
          'transfer',
        ].contains(b['method']) ||
        (b['reason'] as String? ?? '').trim().isEmpty ||
        (b['reason'] as String).runes.length > 500 ||
        selected == null ||
        selected.isEmpty ||
        selected.length > 100) {
      _error('VALIDASI_GAGAL', 'Periksa alasan dan pilihan item.', 422);
    }
    final gross = items.map((i) => i['line_total'] as int).toList();
    var weights = gross;
    final keys = items.map((i) => i['id'] as String).toList();
    if (weights.every((w) => w == 0)) {
      weights = items.map((i) => i['quantity'] as int).toList();
    }
    final discounts = _allocate(s['discount_amount'] as int, weights, keys);
    final net = List<int>.generate(
      items.length,
      (i) => gross[i] - discounts[i],
    );
    final taxes = _allocate(
      s['tax_amount'] as int,
      net.every((w) => w == 0) ? weights : net,
      keys,
    );
    final seen = <String>{};
    final ret = <String, int>{};
    final allocations = <Map<String, dynamic>>[];
    var selectedCount = 0, remaining = 0, totalNet = 0, totalTax = 0;
    for (final i in items) {
      remaining += (i['quantity'] as int) - (i['refunded_quantity'] as int);
    }
    if (remaining == 0) {
      _error('JUMLAH_REFUND_TIDAK_TERSEDIA', 'Semua item sudah direfund.');
    }
    for (final line in selected) {
      final index = items.indexWhere(
        (i) => i['id'] == line['transaction_item_id'],
      );
      final q = line['quantity'], r = line['restock_quantity'];
      if (index < 0 ||
          !seen.add(line['transaction_item_id'] as String) ||
          q is! int ||
          q < 1 ||
          q > 1000 ||
          r is! int ||
          r < 0 ||
          r > q) {
        _error('VALIDASI_GAGAL', 'Pilihan item tidak valid.', 422);
      }
      final original = items[index];
      final k = original['refunded_quantity'] as int;
      final count = original['quantity'] as int;
      if (q > count - k) {
        _error('JUMLAH_REFUND_TIDAK_TERSEDIA', 'Jumlah refund tidak tersedia.');
      }
      final product = original['product_id'] as String;
      ret[product] = (ret[product] ?? 0) + r;
      if (r > 0 &&
          (original['track_stock'] != true ||
              ret[product]! > (original['restock_budget'] as int) ||
              (original['stock_quantity'] as int) > 1000000000 - ret[product]!)) {
        _error(
          'STOK_PENGEMBALIAN_TIDAK_VALID',
          'Stok pengembalian tidak tersedia.',
        );
      }
      final n = _component(net[index], k, q, count),
          t = _component(taxes[index], k, q, count);
      allocations.add({
        'transaction_item_id': original['id'],
        'quantity': q,
        'restock_quantity': r,
        'net_amount': n,
        'tax_amount': t,
        'total_amount': n + t,
      });
      totalNet += n;
      totalTax += t;
      selectedCount += q;
    }
    if (b['mode'] == 'full' && selectedCount != remaining) {
      _error('JUMLAH_REFUND_TIDAK_TERSEDIA', 'Pilih seluruh sisa item.');
    }
    return {
      'transaction_id': id,
      'refund_revision': s['refund_revision'],
      'preview_hash': _hash(id, b),
      'net_amount': totalNet,
      'tax_amount': totalTax,
      'total_amount': totalNet + totalTax,
      'result_status': selectedCount == remaining
          ? 'refunded'
          : 'partially_refunded',
      'items': allocations,
    };
  }

  Map<String, dynamic> confirm(String id, Map<String, dynamic> b) {
    final req = b['request_id'] as String;
    final hash = '${_hash(id, b)}:${b['preview_hash']}';
    final old = _requests[req];
    if (old != null) {
      if (old.hash != hash) _error('REQUEST_ID_DIGUNAKAN', 'ID sudah dipakai.');
      return _copy(old.response);
    }
    final p = preview(id, b);
    if (p['preview_hash'] != b['preview_hash']) {
      _error('REFUND_REVISI_BERUBAH', 'Pratinjau berubah.');
    }
    if (!hasCash()) {
      _error('SESI_KAS_BELUM_AKTIF', 'Buka sesi kas sebelum refund.');
    }
    final sale = _sale(id);
    final record = <String, dynamic>{
      'id': 'mock-refund-${_records.length + 1}',
      'refund_number': 'REF-DEMO-${_records.length + 1}',
      'transaction_id': id,
      'request_id': req,
      'actor_id': 'mock-user',
      'actor_name': 'Demo Cashier',
      'cash_session_id': currentSessionId?.call() ?? 'mock-cash',
      'created_at': DateTime.now().toUtc().toIso8601String(),
      'reason': (b['reason'] as String).trim(),
      'method': b['method'],
      'mode': b['mode'],
      'net_amount': p['net_amount'],
      'tax_amount': p['tax_amount'],
      'total_amount': p['total_amount'],
      'items': p['items'],
    };
    final returns = <String, int>{};
    for (final l in p['items'] as List) {
      final i = (sale['items'] as List).firstWhere(
        (i) => i['id'] == l['transaction_item_id'],
      );
      returns[i['product_id'] as String] =
          (returns[i['product_id']] ?? 0) + (l['restock_quantity'] as int);
    }
    catalog.applyRefundReturn(
      returns,
      id,
      record['id'] as String,
      record['reason'] as String,
    );
    _records.add(_copy(record));
    _requests[req] = (hash: hash, response: _copy(record));
    sale['refund_revision'] = (sale['refund_revision'] as int) + 1;
    sale['status'] = p['result_status'];
    sale['refunded_amount'] =
        (sale['refunded_amount'] as int) + (p['total_amount'] as int);
    sale['net_after_refund'] =
        (sale['total_amount'] as int) - (sale['refunded_amount'] as int);
    return _copy(record);
  }
}
