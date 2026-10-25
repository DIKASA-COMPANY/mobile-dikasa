import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/models/sales_report.dart';
import 'package:mobile_dikasa/data/services/report_service.dart';
import 'package:mobile_dikasa/features/report/view_model.dart';

Map<String, dynamic> reportJson({String kind = 'summary', int net = 270}) => {
  'data': {
    'kind': kind,
    'totals': {
      'gross_sales': 300,
      'discount_amount': 30,
      'sales_after_discount': 270,
      'charged_sales': 297,
      'refund_net': 270 - net,
      'refund_tax': 0,
      'refund_amount': 270 - net,
      'net_sales': net,
      'sale_tax': 27,
      'net_tax': 27,
      'value_after_refunds': net + 27,
      'sale_count': 1,
      'refund_count': 0,
      'sold_quantity': 3,
      'returned_quantity': 0,
      'net_quantity': 3,
      'average_transaction': 297,
      'excluded_receipts': 0,
      'unknown_category_quantity': 0,
    },
    'daily': [
      {
        'date': '2026-10-24',
        'sale_count': 1,
        'charged_sales': 297,
        'refund_amount': 0,
        'net_sales': net,
      },
    ],
    'methods': [],
    'rows': [],
  },
  'meta': {
    'start_date': '2026-10-24',
    'end_date': '2026-10-24',
    'timezone': 'Asia/Jakarta',
    'generated_at': '2026-10-24T02:00:00Z',
    'page': 1,
    'page_size': 20,
    'total': 0,
  },
};

class FakeReportService extends ReportService {
  FakeReportService() : super(ApiClient());
  final pending = <Completer<ReportData>>[];
  bool delay = false;
  Completer<Uint8List>? delayedExport;
  @override
  Future<ReportData> read(ReportKind kind, ReportFilter f) {
    if (delay) {
      final c = Completer<ReportData>();
      pending.add(c);
      return c.future;
    }
    return Future.value(ReportData.fromJson(reportJson(kind: kind.name)));
  }

  @override
  Future<Uint8List> export(ReportKind k, ReportFilter f) async =>
      delayedExport == null
      ? Uint8List.fromList([80, 75])
      : await delayedExport!.future;
}

void main() {
  setUp(
    () => dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    ),
  );
  test('WIB defaults and latest filter wins', () async {
    final s = FakeReportService()..delay = true;
    final vm = ReportViewModel(
      service: s,
      accountId: () => 'actor',
      clock: () => DateTime.utc(2026, 10, 23, 18),
    );
    expect(vm.filter.startDate, '2026-10-24');
    final old = vm.reload();
    final newer = vm.setKind(ReportKind.products);
    s.pending[1].complete(
      ReportData.fromJson(reportJson(kind: 'products', net: 90)),
    );
    await newer;
    s.pending[0].complete(ReportData.fromJson(reportJson(net: 1)));
    await old;
    expect(vm.report!.totals.netSales, 90);
  });
  test('account switch blocks late data and export handoff', () async {
    var account = 'a';
    final s = FakeReportService()..delay = true;
    final vm = ReportViewModel(service: s, accountId: () => account);
    final pending = vm.reload();
    account = 'b';
    s.pending.single.complete(ReportData.fromJson(reportJson()));
    await pending;
    expect(vm.report, isNull);
    account = 'a';
    s.delayedExport = Completer<Uint8List>();
    var saved = 0;
    final exporting = vm.export((b, n) async {
      saved++;
      return true;
    });
    account = 'b';
    s.delayedExport!.complete(Uint8List(1));
    expect(await exporting, false);
    expect(saved, 0);
  });
}
