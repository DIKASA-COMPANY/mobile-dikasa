import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/core/network/mock_reports.dart';
import 'package:mobile_dikasa/data/models/sales_report.dart';
import 'package:mobile_dikasa/data/models/user.dart';
import 'package:mobile_dikasa/data/services/report_service.dart';
import 'package:mobile_dikasa/features/report/main.dart';
import 'package:mobile_dikasa/features/report/view_model.dart';

class VisualReports extends ReportService {
  VisualReports({this.empty = false, this.fail = false}) : super(ApiClient());
  final bool empty, fail;
  @override
  Future<ReportData> read(ReportKind k, ReportFilter f) async {
    if (fail) {
      throw const ApiException(
        type: ApiErrorType.network,
        message: 'Koneksi laporan terputus. Coba lagi.',
      );
    }
    final sales = <Map<String, dynamic>>[], refunds = <Map<String, dynamic>>[];
    if (!empty) {
      for (var day = 1; day <= 30; day++) {
        final date = '2026-10-${day.toString().padLeft(2, '0')}T03:00:00Z';
        final product = day % 3;
        final price = [21000, 32000, 15000][product], q = day % 5 + 1;
        final name = [
          'Nasi Goreng',
          'Cumi Goreng • Asam Manis',
          'Ice Choco Hazelnut',
        ][product];
        sales.add({
          'id': 's$day',
          'ordered_at': date,
          'status': 'paid',
          'refund_revision': 0,
          'payment_method': day % 2 == 0 ? 'cash' : 'qris',
          'subtotal': price * q,
          'discount_amount': 0,
          'tax_amount': 0,
          'total_amount': price * q,
          'items': [
            {
              'id': 'i$day',
              'product_id': 'p$product',
              'product_name': name,
              'unit_price': price,
              'quantity': q,
              'line_total': price * q,
              if (day > 1)
                'category_id_snapshot': product == 2 ? 'drink' : 'food',
              if (day > 1)
                'category_name_snapshot': product == 2 ? 'Minuman' : 'Makanan',
            },
          ],
        });
        if (day % 5 == 0) {
          refunds.add({
            'id': 'r$day',
            'transaction_id': 's$day',
            'created_at': date,
            'method': 'cash',
            'net_amount': price,
            'tax_amount': 0,
            'total_amount': price,
            'items': [
              {
                'transaction_item_id': 'i$day',
                'quantity': 1,
                'net_amount': price,
                'tax_amount': 0,
                'total_amount': price,
              },
            ],
          });
        }
      }
    }
    return ReportData.fromJson(
      MockReports(sales, () => refunds).read(k.name, f.parameters(k)),
    );
  }
}

void main() {
  setUpAll(() async {
    for (final name in ['Regular', 'Medium', 'SemiBold', 'Bold', 'Italic']) {
      final loader = FontLoader('Poppins')
        ..addFont(rootBundle.load('assets/fonts/Poppins-$name.ttf'));
      await loader.load();
    }
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });
  testWidgets(
    'capture four Figma reports and responsive states',
    (t) async {
      dotenv.loadFromString(
        envString:
            'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
      );
      t.view.devicePixelRatio = 1;
      addTearDown(t.view.resetDevicePixelRatio);
      addTearDown(t.view.resetPhysicalSize);
      Future<void> capture(
        String name,
        ReportKind kind,
        Size size, {
        bool empty = false,
        bool fail = false,
      }) async {
        t.view.physicalSize = size;
        final key = GlobalKey();
        await t.pumpWidget(
          RepaintBoundary(
            key: key,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Poppins',
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xff077cd3),
                ),
              ),
              home: SalesReportsView(
                viewModel: ReportViewModel(
                  service: VisualReports(empty: empty, fail: fail),
                  accountId: () => 'actor',
                ),
                user: const User(
                  id: 'actor',
                  name: 'Jane Doe',
                  username: 'jane',
                  role: 'cashier',
                  outletName: 'Warteg Bahari',
                ),
                initialKind: kind,
                initialFilter: const ReportFilter(
                  startDate: '2026-10-01',
                  endDate: '2026-10-30',
                ),
                onLock: () {},
              ),
            ),
          ),
        );
        await t.pumpAndSettle();
        expect(t.takeException(), isNull);
        await t.runAsync(() async {
          final boundary =
              key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
          final img = await boundary.toImage();
          final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
          await Directory('build/reports-qa').create(recursive: true);
          await File(
            'build/reports-qa/$name.png',
          ).writeAsBytes(bytes!.buffer.asUint8List());
          img.dispose();
        });
      }

      for (final k in ReportKind.values) {
        await capture(k.name, k, const Size(1340, 800));
      }
      await capture('narrow', ReportKind.products, const Size(430, 940));
      await capture(
        'empty',
        ReportKind.summary,
        const Size(1340, 800),
        empty: true,
      );
      await capture(
        'error',
        ReportKind.summary,
        const Size(1340, 800),
        fail: true,
      );
    },
    skip: !const bool.fromEnvironment('CAPTURE_REPORTS'),
  );
}
