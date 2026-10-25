import 'dart:async';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/data/models/refund.dart';
import 'package:mobile_dikasa/data/services/refund_service.dart';
import 'package:mobile_dikasa/features/new_order/refund_controller.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Map<String, dynamic> receiptJson() => {
  'id': 'sale',
  'transaction_number': 'TRX',
  'status': 'paid',
  'payment_method': 'cash',
  'refund_revision': 0,
  'subtotal': 300,
  'discount_amount': 0,
  'tax_amount': 3,
  'total_amount': 303,
  'refunded_amount': 0,
  'refunds_supported': true,
  'items': [
    {
      'id': 'item',
      'product_id': 'p',
      'product_name': 'Tea',
      'unit_price': 100,
      'quantity': 3,
      'line_total': 300,
      'refunded_quantity': 0,
      'returned_quantity': 0,
      'track_stock': true,
      'stock_quantity': 7,
      'restock_budget': 3,
    },
  ],
};

class FakeRefundService extends RefundService {
  FakeRefundService() : super(ApiClient());
  bool uncertain = false;
  final commands = <Map<String, dynamic>>[];
  @override
  Future<ReceiptRefundDetail> detail(String id) async =>
      ReceiptRefundDetail.fromJson(receiptJson());
  @override
  Future<RefundPreview> preview(String id, Map<String, dynamic> b) async {
    final q = (b['items'] as List).fold<int>(
      0,
      (n, i) => n + (i['quantity'] as int),
    );
    return RefundPreview.fromJson({
      'transaction_id': id,
      'refund_revision': 0,
      'preview_hash': 'hash',
      'net_amount': 100 * q,
      'tax_amount': q,
      'total_amount': 101 * q,
      'result_status': q == 3 ? 'refunded' : 'partially_refunded',
      'items': [],
    });
  }

  @override
  Future<RefundRecord> confirm(String id, Map<String, dynamic> b) async {
    commands.add(b);
    if (uncertain) throw const RefundUncertainException();
    return RefundRecord.fromJson({
      'id': 'refund',
      'transaction_id': id,
      'request_id': b['request_id'],
      'refund_number': 'REF',
      'total_amount': 101,
      'net_amount': 100,
      'tax_amount': 1,
      'reason': b['reason'],
      'method': 'cash',
      'mode': 'items',
      'actor_name': 'Cashier',
      'created_at': '2026-10-24',
      'items': [],
    });
  }
}

class DelayedRefundService extends FakeRefundService {
  Completer<ReceiptRefundDetail>? delayedDetail;
  Completer<RefundPreview>? delayedPreview;
  Completer<RefundRecord>? delayedConfirm;
  @override
  Future<ReceiptRefundDetail> detail(String id) =>
      delayedDetail?.future ?? super.detail(id);
  @override
  Future<RefundPreview> preview(String id, Map<String, dynamic> b) =>
      delayedPreview?.future ?? super.preview(id, b);
  @override
  Future<RefundRecord> confirm(String id, Map<String, dynamic> b) async {
    if (delayedConfirm != null) {
      commands.add(b);
      return delayedConfirm!.future;
    }
    return super.confirm(id, b);
  }
}

void main() {
  late FakeRefundService s;
  late RefundController c;
  var refreshed = 0;
  var account = 'actor';
  setUp(() async {
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    s = FakeRefundService();
    refreshed = 0;
    account = 'actor';
    c = RefundController(
      service: s,
      accountId: () => account,
      acquire: (_) => true,
      release: (_) {},
      onCommitted: () async {
        refreshed++;
      },
    );
    await c.load('sale', 'items');
  });
  test(
    'partial selection defaults to no stock return and edits invalidate preview',
    () async {
      c.setQuantity('item', 1);
      c.setReason('Damaged');
      await c.preview();
      expect(c.quote!.total, 101);
      expect(c.selection['items'][0]['restock_quantity'], 0);
      c.setReason('Other');
      expect(c.quote, isNull);
    },
  );
  test(
    'uncertain confirmation freezes exact command and retry succeeds once',
    () async {
      c.setQuantity('item', 1);
      c.setReason('Return');
      await c.preview();
      s.uncertain = true;
      expect(await c.confirm(), false);
      c.setQuantity('item', 2);
      s.uncertain = false;
      expect(await c.retryPending(), true);
      expect(s.commands[0], s.commands[1]);
      expect(refreshed, 1);
    },
  );
  test('full mode selects all remaining units', () async {
    await c.load('sale', 'full');
    expect(c.selection['items'][0]['quantity'], 3);
  });
  test(
    'account switch blocks old preview confirmation before sending',
    () async {
      c.setQuantity('item', 1);
      c.setReason('Return');
      await c.preview();
      account = 'other';
      expect(await c.confirm(), false);
      expect(s.commands, isEmpty);
    },
  );
  test(
    'confirmed refund remains successful when catalog refresh fails',
    () async {
      final controller = RefundController(
        service: s,
        accountId: () => account,
        acquire: (_) => true,
        release: (_) {},
        onCommitted: () async => throw ApiException(
          type: ApiErrorType.network,
          message: 'Refresh failed',
        ),
      );
      await controller.load('sale', 'full');
      controller.setReason('Return');
      await controller.preview();
      expect(await controller.confirm(), true);
      expect(controller.result, isNotNull);
      expect(await controller.confirm(), false);
      expect(s.commands.length, 1);
    },
  );
  test(
    'late detail preview and confirmation do not update another account',
    () async {
      for (final boundary in ['detail', 'preview', 'confirm']) {
        account = 'actor';
        final service = DelayedRefundService();
        var calls = 0;
        final controller = RefundController(
          service: service,
          accountId: () => account,
          acquire: (_) => true,
          release: (_) {},
          onCommitted: () async {
            calls++;
          },
        );
        if (boundary == 'detail') {
          service.delayedDetail = Completer<ReceiptRefundDetail>();
          final pending = controller.load('sale', 'full');
          account = 'other';
          service.delayedDetail!.complete(
            ReceiptRefundDetail.fromJson(receiptJson()),
          );
          await pending;
          expect(controller.detail, isNull);
        } else {
          await controller.load('sale', 'full');
          controller.setReason('Return');
          if (boundary == 'preview') {
            service.delayedPreview = Completer<RefundPreview>();
            final pending = controller.preview();
            account = 'other';
            service.delayedPreview!.complete(
              await s.preview('sale', controller.selection),
            );
            await pending;
            expect(controller.quote, isNull);
          } else {
            await controller.preview();
            service.delayedConfirm = Completer<RefundRecord>();
            final pending = controller.confirm();
            account = 'other';
            service.delayedConfirm!.complete(
              await s.confirm('sale', service.commands.single),
            );
            expect(await pending, false);
            expect(controller.result, isNull);
          }
        }
        expect(calls, 0);
        controller.dispose();
      }
    },
  );
}
