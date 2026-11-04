import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/mock_cash_sessions.dart';

void main() {
  test('session cash, replay and older-sale refund stay in their sessions', () {
    final sales = <Map<String, dynamic>>[];
    final refunds = <Map<String, dynamic>>[];
    final m = MockCashSessions(sales, () => refunds);
    final id = m.open(100000)['id'] as String;
    sales.add({
      'id': 'sale',
      'cash_session_id': id,
      'payment_method': 'cash',
      'paid_amount': 100000,
      'change_amount': 20000,
      'total_amount': 80000,
      'status': 'paid',
      'refund_revision': 0,
    });
    refunds.add({
      'id': 'refund',
      'cash_session_id': id,
      'method': 'cash',
      'total_amount': 10000,
    });
    final p = m.preview(id, {'counted_cash': 170000, 'reason': ''});
    final b = {
      'counted_cash': 170000,
      'reason': '',
      'preview_hash': p['preview_hash'],
      'request_id': 'one',
    };
    final c = m.close(id, b);
    expect(c['difference'], 0);
    expect(m.current, isNull);
    final next = m.open(0)['id'];
    refunds.add({
      'id': 'later',
      'cash_session_id': next,
      'method': 'cash',
      'total_amount': 5000,
    });
    expect(m.close(id, b), c);
    expect(m.detail(id)['closing'], c);
    expect(m.detail(next as String)['summary']['expected_cash'], -5000);
    expect(m.current!['id'], next);
  });
}
