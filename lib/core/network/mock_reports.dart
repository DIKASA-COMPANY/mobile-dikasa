import 'dart:typed_data';
import 'package:mobile_dikasa/data/models/sales_report.dart';
import 'mock_workbook.dart';

class MockReportError implements Exception {
  const MockReportError(
    this.message, {
    this.code = 'FILTER_LAPORAN_TIDAK_VALID',
    this.status = 422,
  });
  final String message, code;
  final int status;
}

/// Reports read the existing mock ledgers; no separate inventory or financial copy.
class MockReports {
  MockReports(this.sales, this.refunds);
  final List<Map<String, dynamic>> sales;
  final List<Map<String, dynamic>> Function() refunds;
  static const fields = [
    'gross_sales',
    'discount_amount',
    'sales_after_discount',
    'charged_sales',
    'refund_net',
    'refund_tax',
    'refund_amount',
    'net_sales',
    'sale_tax',
    'net_tax',
    'value_after_refunds',
    'sale_count',
    'refund_count',
    'sold_quantity',
    'returned_quantity',
    'net_quantity',
    'excluded_receipts',
    'unknown_category_quantity',
  ];
  Map<String, dynamic> _totals() => {
    for (final k in fields) k: 0,
    'average_transaction': null,
  };
  int _n(dynamic v) => reportNumber(v);
  void _add(Map<String, dynamic> m, String k, int v) {
    final result = BigInt.from(_n(m[k])) + BigInt.from(v);
    if (result.abs() > BigInt.parse('9007199254740991')) {
      throw const MockReportError(
        'Nilai laporan melebihi batas.',
        code: 'DATA_LAPORAN_TIDAK_DIDUKUNG',
      );
    }
    m[k] = result.toInt();
  }

  void _finish(Map<String, dynamic> t) {
    t['net_sales'] = _n(t['sales_after_discount']) - _n(t['refund_net']);
    t['net_tax'] = _n(t['sale_tax']) - _n(t['refund_tax']);
    t['value_after_refunds'] = _n(t['charged_sales']) - _n(t['refund_amount']);
    t['net_quantity'] = _n(t['sold_quantity']) - _n(t['returned_quantity']);
    for (final k in fields) {
      _n(t[k]);
    }
    final count = _n(t['sale_count']);
    t['average_transaction'] = count == 0
        ? null
        : ((BigInt.from(_n(t['charged_sales'])) + BigInt.from(count ~/ 2)) ~/
                  BigInt.from(count))
              .toInt();
  }

  List<int> _allocate(int total, List<int> weights, List<String> keys) {
    final sum = weights.fold<BigInt>(BigInt.zero, (a, b) => a + BigInt.from(b));
    final out = <int>[], rem = <BigInt>[];
    for (final w in weights) {
      final n = BigInt.from(total) * BigInt.from(w);
      out.add((n ~/ sum).toInt());
      rem.add(n % sum);
    }
    final ids = List.generate(weights.length, (i) => i)
      ..sort((a, b) {
        final c = rem[b].compareTo(rem[a]);
        return c == 0 ? keys[a].compareTo(keys[b]) : c;
      });
    final left = total - out.fold<int>(0, (a, b) => a + b);
    for (var i = 0; i < left; i++) {
      out[ids[i]]++;
    }
    return out;
  }

