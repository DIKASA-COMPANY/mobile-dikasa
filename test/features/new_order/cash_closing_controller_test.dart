import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/models/cash_reconciliation.dart';
import 'package:mobile_dikasa/data/services/cash_reconciliation_service.dart';
import 'package:mobile_dikasa/features/new_order/cash_closing_controller.dart';

Map<String, dynamic> summaryJson() => {
  'session_id': 'session',
  'opening_user_id': 'actor',
  'opening_user_name': 'Cashier',
  'opened_at': '2026-10-24',
  'opening_cash': 100000,
  'cash_sales': 80000,
  'cash_refunds': 10000,
  'expected_cash': 170000,
  'sale_count': 1,
  'refund_count': 1,
  'methods': [
    {
      'method': 'cash',
      'sale_count': 1,
      'sales_amount': 80000,
      'refund_count': 1,
      'refunds_amount': 10000,
    },
  ],
};
Map<String, dynamic> cashJson() => {
  'id': 'session',
  'user_id': 'actor',
  'status': 'open',
  'opening_cash': 100000,
  'opening_user_name': 'Cashier',
  'opened_at': '2026-10-24T08:00:00+07:00',
  'can_close': true,
  'reconciliation_supported': true,
  'summary': summaryJson(),
  'closing': null,
};

class FakeClosing extends CashReconciliationService {
  FakeClosing() : super(ApiClient());
  bool uncertain = false;
  final bodies = <Map<String, dynamic>>[];
  Completer<CashClosedRecord>? delayed;
  CashSessionRecord? resolved;
  @override
  Future<CashSessionRecord> detail(String id) async =>
      resolved ?? CashSessionRecord.fromJson(cashJson());
  @override
  Future<CashClosePreview> preview(String id, Map<String, dynamic> b) async =>
      CashClosePreview.fromJson({
        'summary': summaryJson(),
        'counted_cash': b['counted_cash'],
        'difference': (b['counted_cash'] as int) - 170000,
        'reason': b['reason'],
        'preview_hash': 'hash',
      });
  @override
  Future<CashClosedRecord> close(String id, Map<String, dynamic> b) async {
    bodies.add(b);
    if (delayed != null) return delayed!.future;
    if (uncertain) throw const CashCloseUncertainException();
    return closed(b);
  }

  CashClosedRecord closed(Map<String, dynamic> b) => CashClosedRecord.fromJson({
    'session_id': 'session',
    'summary': summaryJson(),
    'counted_cash': b['counted_cash'],
    'difference': (b['counted_cash'] as int) - 170000,
    'reason': b['reason'],
    'preview_hash': 'hash',
    'close_request_id': b['request_id'],
    'closed_by': 'actor',
    'closed_by_name': 'Cashier',
    'closed_at': '2026-10-24',
  });
}

void main() {
  late FakeClosing s;
  late CashClosingController c;
  var account = 'actor';
  var refresh = 0;
  setUp(() async {
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    s = FakeClosing();
    account = 'actor';
    refresh = 0;
    c = CashClosingController(
      service: s,
      accountId: () => account,
      acquire: (_) => true,
      release: (_) {},
      onCommitted: () async {
        refresh++;
      },
    );
    await c.load('session');
  });
  test(
    'edits invalidate preview and count zero is valid with reason',
    () async {
      c.setCountedCash('0');
      c.setReason('Cash paid out');
      await c.preview();
      expect(c.quote!.difference, -170000);
      c.setReason('Recounted');
      expect(c.quote, isNull);
    },
  );
  test(
    'uncertain retry retains exact command and cannot close again',
    () async {
      c.setCountedCash('170000');
      await c.preview();
      s.uncertain = true;
      expect(await c.confirm(), false);
      c.setCountedCash('1');
      s.uncertain = false;
      expect(await c.retryPending(), true);
      expect(s.bodies[0], s.bodies[1]);
      expect(refresh, 1);
      expect(await c.confirm(), false);
    },
  );
  test('open lookup does not prove failure', () async {
    c.setCountedCash('170000');
    await c.preview();
    s.uncertain = true;
    await c.confirm();
    expect(await c.resolvePending(), false);
    expect(c.uncertain, true);
  });
  test('late confirmation cannot update another account', () async {
    c.setCountedCash('170000');
    await c.preview();
    s.delayed = Completer<CashClosedRecord>();
    final pending = c.confirm();
    account = 'other';
    s.delayed!.complete(s.closed(s.bodies.single));
    expect(await pending, false);
    expect(c.result, isNull);
    expect(refresh, 0);
  });
  test('refresh failure cannot undo a confirmed closure', () async {
    final n = CashClosingController(
      service: s,
      accountId: () => account,
      acquire: (_) => true,
      release: (_) {},
      onCommitted: () async {
        throw const ApiException(
          type: ApiErrorType.network,
          message: 'Refresh failed',
        );
      },
    );
    await n.load('session');
    n.setCountedCash('170000');
    await n.preview();
    expect(await n.confirm(), true);
    expect(n.result, isNotNull);
    expect(await n.confirm(), false);
    expect(s.bodies.length, 1);
  });
}
