import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/mock_saved_orders.dart';

void main() {
  test('mock replay is immutable and completed draft cannot pay twice', () {
    final s = MockSavedOrders();
    final b = <String, dynamic>{
      'request_id': 'one',
      'label': 'A',
      'order_type_id': 'type',
      'items': [
        {
          'product_id': 'p',
          'product_name': 'Tea',
          'unit_price': 100,
          'quantity': 1,
          'notes': '',
        },
      ],
    };
    final created = s.execute('POST', null, b);
    final id = created['id'] as String;
    final changed = {
      ...b,
      'request_id': 'two',
      'expected_revision': 1,
      'label': 'B',
    };
    s.execute('PUT', id, changed);
    expect(s.execute('POST', null, b)['label'], 'A');
    expect(
      () => s.execute('POST', null, {...b, 'label': 'C'}),
      throwsA(isA<MockSavedOrderError>()),
    );
    final pay = {...b, 'saved_order_id': id, 'saved_order_revision': 2};
    s.validatePayment(pay);
    s.completePayment(pay, 'receipt');
    expect(s.get(id)['transaction_id'], 'receipt');
    expect(
      () => s.validatePayment(pay),
      throwsA(
        isA<MockSavedOrderError>().having(
          (e) => e.code,
          'code',
          'PESANAN_SUDAH_DIBAYAR',
        ),
      ),
    );
  });
}
