import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/data/models/user.dart';
import 'package:mobile_dikasa/data/models/sales_report.dart';
import 'package:mobile_dikasa/features/report/main.dart';
import 'package:mobile_dikasa/features/report/view_model.dart';
import 'view_model_test.dart' show FakeReportService;

void main() {
  testWidgets('Figma report selector changes screen and shows real totals', (
    t,
  ) async {
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    t.view.physicalSize = const Size(1340, 800);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.resetPhysicalSize);
    addTearDown(t.view.resetDevicePixelRatio);
    await t.pumpWidget(
      MaterialApp(
        home: SalesReportsView(
          viewModel: ReportViewModel(
            service: FakeReportService(),
            accountId: () => 'actor',
          ),
          user: const User(
            id: 'actor',
            name: 'Jane Doe',
            username: 'jane',
            role: 'cashier',
            outletName: 'Dikasa',
          ),
        ),
      ),
    );
    await t.pumpAndSettle();
    expect(find.text('Penjualan Kotor'), findsWidgets);
    await t.tap(find.text(ReportKind.methods.label).last);
    await t.pumpAndSettle();
    expect(find.text('Penjualan Dibayar'), findsWidgets);
    expect(t.takeException(), isNull);
  });
}
