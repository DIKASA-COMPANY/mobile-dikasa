import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mobile_dikasa/data/models/cash_reconciliation.dart';
import 'package:mobile_dikasa/data/services/cash_reconciliation_service.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/features/new_order/widgets/cash_sessions_dialog.dart';
import 'saved_order_test.dart' show TestPos, TestAuth, TestProducts;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/features/new_order/cash_closing_controller.dart';
import 'package:mobile_dikasa/features/new_order/widgets/cash_closing_dialog.dart';
import 'cash_closing_controller_test.dart' show FakeClosing, cashJson;

class CashHistoryService extends FakeClosing {
  CashHistoryService({this.closedMode = false});
  final bool closedMode;
  Map<String, dynamic> fixture() {
    final j = cashJson();
    if (closedMode) {
      j['status'] = 'closed';
      j['can_close'] = false;
      j['closing'] = closed({
        'counted_cash': 169000,
        'reason': 'Cash counted twice',
        'request_id': 'closed-qa',
      }).json;
    }
    return j;
  }

  @override
  Future<CashSessionPage> sessions({int page = 1}) async =>
      CashSessionPage.fromJson({
        'data': [fixture()],
        'meta': {'total': 1},
      });
  @override
  Future<CashSessionRecord> detail(String id) async =>
      CashSessionRecord.fromJson(fixture());
}

class CashHistoryPos extends TestPos {
  CashHistoryPos(super.c, {this.closedMode = false});
  final bool closedMode;
  @override
  CashReconciliationService get cashReconciliation =>
      CashHistoryService(closedMode: closedMode);
}

void main() {
  setUpAll(() async {
    final fonts = FontLoader('Poppins')
      ..addFont(rootBundle.load('assets/fonts/Poppins-Regular.ttf'));
    await fonts.load();
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });
  testWidgets('physical count previews a discrepancy before close', (t) async {
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    final c = CashClosingController(
      service: FakeClosing(),
      accountId: () => 'actor',
      acquire: (_) => true,
      release: (_) {},
      onCommitted: () async {},
    );
    await c.load('session');
    await t.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CashClosingDialog(controller: c)),
      ),
    );
    expect(find.textContaining('170'), findsWidgets);
    await t.enterText(find.byKey(const Key('cash-count')), '169000');
    await t.enterText(find.byKey(const Key('cash-reason')), 'Counted twice');
    await t.ensureVisible(find.text('Pratinjau Penutupan'));
    await t.tap(find.text('Pratinjau Penutupan'));
    await t.pumpAndSettle();
    expect(find.textContaining('Kurang'), findsWidgets);
    expect(find.text('Tutup Sesi Kas'), findsOneWidget);
    expect(t.takeException(), isNull);
  });
  testWidgets('capture cash closing and session history', (tester) async {
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    Future<void> capture(String name, Widget child, Size size) async {
      tester.view.physicalSize = size;
      final key = GlobalKey();
      await tester.pumpWidget(
        RepaintBoundary(
          key: key,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Poppins',
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xff097bc2),
              ),
            ),
            home: Scaffold(body: child),
          ),
        ),
      );
      await tester.pumpAndSettle();
      if (name == 'closed-summary') {
        await tester.tap(find.byType(ListTile).first);
        await tester.pump(const Duration(milliseconds: 350));
        await tester.pump(const Duration(milliseconds: 350));
      }
      expect(tester.takeException(), isNull);
      await tester.runAsync(() async {
        final render =
            key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        final img = await render.toImage();
        final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
        await Directory('build/cash-qa').create(recursive: true);
        await File(
          'build/cash-qa/$name.png',
        ).writeAsBytes(bytes!.buffer.asUint8List());
        img.dispose();
      });
    }

    for (final mode in ['matched', 'shortage', 'uncertain']) {
      final s = FakeClosing();
      final c = CashClosingController(
        service: s,
        accountId: () => 'actor',
        acquire: (_) => true,
        release: (_) {},
        onCommitted: () async {},
      );
      await c.load('session');
      c.setCountedCash(mode == 'matched' ? '170000' : '169000');
      if (mode != 'matched') c.setReason('Cash counted twice');
      await c.preview();
      if (mode == 'uncertain') {
        s.uncertain = true;
        await c.confirm();
      }
      await capture(
        'close-$mode',
        CashClosingDialog(controller: c),
        mode == 'shortage' ? const Size(430, 940) : const Size(1400, 1050),
      );
    }
    final api = ApiClient();
    final vm = NewOrderViewModel(
      productRepository: TestProducts(api),
      authRepository: TestAuth(api),
      posService: CashHistoryPos(api),
    );
    await capture(
      'session-history',
      CashSessionsDialog(viewModel: vm),
      const Size(1400, 900),
    );
    final closedVm = NewOrderViewModel(
      productRepository: TestProducts(api),
      authRepository: TestAuth(api),
      posService: CashHistoryPos(api, closedMode: true),
    );
    await capture(
      'closed-summary',
      CashSessionsDialog(viewModel: closedVm),
      const Size(1400, 1050),
    );
  }, skip: !const bool.fromEnvironment('CAPTURE_CASH'));
}
