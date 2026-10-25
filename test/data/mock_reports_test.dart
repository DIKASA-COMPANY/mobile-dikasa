import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/mock_reports.dart';
import 'package:mobile_dikasa/data/models/sales_report.dart';

void main() {
  test('Monday QRIS and Wednesday cash refund keep independent dates', () {
    final sales = <Map<String, dynamic>>[
      {
        'id': 's',
        'ordered_at': '2026-10-19T03:00:00Z',
        'status': 'partially_refunded',
        'refund_revision': 1,
        'payment_method': 'qris',
        'subtotal': 300,
        'discount_amount': 30,
        'tax_amount': 27,
        'total_amount': 297,
        'items': [
          {
            'id': 'i',
            'product_id': 'p',
            'product_name': 'Tea',
            'quantity': 3,
            'unit_price': 100,
            'line_total': 300,
          },
        ],
      },
    ];
    final refunds = <Map<String, dynamic>>[
      {
        'id': 'r',
        'transaction_id': 's',
        'created_at': '2026-10-21T03:00:00Z',
        'method': 'cash',
        'net_amount': 90,
        'tax_amount': 9,
        'total_amount': 99,
        'items': [
          {
            'transaction_item_id': 'i',
            'quantity': 1,
            'net_amount': 90,
            'tax_amount': 9,
            'total_amount': 99,
          },
        ],
      },
    ];
    final m = MockReports(sales, () => refunds);
    final r = ReportData.fromJson(
      m.read('summary', {'start_date': '2026-10-21', 'end_date': '2026-10-21'}),
    );
    expect(r.totals.netSales, -90);
    expect(r.totals.saleCount, 0);
    expect(r.totals.average, isNull);
    final groups = ReportData.fromJson(
      m.read('categories', {
        'start_date': '2026-10-19',
        'end_date': '2026-10-21',
      }),
    );
    expect(groups.rows.single.name, 'Kategori historis tidak tercatat');
    expect(groups.totals.netSales, 180);
    expect(
      m
          .export('summary', {
            'start_date': '2026-10-21',
            'end_date': '2026-10-21',
          })
          .take(2),
      [80, 75],
    );
  });
}
