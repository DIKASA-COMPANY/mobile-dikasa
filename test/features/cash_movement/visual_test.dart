import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/repositories/product_repository.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/services/product_service.dart';
import 'package:mobile_dikasa/data/services/pos_service.dart';
import 'package:mobile_dikasa/data/models/cash_movement.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/features/cash_movement/view.dart';
import 'package:mobile_dikasa/features/cash_movement/controller.dart';

void main() {
  setUpAll(() async {
    for (final n in ['Regular', 'Medium', 'SemiBold', 'Bold', 'Italic']) {
      final l = FontLoader('Poppins')
        ..addFont(rootBundle.load('assets/fonts/Poppins-$n.ttf'));
      await l.load();
    }
    final l = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await l.load();
  });
  testWidgets('capture desktop and narrow drawer and evidence entry', (
    t,
  ) async {
    dotenv.loadFromString(
      envString: 'API_BASE_URL=http://localhost/dikasa/v1\nUSE_MOCK_API=true',
    );
    final client = ApiClient();
    final auth = AuthRepository(
      authService: AuthService(client),
      apiClient: client,
    );
    final pos = PosService(client);
    await t.runAsync(
      () => auth.login(username: 'admin', password: 'dikasa123'),
    );
    final session = await t.runAsync(() => pos.openCash(100000));
    final id = session!.id;
    await t.runAsync(
      () => pos.cashMovements.create(
        id,
        PendingCashMovement(
          sessionId: id,
          requestId: CashMovementController.requestUUID(),
          kind: 'out',
          name: 'Setoran Bank',
          amount: 30000,
          reason: 'Setor tunai ke bank',
        ),
      ),
    );
    final vm = NewOrderViewModel(
      productRepository: ProductRepository(
        productService: ProductService(client),
      ),
      authRepository: auth,
      posService: pos,
    );
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.resetDevicePixelRatio);
    addTearDown(t.view.resetPhysicalSize);
    final key = GlobalKey();
    Future<void> save(String n) async {
      await t.pumpAndSettle();
      expect(t.takeException(), isNull);
      await t.runAsync(() async {
        final b =
            key.currentContext!.findRenderObject() as RenderRepaintBoundary;
        final i = await b.toImage();
        final bytes = await i.toByteData(format: ui.ImageByteFormat.png);
        Directory('build/cash-movements-qa').createSync(recursive: true);
        File(
          'build/cash-movements-qa/$n.png',
        ).writeAsBytesSync(bytes!.buffer.asUint8List());
        i.dispose();
      });
    }

    Future<void> mount(Size size) async {
      t.view.physicalSize = size;
      await t.pumpWidget(
        RepaintBoundary(
          key: key,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: CashMovementView(
              key: UniqueKey(),
              viewModel: vm,
              initialSessionId: id,
 onLock:(){},
            ),
          ),
        ),
      );
      await t.pumpAndSettle();
    }

    await mount(const Size(1340, 800));
    await save('desktop-list');
    await t.tap(find.text('Tambah'));
    await t.pumpAndSettle();
    await save('desktop-entry');
    await t.tap(find.text('Batal'));
    await t.pumpAndSettle();
    await t.tap(find.textContaining('Setoran Bank'));
    await t.pumpAndSettle();
    await save('desktop-detail');
    await t.tap(find.text('Kembali').last);
    await t.pumpAndSettle();
    await mount(const Size(390, 844));
    await save('narrow-list');
    await t.tap(find.text('Tambah'));
    await t.pumpAndSettle();
    await save('narrow-entry');
  }, skip: !const bool.fromEnvironment('CAPTURE_CASH_MOVEMENTS'));
}
