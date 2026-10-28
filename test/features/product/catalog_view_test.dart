import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';
import 'package:mobile_dikasa/data/services/catalog_service.dart';
import 'package:mobile_dikasa/features/product/view.dart';
import 'package:mobile_dikasa/features/product/view_model.dart';
import 'package:mobile_dikasa/features/product/editor.dart';
import 'package:mobile_dikasa/features/product/stock_panel.dart';
import 'package:mobile_dikasa/data/services/catalog_files.dart';

class FakeCatalog extends CatalogService {
  FakeCatalog() : super(ApiClient());
  final category = const CatalogCategory(id: 'c1', name: 'Utama');
  int saves = 0;
  bool reject = false;
  bool uncertainStock = false;
  final stockCommands = <Map<String, dynamic>>[];
  @override
  Future<Map<String, dynamic>> stockCommand(
    String id,
    Map<String, dynamic> command, {
    bool adjust = false,
  }) async {
    stockCommands.add(command);
    if (uncertainStock) throw const CatalogWriteUncertain();
    return {'id': 'move', 'balance_after': 2};
  }

  bool uncertain = false;
  Completer<CatalogProduct>? pending;
  CatalogProduct? last;
  @override
  Future<List<Map<String, dynamic>>> types() async => [
    {'code': 'food', 'name': 'Makanan'},
    {'code': 'drink', 'name': 'Minuman'},
  ];
  @override
  Future<List<CatalogCategory>> categories(String type) async =>
      type == 'food' ? [category] : [];
  @override
  Future<List<CatalogProduct>> products({bool includeInactive = false}) async =>
      [
        CatalogProduct(
          id: 'p1',
          name: 'Nasi Goreng',
          category: category,
          productType: 'food',
          price: 21000,
        ),
        CatalogProduct(
          id: 'p2',
          name: 'Nasi Habis',
          category: category,
          productType: 'food',
          price: 15000,
          stockStatus: 'out_of_stock',
        ),
      ];
  @override
  Future<CatalogProduct> saveProduct(
    CatalogProduct product, {
    String? id,
    bool replaceVariations = false,
  }) async {
    saves++;
    last = product;
    if (uncertain) throw const CatalogWriteUncertain();
    if (reject) {
      throw const ApiException(
        type: ApiErrorType.unauthorized,
        message: 'Hanya manager.',
      );
    }
    if (pending != null) return pending!.future;
    return product;
  }
}

