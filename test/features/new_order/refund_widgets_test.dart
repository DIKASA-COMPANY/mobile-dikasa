import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mobile_dikasa/data/models/refund.dart';
import 'package:mobile_dikasa/data/services/refund_service.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/features/new_order/widgets/receipt_detail_dialog.dart';
import 'saved_order_test.dart' show TestAuth, TestPos, TestProducts;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/features/new_order/refund_controller.dart';
import 'package:mobile_dikasa/features/new_order/widgets/refund_dialog.dart';
import 'refund_controller_test.dart' show FakeRefundService;

class HistoryRefundService extends FakeRefundService {
  @override
  Future<RefundHistoryPage> history(String id, {int page = 1}) async =>
      RefundHistoryPage.fromJson({
        'data': [],
        'meta': {'total': 0},
      });
}

class HistoryPos extends TestPos {
  HistoryPos(super.c);
  @override
  RefundService get refunds => HistoryRefundService();
}

void main() {
  setUpAll(() async {
    final font = FontLoader('Poppins')
      ..addFont(rootBundle.load('assets/fonts/Poppins-Regular.ttf'));
    await font.load();
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });
  testWidgets(
    'refund requires preview and explicit manual-return confirmation',
    (tester) async {
      dotenv.loadFromString(
        envString:
            'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
      );
      final c = RefundController(
        service: FakeRefundService(),
        accountId: () => 'actor',
        acquire: (_) => true,
        release: (_) {},
        onCommitted: () async {},
      );
      await c.load('sale', 'full');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: RefundDialog(controller: c)),
        ),
      );
      expect(
        find.textContaining('tidak mengirim dana otomatis'),
        findsOneWidget,
      );
      expect(c.selection['items'][0]['restock_quantity'], 0);
      await tester.enterText(
        find.byKey(const Key('refund-reason')),
        'Customer return',
      );
      await tester.tap(find.text('Pratinjau Refund'));
      await tester.pumpAndSettle();
      expect(find.textContaining('303'), findsWidgets);
      expect(find.text('Catat Uang Sudah Dikembalikan'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'reloading receipt keeps displayed return method equal to controller',
    (tester) async {
      dotenv.loadFromString(
        envString:
            'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
      );
      final c = RefundController(
        service: FakeRefundService(),
        accountId: () => 'actor',
        acquire: (_) => true,
        release: (_) {},
        onCommitted: () async {},
      );
      await c.load('sale', 'full');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: RefundDialog(controller: c)),
        ),
      );
      await tester.ensureVisible(find.byType(DropdownButtonFormField<String>));
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Transfer (manual)').last);
      await tester.pumpAndSettle();
      expect(c.method, 'transfer');
      await c.load('sale', 'full');
      await tester.pumpAndSettle();
      expect(c.method, 'cash');
      expect(find.text('Tunai'), findsOneWidget);
    },
  );

  testWidgets('capture refund screens at desktop and narrow widths', (
    tester,
  ) async {
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    Future<void> capture(String name, Widget widget, Size size) async {
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
            home: Scaffold(body: widget),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.runAsync(() async {
        final render =
            key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        final img = await render.toImage();
        final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
        await Directory('build/refund-qa').create(recursive: true);
        await File(
          'build/refund-qa/$name.png',
        ).writeAsBytes(bytes!.buffer.asUint8List());
        img.dispose();
      });
    }

    for (final mode in ['full', 'items', 'uncertain']) {
      final service = FakeRefundService();
      final c = RefundController(
        service: service,
        accountId: () => 'actor',
        acquire: (_) => true,
        release: (_) {},
        onCommitted: () async {},
      );
      await c.load('sale', mode == 'full' ? 'full' : 'items');
      if (mode != 'full') c.setQuantity('item', 1);
      c.setReason('Customer return');
      await c.preview();
      if (mode == 'uncertain') {
        service.uncertain = true;
        await c.confirm();
      }
      await capture(
        'refund-$mode',
        RefundDialog(controller: c),
        mode == 'items' ? const Size(430, 900) : const Size(1400, 1000),
      );
      c.dispose();
    }
    final client = ApiClient();
    final vm = NewOrderViewModel(
      productRepository: TestProducts(client),
      authRepository: TestAuth(client),
      posService: HistoryPos(client),
    );
    await vm.loadProducts();
    await capture(
      'receipt-detail',
      ReceiptDetailDialog(viewModel: vm, transactionId: 'sale'),
      const Size(1400, 1000),
    );
  }, skip: !const bool.fromEnvironment('CAPTURE_REFUNDS'));
}
