import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/data/models/payment_snapshot.dart';

void main() {
  test('snapshot copies submitted lines and amounts', () {
    final line = <String, dynamic>{
      'product_name': 'Tea',
      'variant_name': 'Large',
      'notes': 'less ice',
      'quantity': 2,
      'unit_price': 100,
      'line_total': 200,
    };
    final payload = <String, dynamic>{
      'subtotal': 200,
      'tax_percentage': 10.0,
      'tax_amount': 20,
      'total_amount': 220,
      'paid_amount': 300,
      'change_amount': 80,
      'rounding_amount': 0,
      'tip_amount': 0,
      'payment_method': 'cash',
      'items': [line],
    };
    final snapshot = PaymentSnapshot.fromPayload(
      payload,
      orderTypeLabel: 'Takeaway',
    );
    line['product_name'] = 'Changed';
    payload['paid_amount'] = 999;
    expect(snapshot.items.single.name, 'Tea');
    expect(snapshot.items.single.variant, 'Large');
    expect(snapshot.items.single.note, 'less ice');
    expect(snapshot.total, 220);
    expect(snapshot.paid, 300);
    expect(snapshot.change, 80);
    expect(snapshot.orderTypeLabel, 'Takeaway');
    expect(() => snapshot.items.clear(), throwsUnsupportedError);
  });
}