  Map<String, dynamic> read(
    String kind,
    Map<String, dynamic> query, {
    bool allRows = false,
  }) {
    if (!['summary', 'methods', 'products', 'categories'].contains(kind)) {
      throw const MockReportError('Jenis laporan tidak valid.');
    }
    final now = DateTime.now().toUtc();
    final today = reportDate(reportWib(now));
    final start = query['start_date'] as String? ?? today,
        end = query['end_date'] as String? ?? today;
    DateTime localA, localB;
    try {
      localA = DateTime.parse('${start}T00:00:00Z');
      localB = DateTime.parse('${end}T00:00:00Z');
    } catch (_) {
      throw const MockReportError('Tanggal tidak valid.');
    }
    if (reportDate(localA) != start ||
        reportDate(localB) != end ||
        localB.isBefore(localA) ||
        localB.difference(localA).inDays >= 366) {
      throw const MockReportError('Rentang tanggal maksimal366 hari.');
    }
    final a = localA.subtract(const Duration(hours: 7)),
        b = localB
            .add(const Duration(days: 1))
            .subtract(const Duration(hours: 7));
    bool inside(String date) {
      final d = DateTime.parse(date).toUtc();
      return !d.isBefore(a) && d.isBefore(b);
    }

    final search = (query['query'] as String? ?? '').trim().toLowerCase(),
        sort = query['sort'] as String? ?? 'quantity_desc';
    final page = (query['page'] as num?)?.toInt() ?? 1,
        size = (query['page_size'] as num?)?.toInt() ?? 20;
    if (page < 1 ||
        size < 1 ||
        size > 100 ||
        !['quantity_desc', 'net_desc', 'name_asc'].contains(sort) ||
        search.length > 200 ||
        ((kind == 'summary' || kind == 'methods') && search.isNotEmpty)) {
      throw const MockReportError('Filter tidak valid.');
    }
    final totals = _totals();
    final daily = <String, Map<String, dynamic>>{};
    for (
      var d = localA;
      !d.isAfter(localB);
      d = d.add(const Duration(days: 1))
    ) {
      final key = reportDate(d);
      daily[key] = {
        'date': key,
        'sale_count': 0,
        'charged_sales': 0,
        'refund_amount': 0,
        'net_sales': 0,
      };
    }
    final methods = <String, Map<String, dynamic>>{},
        groups = <String, Map<String, dynamic>>{},
        lines = <String, Map<String, dynamic>>{};
    final ranks = <String, String>{};
    final groupSales = <String, Set<String>>{},
        groupRefunds = <String, Set<String>>{};
    Map<String, dynamic> method(String key) => methods.putIfAbsent(
      key,
      () => {
        'method': key,
        'sale_count': 0,
        'sales_amount': 0,
        'refund_count': 0,
        'refund_amount': 0,
        'net_amount': 0,
      },
    );
    Map<String, dynamic> group(Map<String, dynamic> l) {
      final i = l['item'] as Map;
      var key = '${i['product_id']}/${i['product_variant_id'] ?? ''}',
          name =
              '${i['product_name']}${i['variant_name'] == null ? '' : ' • ${i['variant_name']}'}';
      if (kind == 'categories') {
        key = i['category_id_snapshot'] as String? ?? 'unknown';
        name =
            i['category_name_snapshot'] as String? ??
            'Kategori historis tidak tercatat';
      }
      final g = groups.putIfAbsent(
        key,
        () => {
          ..._totals(),
          'key': key,
          'name': name,
          'category_name': i['category_name_snapshot'] ?? '',
          'category_id': i['category_id_snapshot'],
          'product_id': i['product_id'],
          'variant_id': i['product_variant_id'],
          'unit_price_min': i['unit_price'],
          'unit_price_max': i['unit_price'],
        },
      );
      if (kind == 'products' &&
          g['category_name'] != (i['category_name_snapshot'] ?? '')) {
        g['category_name'] = 'Beragam';
        g['category_id'] = null;
      }
      groupSales.putIfAbsent(key, () => {});
      groupRefunds.putIfAbsent(key, () => {});
      final rank = '${l['date']}${i['id']}';
      if (rank.compareTo(ranks[key] ?? '') >= 0) {
        g['name'] = name;
        ranks[key] = rank;
      }
      final price = _n(i['unit_price']);
      if (price < _n(g['unit_price_min'])) g['unit_price_min'] = price;
      if (price > _n(g['unit_price_max'])) g['unit_price_max'] = price;
      return g;
    }

    for (final s in sales) {
      final date = (s['paid_at'] ?? s['ordered_at']) as String;
      final inRange = inside(date);
      if (s['status'] == 'cancelled' ||
          s['status'] == 'refunded' && (s['refund_revision'] ?? 0) == 0) {
        if (inRange) _add(totals, 'excluded_receipts', 1);
        continue;
      }
      final items = (s['items'] as List).cast<Map<String, dynamic>>();
      final gross = items.map((i) => _n(i['line_total'])).toList(),
          weights = [...gross],
          keys = items.map((i) => i['id'] as String).toList();
      if (weights.every((v) => v == 0)) {
        for (var i = 0; i < items.length; i++) {
          weights[i] = _n(items[i]['quantity']);
        }
      }
      if (weights.isEmpty) continue;
      final discounts = _allocate(_n(s['discount_amount']), weights, keys),
          net = List.generate(items.length, (i) => gross[i] - discounts[i]);
      final tax = _allocate(
        _n(s['tax_amount']),
        net.every((v) => v == 0) ? weights : net,
        keys,
      );
      for (var n = 0; n < items.length; n++) {
        final i = items[n];
        lines[i['id'] as String] = {
          'item': i,
          'net': net[n],
          'tax': tax[n],
          'sale': s['id'],
          'date': date,
        };
      }
      if (!inRange) continue;
      _add(totals, 'gross_sales', _n(s['subtotal']));
      _add(totals, 'discount_amount', _n(s['discount_amount']));
      _add(
        totals,
        'sales_after_discount',
        _n(s['subtotal']) - _n(s['discount_amount']),
      );
      _add(totals, 'charged_sales', _n(s['total_amount']));
      _add(totals, 'sale_tax', _n(s['tax_amount']));
      _add(totals, 'sale_count', 1);
      final m = method(s['payment_method'] as String);
      _add(m, 'sale_count', 1);
      _add(m, 'sales_amount', _n(s['total_amount']));
      final d = daily[reportDate(reportWib(DateTime.parse(date)))]!;
      _add(d, 'sale_count', 1);
      _add(d, 'charged_sales', _n(s['total_amount']));
      _add(d, 'net_sales', _n(s['subtotal']) - _n(s['discount_amount']));
      for (final i in items) {
        final l = lines[i['id']]!;
        final g = group(l);
        final qty = _n(i['quantity']);
        for (final t in [totals, g]) {
          _add(t, 'sold_quantity', qty);
          if (i['category_id_snapshot'] == null) {
            _add(t, 'unknown_category_quantity', qty);
          }
        }
        _add(g, 'gross_sales', _n(i['line_total']));
        _add(g, 'discount_amount', _n(i['line_total']) - _n(l['net']));
        _add(g, 'sales_after_discount', _n(l['net']));
        _add(g, 'sale_tax', _n(l['tax']));
        _add(g, 'charged_sales', _n(l['net']) + _n(l['tax']));
        groupSales[g['key']]!.add(s['id'] as String);
      }
    }
    for (final r in refunds()) {
      if (!inside(r['created_at'] as String)) continue;
      _add(totals, 'refund_net', _n(r['net_amount']));
      _add(totals, 'refund_tax', _n(r['tax_amount']));
      _add(totals, 'refund_amount', _n(r['total_amount']));
      _add(totals, 'refund_count', 1);
      final m = method(r['method'] as String);
      _add(m, 'refund_count', 1);
      _add(m, 'refund_amount', _n(r['total_amount']));
      final d =
          daily[reportDate(
            reportWib(DateTime.parse(r['created_at'] as String)),
          )]!;
      _add(d, 'refund_amount', _n(r['total_amount']));
      _add(d, 'net_sales', -_n(r['net_amount']));
      for (final i in (r['items'] as List).cast<Map<String, dynamic>>()) {
        final l = lines[i['transaction_item_id']];
        if (l == null) {
          throw const MockReportError(
            'Catatan refund tidak lengkap.',
            code: 'DATA_LAPORAN_TIDAK_DIDUKUNG',
          );
        }
        final g = group(l);
        _add(totals, 'returned_quantity', _n(i['quantity']));
        _add(g, 'returned_quantity', _n(i['quantity']));
        _add(g, 'refund_net', _n(i['net_amount']));
        _add(g, 'refund_tax', _n(i['tax_amount']));
        _add(g, 'refund_amount', _n(i['total_amount']));
        groupRefunds[g['key']]!.add(r['id'] as String);
      }
    }
    for (final g in groups.values) {
      g['sale_count'] = groupSales[g['key']]!.length;
      g['refund_count'] = groupRefunds[g['key']]!.length;
      _finish(g);
    }
    var rows = groups.values
        .where(
          (g) =>
              search.isEmpty ||
              (g['name'] as String).toLowerCase().contains(search),
        )
        .toList();
    rows.sort((x, y) {
      int c;
      switch (sort) {
        case 'name_asc':
          c = (x['name'] as String).compareTo(y['name'] as String);
        case 'net_desc':
          c = _n(y['net_sales']).compareTo(_n(x['net_sales']));
        default:
          c = _n(y['net_quantity']).compareTo(_n(x['net_quantity']));
      }
      return c == 0 ? (x['key'] as String).compareTo(y['key'] as String) : c;
    });
    if (search.isNotEmpty && (kind == 'products' || kind == 'categories')) {
      final excluded = totals['excluded_receipts'];
      totals.addAll(_totals());
      totals['excluded_receipts'] = excluded;
      final ss = <String>{}, rr = <String>{};
      for (final g in rows) {
        for (final key in [
          'gross_sales',
          'discount_amount',
          'sales_after_discount',
          'charged_sales',
          'sale_tax',
          'refund_net',
          'refund_tax',
          'refund_amount',
          'sold_quantity',
          'returned_quantity',
          'unknown_category_quantity',
        ]) {
          _add(totals, key, _n(g[key]));
        }
        ss.addAll(groupSales[g['key']]!);
        rr.addAll(groupRefunds[g['key']]!);
      }
      totals['sale_count'] = ss.length;
      totals['refund_count'] = rr.length;
    }
    _finish(totals);
    for (final m in methods.values) {
      m['net_amount'] = _n(m['sales_amount']) - _n(m['refund_amount']);
    }
    final methodRows = methods.values.toList()
      ..sort(
        (a, b) => (a['method'] as String).compareTo(b['method'] as String),
      );
    final total = kind == 'summary'
        ? daily.length
        : kind == 'methods'
        ? methodRows.length
        : rows.length;
    if (!allRows) rows = rows.skip((page - 1) * size).take(size).toList();
    return {
      'data': {
        'kind': kind,
        'totals': totals,
        'daily': daily.values.toList(),
        'methods': methodRows,
        'rows': rows,
      },
      'meta': {
        'start_date': start,
        'end_date': end,
        'timezone': 'Asia/Jakarta',
        'generated_at': now.toIso8601String(),
        'page': page,
        'page_size': size,
        'total': total,
      },
    };
  }

