import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:mobile_dikasa/features/new_order/widgets/sales_browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/features/new_order/widgets/save_order_dialog.dart';
import 'saved_order_test.dart' show TestAuth, TestPos, TestProducts, tea;

void main() {
  setUpAll(() async {
    final font = FontLoader('Poppins')
      ..addFont(rootBundle.load('assets/fonts/Poppins-Regular.ttf'));
    await font.load();
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });
  testWidgets('save dialog confirms before clearing cart', (tester) async {
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    final c = ApiClient();
    final vm = NewOrderViewModel(
      productRepository: TestProducts(c),
      authRepository: TestAuth(c),
      posService: TestPos(c),
    );
    await vm.loadProducts();
    await vm.loadPos();
    vm.selectOrderType(vm.orderTypes.single);
    vm.addProduct(tea);
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (ctx) => Scaffold(
            body: TextButton(
              onPressed: () => SaveOrderDialog.show(ctx, vm),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(vm.totalQuantity, 1);
    await tester.enterText(find.byType(TextField), 'Table A');
    await tester.tap(find.text('Simpan Order'));
    await tester.pumpAndSettle();
    expect(vm.orderItems, isEmpty);
    expect(find.byType(AlertDialog), findsNothing);
  });
  testWidgets('saved tab opens a draft without replacing an occupied cart', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    final c = ApiClient();
    final pos = TestPos(c);
    final vm = NewOrderViewModel(
      productRepository: TestProducts(c),
      authRepository: TestAuth(c),
      posService: pos,
    );
    await vm.loadProducts();
    await vm.loadPos();
    vm.selectOrderType(vm.orderTypes.single);
    vm.addProduct(tea);
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (ctx) => Scaffold(
            body: TextButton(
              onPressed: () => SalesBrowser.show(ctx, vm),
              child: const Text('Browse'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Browse'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tersimpan'));
    await tester.pumpAndSettle();
    expect(find.text('Table A'), findsOneWidget);
    final listed = pos.listCalls;
    await tester.tap(find.byTooltip('Muat ulang'));
    await tester.pumpAndSettle();
    expect(pos.listCalls, greaterThan(listed));
    await tester.tap(find.text('Buka'));
    await tester.pumpAndSettle();
    expect(vm.totalQuantity, 1);
    expect(find.textContaining('Simpan atau hapus keranjang'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('capture saved browser and changed-price review', (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    final c = ApiClient();
    final pos = TestPos(c);
    pos.draft['items'][0]['unit_price'] = 80;
    final vm = NewOrderViewModel(
      productRepository: TestProducts(c),
      authRepository: TestAuth(c),
      posService: pos,
    );
    await vm.loadProducts();
    await vm.loadPos();
    final key = GlobalKey();
    await tester.pumpWidget(
      RepaintBoundary(
        key: key,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Poppins'),
          home: Builder(
            builder: (ctx) => Scaffold(
              body: TextButton(
                onPressed: () => SalesBrowser.show(ctx, vm),
                child: const Text('Browse'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Browse'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tersimpan'));
    await tester.pumpAndSettle();
    Future<void> capture(String name) async {
      await tester.runAsync(() async {
        final render =
            key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        final img = await render.toImage();
        final data = await img.toByteData(format: ui.ImageByteFormat.png);
        await Directory('build/saved-order-qa').create(recursive: true);
        await File(
          'build/saved-order-qa/$name.png',
        ).writeAsBytes(data!.buffer.asUint8List());
        img.dispose();
      });
    }

    await capture('saved-orders');
    await tester.tap(find.text('Buka'));
    await tester.pumpAndSettle();
    expect(find.text('Periksa perubahan pesanan'), findsOneWidget);
    await capture('saved-review');
    await tester.tap(find.text('Batal'));
    await tester.pumpAndSettle();
    expect(vm.orderItems, isEmpty);
    expect(tester.takeException(), isNull);
  }, skip: !const bool.fromEnvironment('CAPTURE_SAVED'));
}