class CancelledPhotoPicker extends CatalogFiles {
  const CancelledPhotoPicker();
  @override
  Future<CatalogImage?> pickImage() async => null;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    final font = FontLoader('Poppins');
    font.addFont(rootBundle.load('assets/fonts/Poppins-Regular.ttf'));
    font.addFont(rootBundle.load('assets/fonts/Poppins-Medium.ttf'));
    font.addFont(rootBundle.load('assets/fonts/Poppins-SemiBold.ttf'));
    await font.load();
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });
  late FakeCatalog service;
  setUp(() {
    dotenv.loadFromString(envString: 'USE_MOCK_API=false');
    service = FakeCatalog();
  });
  Future<void> size(WidgetTester t, Size s) async {
    t.view.physicalSize = s;
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.resetPhysicalSize);
    addTearDown(t.view.resetDevicePixelRatio);
  }

  testWidgets(
    'catalog shows real counts, search and empty result at tablet width',
    (t) async {
      await size(t, const Size(1340, 800));
      await t.pumpWidget(
        MaterialApp(
          home: CatalogView(viewModel: CatalogViewModel(service: service)),
        ),
      );
      await t.pumpAndSettle();
      expect(find.text('Nasi Goreng'), findsOneWidget);
      expect(find.text('Habis'), findsOneWidget);
      await t.enterText(find.byKey(const Key('catalog-search')), 'no-match');
      await t.pumpAndSettle();
      expect(find.text('Produk tidak ditemukan.'), findsOneWidget);
      expect(t.takeException(), isNull);
    },
  );
  testWidgets('empty form validates before network writes', (t) async {
    await size(t, const Size(1340, 1000));
    await t.pumpWidget(MaterialApp(home: ProductEditor(service: service)));
    await t.pumpAndSettle();
    await t.tap(find.byKey(const Key('save-product')));
    await t.pumpAndSettle();
    expect(service.saves, 0);
    expect(find.text('Nama produk wajib diisi.'), findsOneWidget);
  });
  testWidgets(
    'edit preserves commerce values and keeps form after permission error',
    (t) async {
      await size(t, const Size(1340, 1100));
      service.reject = true;
      final product = CatalogProduct(
        id: 'p1',
        name: 'Nasi',
        category: service.category,
        productType: 'food',
        price: 20000,
        onlinePrice: 23000,
        costPrice: 9000,
        isHighlighted: true,
        sortOrder: 7,
        variations: const [
          CatalogVariant(name: 'Jumbo', price: 25000, costPrice: 12000),
        ],
      );
      await t.pumpWidget(
        MaterialApp(
          home: ProductEditor(service: service, product: product),
        ),
      );
      await t.pumpAndSettle();
      await t.tap(find.byKey(const Key('save-product')));
      await t.pumpAndSettle();
      expect(service.last!.costPrice, 9000);
      expect(service.last!.variations.single.costPrice, 12000);
      expect(service.last!.isHighlighted, isTrue);
      expect(service.last!.sortOrder, 7);
      expect(find.text('Hanya manager.'), findsOneWidget);
      expect(find.text('Nasi'), findsOneWidget);
    },
  );
  testWidgets('catalog and editor fit narrow screens', (t) async {
    await size(t, const Size(390, 844));
    await t.pumpWidget(
      MaterialApp(
        home: CatalogView(viewModel: CatalogViewModel(service: service)),
      ),
    );
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);
    await t.pumpWidget(MaterialApp(home: ProductEditor(service: service)));
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);
  });

  testWidgets('new product selects a category and submits the entered prices', (
    t,
  ) async {
    await size(t, const Size(1340, 1100));
    await t.pumpWidget(MaterialApp(home: ProductEditor(service: service)));
    await t.pumpAndSettle();
    await t.enterText(
      find.descendant(
        of: find.byKey(const Key('product-name')),
        matching: find.byType(TextFormField),
      ),
      'Menu Baru',
    );
    await t.enterText(
      find.descendant(
        of: find.byKey(const Key('product-price')),
        matching: find.byType(TextFormField),
      ),
      '12000',
    );
    await t.tap(find.byType(DropdownButtonFormField<String>).first);
    await t.pumpAndSettle();
    await t.tap(find.text('Utama').last);
    await t.pumpAndSettle();
    await t.tap(find.text('Simpan & Buat Lagi'));
    await t.pumpAndSettle();
    expect(service.saves, 1);
    expect(service.last!.name, 'Menu Baru');
    expect(service.last!.category.id, 'c1');
    expect(service.last!.price, 12000);
    expect(service.last!.onlinePrice, isNull);
  });

  testWidgets(
    'save and create again clears the form after one successful write',
    (t) async {
      await size(t, const Size(1340, 1100));
      final product = CatalogProduct(
        id: 'p1',
        name: 'Nasi',
        category: service.category,
        productType: 'food',
        price: 20000,
      );
      await t.pumpWidget(
        MaterialApp(
          home: ProductEditor(service: service, product: product),
        ),
      );
      await t.pumpAndSettle();
      await t.tap(find.text('Simpan & Buat Lagi'));
      await t.pumpAndSettle();
      expect(service.saves, 1);
      expect(find.text('Tambah Produk'), findsOneWidget);
      final nameField = t.widget<TextFormField>(
        find.descendant(
          of: find.byKey(const Key('product-name')),
          matching: find.byType(TextFormField),
        ),
      );
      expect(nameField.controller!.text, isEmpty);
      await t.tap(find.byKey(const Key('save-product')));
      await t.pumpAndSettle();
      expect(service.saves, 1);
    },
  );

  testWidgets(
    'duplicate taps cannot submit twice and uncertain saves are blocked',
    (t) async {
      await size(t, const Size(1340, 1100));
      service.pending = Completer<CatalogProduct>();
      final product = CatalogProduct(
        id: 'p1',
        name: 'Nasi',
        category: service.category,
        productType: 'food',
        price: 20000,
      );
      await t.pumpWidget(
        MaterialApp(
          home: ProductEditor(service: service, product: product),
        ),
      );
      await t.pumpAndSettle();
      await t.tap(find.byKey(const Key('save-product')));
      await t.tap(find.byKey(const Key('save-product')));
      await t.pump();
      expect(service.saves, 1);
      service.pending!.completeError(const CatalogWriteUncertain());
      await t.pumpAndSettle();
      expect(
        find.textContaining('Status penyimpanan belum pasti.'),
        findsOneWidget,
      );
      final saveButton = t.widget<ElevatedButton>(
        find.descendant(
          of: find.byKey(const Key('save-product')),
          matching: find.byType(ElevatedButton),
        ),
      );
      expect(saveButton.onPressed, isNull);
    },
  );

  testWidgets('existing optional prices cannot be silently cleared', (t) async {
    await size(t, const Size(1340, 1100));
    final product = CatalogProduct(
      id: 'p1',
      name: 'Nasi',
      category: service.category,
      productType: 'food',
      price: 20000,
      costPrice: 9000,
    );
    await t.pumpWidget(
      MaterialApp(
        home: ProductEditor(service: service, product: product),
      ),
    );
    await t.pumpAndSettle();
    await t.enterText(find.widgetWithText(TextFormField, '9000'), '');
    await t.tap(find.byKey(const Key('save-product')));
    await t.pumpAndSettle();
    expect(service.saves, 0);
    expect(
      find.textContaining('Harga tersimpan tidak dapat dikosongkan.'),
      findsOneWidget,
    );
  });

  testWidgets('catalog fits intermediate tablet widths', (t) async {
    await size(t, const Size(1100, 900));
    await t.pumpWidget(
      MaterialApp(
        home: CatalogView(viewModel: CatalogViewModel(service: service)),
      ),
    );
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);
  });

  testWidgets(
    'uncertain stock command retains the same ID and blocks dismissal until confirmed',
    (t) async {
      await size(t, const Size(700, 1000));
      service.uncertainStock = true;
      final product = CatalogProduct(
        id: 'p1',
        name: 'Nasi',
        category: service.category,
        productType: 'food',
        price: 10000,
        trackStock: true,
        stockQuantity: 3,
      );
      await t.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StockPanel(
              service: service,
              product: product,
              onChanged: () async {},
            ),
          ),
        ),
      );
      await t.pumpAndSettle();
      await t.tap(find.text('Sesuaikan Stok'));
      await t.pumpAndSettle();
      await t.enterText(find.byType(TextFormField).first, '-1');
      await t.enterText(find.byType(TextFormField).last, 'Stock correction');
      await t.tap(find.text('Simpan Stok'));
      await t.pumpAndSettle();
      expect(
        t
            .widget<TextButton>(find.widgetWithText(TextButton, 'Batal'))
            .onPressed,
        isNull,
      );
      service.uncertainStock = false;
      await t.tap(find.text('Periksa / Simpan ulang'));
      await t.pumpAndSettle();
      expect(service.stockCommands.length, 2);
      expect(
        service.stockCommands[0]['request_id'],
        service.stockCommands[1]['request_id'],
      );
    },
  );

  testWidgets('cancelling photo selection keeps the existing image on edit', (
    t,
  ) async {
    await size(t, const Size(1340, 1100));
    service.reject = true;
    final product = CatalogProduct(
      id: 'p1',
      name: 'Nasi',
      category: service.category,
      productType: 'food',
      price: 10000,
      imageUrl: 'http://127.0.0.1:1/photo.png',
    );
    await t.pumpWidget(
      MaterialApp(
        home: ProductEditor(
          service: service,
          product: product,
          files: const CancelledPhotoPicker(),
        ),
      ),
    );
    await t.pumpAndSettle();
    await t.tap(find.text('Upload Foto'));
    await t.pumpAndSettle();
    await t.tap(find.byKey(const Key('save-product')));
    await t.pumpAndSettle();
    expect(service.last!.imageUrl, product.imageUrl);
    expect(service.last!.removeImage, isFalse);
    expect(service.last!.image, isNull);
  });

  testWidgets(
    'stock panel shows shared quantity and cancels an adjustment without writing',
    (t) async {
      await size(t, const Size(700, 900));
      final product = CatalogProduct(
        id: 'p1',
        name: 'Nasi',
        category: service.category,
        productType: 'food',
        price: 10000,
        trackStock: true,
        stockQuantity: 3,
        lowStockThreshold: 2,
      );
      await t.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StockPanel(
              service: service,
              product: product,
              onChanged: () async {},
            ),
          ),
        ),
      );
      await t.pumpAndSettle();
      expect(find.text('3 unit'), findsOneWidget);
      await t.tap(find.text('Sesuaikan Stok'));
      await t.pumpAndSettle();
      expect(
        find.text('Perubahan jumlah (+/-)', findRichText: true),
        findsOneWidget,
      );
      await t.tap(find.text('Batal'));
      await t.pumpAndSettle();
      expect(t.takeException(), isNull);
    },
  );

  testWidgets(
    'capture catalog and editor for visual review',
    (t) async {
      await size(t, const Size(1340, 1000));
      for (final entry in <String, Widget>{
        'catalog': CatalogView(viewModel: CatalogViewModel(service: service)),
        'editor': ProductEditor(service: service),
      }.entries) {
        final key = GlobalKey();
        await t.pumpWidget(
          RepaintBoundary(
            key: key,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: entry.value,
            ),
          ),
        );
        await t.pumpAndSettle();
        await t.runAsync(() async {
          final boundary =
              key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
          final image = await boundary.toImage();
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          await Directory('build/catalog-qa').create(recursive: true);
          await File(
            'build/catalog-qa/${entry.key}.png',
          ).writeAsBytes(bytes!.buffer.asUint8List());
          image.dispose();
        });
      }
    },
    skip: !const bool.fromEnvironment('CAPTURE_CATALOG'),
  );
}