  Uint8List export(String kind, Map<String, dynamic> query) {
    final r = read(kind, query, allRows: true),
        d = r['data'] as Map,
        m = r['meta'] as Map;
    final rows = <List<Object?>>[];
    if (kind == 'summary') {
      rows.add([
        'Tanggal WIB',
        'Transaksi',
        'Nilai Dibayar',
        'Refund',
        'Penjualan Bersih',
      ]);
      for (final p in d['daily'] as List) {
        rows.add([
          p['date'],
          p['sale_count'],
          p['charged_sales'],
          p['refund_amount'],
          p['net_sales'],
        ]);
      }
    } else if (kind == 'methods') {
      rows.add([
        'Metode',
        'Transaksi',
        'Penjualan Dibayar',
        'Refund',
        'Setelah Refund',
      ]);
      for (final p in d['methods'] as List) {
        rows.add([
          p['method'],
          p['sale_count'],
          p['sales_amount'],
          p['refund_amount'],
          p['net_amount'],
        ]);
      }
    } else {
      rows.add([
        'Nama',
        'Terjual',
        'Direfund',
        'Unit Bersih',
        'Penjualan Kotor',
        'Diskon',
        'Refund',
        'Penjualan Bersih',
        'Pajak Bersih',
      ]);
      for (final p in d['rows'] as List) {
        rows.add([
          p['name'],
          p['sold_quantity'],
          p['returned_quantity'],
          p['net_quantity'],
          p['gross_sales'],
          p['discount_amount'],
          p['refund_amount'],
          p['net_sales'],
          p['net_tax'],
        ]);
      }
    }
    rows.addAll([
      [],
      ['Laporan', kind],
      ['Mulai', m['start_date']],
      ['Sampai', m['end_date']],
      ['Zona Waktu', 'Asia/Jakarta'],
      ['Dibuat', m['generated_at']],
      ['Penjualan Bersih', d['totals']['net_sales']],
      ['Refund', d['totals']['refund_amount']],
      [
        'Aturan',
        'Penjualan menurut tanggal bayar; refund menurut tanggal pengembalian. Nilai bersih tanpa pajak.',
      ],
    ]);
    return mockLiteralWorkbook(rows);
  }
}
