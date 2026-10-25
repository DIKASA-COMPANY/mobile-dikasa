import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/mock_api_interceptor.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/repositories/product_repository.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/services/product_service.dart';
import 'package:mobile_dikasa/data/services/pos_service.dart';
import 'package:mobile_dikasa/data/services/catalog_service.dart';
import 'package:mobile_dikasa/features/product/view.dart';
import 'package:mobile_dikasa/features/new_order/view.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/features/new_order/widgets/opening_cash_dialog.dart';
import 'package:provider/provider.dart';

import '../../helpers/test_env.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    final font = FontLoader('Poppins')
      ..addFont(rootBundle.load('assets/fonts/Poppins-Regular.ttf'));
    await font.load();
  });
  setUp(loadTestEnv);

  /// Ukuran layar tablet yang dipakai desain Figma.
  Future<void> useTabletScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1340, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  Future<NewOrderViewModel> pumpOrderPage(WidgetTester tester) async {
    await useTabletScreen(tester);

    final ApiClient apiClient = ApiClient();
    final AuthRepository authRepository = AuthRepository(
      authService: AuthService(apiClient),
      apiClient: apiClient,
    );

    // Dibungkus runAsync karena di dalam testWidgets timer dipalsukan,
    // sehingga jeda buatan pada MockApiInterceptor tidak akan pernah selesai.
    await tester.runAsync(
      () => authRepository.login(
        username: MockApiInterceptor.demoUsername,
        password: MockApiInterceptor.demoPassword,
      ),
    );

    final NewOrderViewModel viewModel = NewOrderViewModel(
      productRepository: ProductRepository(
        productService: ProductService(apiClient),
      ),
      authRepository: authRepository,
      posService: PosService(apiClient),
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<NewOrderViewModel>.value(value: viewModel),
          Provider<CatalogService>(create: (_) => CatalogService(apiClient)),
        ],
        child: const MaterialApp(home: NewOrderView()),
      ),
    );

    return viewModel;
  }

  /// Menuntaskan pemuatan katalog. Tidak memakai pumpAndSettle karena
  /// indikator loading beranimasi terus sehingga frame tak pernah berhenti.
  Future<void> settleCatalog(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
  }

  testWidgets('cashier can refresh the catalog without losing an unpaid cart', (
    tester,
  ) async {
    final vm = await pumpOrderPage(tester);
    await settleCatalog(tester);
    await tester.tap(find.widgetWithText(TextButton, 'Lewati'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cumi Goreng Asam Manis'));
    await tester.pump();
    await tester.tap(find.byTooltip('Buka menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Muat ulang Katalog'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    expect(vm.orderItems.single.quantity, 1);
    expect(find.textContaining('Katalog dimuat ulang'), findsOneWidget);
  });

  testWidgets('dialog Kas Awal muncul saat halaman dibuka', (
    WidgetTester tester,
  ) async {
    await pumpOrderPage(tester);
    await settleCatalog(tester);

    expect(find.byType(OpeningCashDialog), findsOneWidget);
    expect(find.text('Kas Awal'), findsOneWidget);
    expect(
      find.text('**Uang Kas yang dipegang kasir sebagai modal kembalian'),
      findsOneWidget,
    );
  });

  testWidgets('cashier menu opens management and returns to the cashier', (
    tester,
  ) async {
    await pumpOrderPage(tester);
    await settleCatalog(tester);
    await tester.tap(find.widgetWithText(TextButton, 'Lewati'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Buka menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Katalog Produk'));
    await tester.pumpAndSettle();
    expect(find.byType(CatalogView), findsOneWidget);
    expect(find.text('Tambah Produk'), findsOneWidget);
    await tester.tap(find.byTooltip('Kembali'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(CatalogView), findsNothing);
    expect(find.text('Belum ada menu yang dipilih'), findsOneWidget);
  });

  testWidgets('product management refuses navigation while order is unpaid', (
    tester,
  ) async {
    await pumpOrderPage(tester);
    await settleCatalog(tester);
    await tester.tap(find.widgetWithText(TextButton, 'Lewati'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cumi Goreng Asam Manis'));
    await tester.pump();
    await tester.tap(find.byTooltip('Buka menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Katalog Produk'));
    await tester.pumpAndSettle();
    expect(
      find.text('Selesaikan atau hapus pesanan sebelum mengubah katalog.'),
      findsOneWidget,
    );
    expect(find.byType(NewOrderView), findsOneWidget);
  });

  testWidgets('menekan Lewati menutup dialog tanpa menyimpan nominal', (
    WidgetTester tester,
  ) async {
    final NewOrderViewModel viewModel = await pumpOrderPage(tester);
    await settleCatalog(tester);

    await tester.tap(find.widgetWithText(TextButton, 'Lewati'));
    await tester.pumpAndSettle();

    expect(find.byType(OpeningCashDialog), findsNothing);
    expect(viewModel.openingCash, isNull);
    expect(viewModel.isOpeningCashResolved, isTrue);
  });

  testWidgets('katalog dan panel pesanan tampil sesuai desain', (
    WidgetTester tester,
  ) async {
    await pumpOrderPage(tester);
    await settleCatalog(tester);

    await tester.tap(find.widgetWithText(TextButton, 'Lewati'));
    await tester.pumpAndSettle();

    // Identitas outlet pada baris teratas.
    expect(find.text('Warteg Bahari'), findsOneWidget);
    expect(find.text('Kasir Jane Doe'), findsOneWidget);

    // Tab kelompok produk.
    expect(find.text('Makanan'), findsOneWidget);
    expect(find.text('Minuman'), findsOneWidget);
    expect(find.text('Tambahan'), findsOneWidget);

    // Panel kanan dalam keadaan kosong.
    expect(find.text('Belum ada menu yang dipilih'), findsOneWidget);
    expect(find.text('0 Produk'), findsOneWidget);
    expect(find.text('Rp 0,00'), findsOneWidget);
    expect(find.text('-- Pilih Jenis Order --'), findsOneWidget);
  });

  testWidgets('memilih produk memperbarui panel pesanan', (
    WidgetTester tester,
  ) async {
    await pumpOrderPage(tester);
    await settleCatalog(tester);

    await tester.tap(find.widgetWithText(TextButton, 'Lewati'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cumi Goreng Asam Manis'));
    await tester.pump();

    expect(find.text('Belum ada menu yang dipilih'), findsNothing);
    expect(find.text('1x'), findsOneWidget);
    expect(find.text('1 Produk'), findsOneWidget);
    expect(find.text('Rp 21.000,00'), findsOneWidget);
  });

  testWidgets(
    'menambah dua produk berbeda menampilkan dua baris terpisah (regresi)',
    (WidgetTester tester) async {
      await pumpOrderPage(tester);
      await settleCatalog(tester);

      await tester.tap(find.widgetWithText(TextButton, 'Lewati'));
      await tester.pumpAndSettle();

      // Satu Cumi Goreng Asam Manis, dua Cumi Goreng Mentega.
      // `.first` menargetkan kartu di katalog (kiri), bukan baris di panel
      // pesanan (kanan) yang memuat teks yang sama setelah ditambahkan.
      await tester.tap(find.text('Cumi Goreng Asam Manis').first);
      await tester.pump();
      await tester.tap(find.text('Cumi Goreng Mentega').first);
      await tester.pump();
      await tester.tap(find.text('Cumi Goreng Mentega').first);
      await tester.pump();

      // Sebelum perbaikan, daftar beku di baris pertama sehingga produk
      // kedua tidak muncul walau total tetap ikut bertambah.
      final Finder panel = find.byType(ListView);
      expect(
        find.descendant(
          of: panel,
          matching: find.text('Cumi Goreng Asam Manis'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(of: panel, matching: find.text('Cumi Goreng Mentega')),
        findsOneWidget,
      );
      expect(find.text('1x'), findsOneWidget);
      expect(find.text('2x'), findsOneWidget);

      // Total: 3 produk x Rp 21.000 = Rp 63.000.
      expect(find.text('3 Produk'), findsOneWidget);
      expect(find.text('Rp 63.000,00'), findsOneWidget);

      // Daftar pesanan memakai scrollbar, mengikuti desain Figma.
      expect(find.byType(Scrollbar), findsOneWidget);
    },
  );
}
