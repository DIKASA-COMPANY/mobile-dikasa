import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/repositories/product_repository.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/services/product_service.dart';
import 'package:mobile_dikasa/data/services/pos_service.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/features/cash_movement/view.dart';

void main() {
  testWidgets('cash drawer shows real opening and records an outflow', (
    t,
  ) async {
    dotenv.loadFromString(
      envString: 'API_BASE_URL=http://localhost/dikasa/v1\nUSE_MOCK_API=true',
    );
    final c = ApiClient();
    final a = AuthRepository(authService: AuthService(c), apiClient: c);
    final pos = PosService(c);
    await t.runAsync(() => a.login(username: 'admin', password: 'dikasa123'));
    final cash = await t.runAsync(() => pos.openCash(100000));
    final vm = NewOrderViewModel(
      productRepository: ProductRepository(productService: ProductService(c)),
      authRepository: a,
      posService: pos,
    );
    t.view.physicalSize = const Size(1340, 800);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.resetPhysicalSize);
    addTearDown(t.view.resetDevicePixelRatio);
    await t.pumpWidget(
      MaterialApp(
        home: CashMovementView(viewModel: vm, initialSessionId: cash!.id),
      ),
    );
    await t.pumpAndSettle();
    expect(find.text('Total Kas Kasir'), findsOneWidget);
    expect(find.textContaining('Modal Awal'), findsOneWidget);
    await t.tap(find.text('Tambah'));
    await t.pumpAndSettle();
    await t.enterText(
      find.widgetWithText(TextFormField, 'Nama Transaksi'),
      'Setoran Bank',
    );
    await t.enterText(find.widgetWithText(TextFormField, 'Nominal'), '30000');
    await t.enterText(
      find.widgetWithText(TextFormField, 'Alasan / Catatan'),
      'Setor ke bank',
    );
    await t.tap(find.byType(DropdownButtonFormField<String>).last);
    await t.pumpAndSettle();
    await t.tap(find.text('Uang Keluar').last);
    await t.pumpAndSettle();
    await t.tap(find.text('Simpan'));
    await t.pumpAndSettle();
    expect(find.textContaining('Setoran Bank'), findsOneWidget);
    expect(t.takeException(), isNull);
    expect(vm.cashMovementActive, isFalse);
  });
  testWidgets('logout hides an open cash form immediately', (t) async {
    dotenv.loadFromString(
      envString: 'API_BASE_URL=http://localhost/dikasa/v1\nUSE_MOCK_API=true',
    );
    final c = ApiClient();
    final a = AuthRepository(authService: AuthService(c), apiClient: c);
    final pos = PosService(c);
    await t.runAsync(() => a.login(username: 'admin', password: 'dikasa123'));
    final cash = await t.runAsync(() => pos.openCash(100000));
    final vm = NewOrderViewModel(
      productRepository: ProductRepository(productService: ProductService(c)),
      authRepository: a,
      posService: pos,
    );
    t.view.physicalSize = const Size(1340, 800);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.resetPhysicalSize);
    addTearDown(t.view.resetDevicePixelRatio);
    await t.pumpWidget(
      MaterialApp(
        home: CashMovementView(viewModel: vm, initialSessionId: cash!.id),
      ),
    );
    await t.pumpAndSettle();
    await t.tap(find.text('Tambah'));
    await t.pumpAndSettle();
    await t.enterText(
      find.widgetWithText(TextFormField, 'Nama Transaksi'),
      'Private cash note',
    );
    a.logout();
    await t.pumpAndSettle();
    expect(find.text('Private cash note'), findsNothing);
  });
}
