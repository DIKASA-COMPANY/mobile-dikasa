import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/mock_catalog.dart';
import 'package:mobile_dikasa/core/network/mock_refunds.dart';

void main() {
  test(
    'partial then full refund conserves original total and restocks once',
    () {
      final catalog = MockCatalog([
        {
          'id': 'p',
          'name': 'Tea',
          'price': 100,
          'group': 'minuman',
          'category': 'Drink',
          'is_highlighted': false,
        },
      ]);
      catalog.products.first.addAll({'track_stock': true, 'stock_quantity': 7});
      final orders = <Map<String, dynamic>>[
        {
          'id': 's',
          'receipt_number': 'TRX',
          'payment_method': 'cash',
          'subtotal': 300,
          'discount_amount': 0,
          'tax_amount': 1,
          'total_amount': 301,
          'status': 'paid',
          'items': [
            {
              'product_id': 'p',
              'product_name': 'Tea',
              'unit_price': 100,
              'quantity': 3,
              'line_total': 300,
            },
          ],
        },
      ];
      final m = MockRefunds(orders, catalog, () => true);
      m.registerSale(orders.first);
      final item = m.detail('s')['items'][0]['id'];
      final b = <String, dynamic>{
        'mode': 'items',
        'method': 'cash',
        'reason': 'Return',
        'expected_refund_revision': 0,
        'items': [
          {'transaction_item_id': item, 'quantity': 1, 'restock_quantity': 1},
        ],
      };
      final quote = m.preview('s', b);
      final command = {
        ...b,
        'request_id': 'request',
        'preview_hash': quote['preview_hash'],
      };
      final first = m.confirm('s', command);
      expect(catalog.products.first['stock_quantity'], 8);
      expect(m.confirm('s', command)['id'], first['id']);
      expect(catalog.products.first['stock_quantity'], 8);
      final full = {
        ...b,
        'mode': 'full',
        'expected_refund_revision': 1,
        'items': [
          {'transaction_item_id': item, 'quantity': 2, 'restock_quantity': 0},
        ],
      };
      final last = m.confirm('s', {
        ...full,
        'request_id': 'next',
        'preview_hash': m.preview('s', full)['preview_hash'],
      });
      expect(first['total_amount'] + last['total_amount'], 301);
      expect(orders.first['status'], 'refunded');
    },
  );
}
