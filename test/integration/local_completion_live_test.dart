import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/repositories/product_repository.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/services/catalog_service.dart';
import 'package:mobile_dikasa/data/services/product_service.dart';
import 'package:mobile_dikasa/data/services/pos_service.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/features/product/stock_panel.dart';

void main() {
  const base = String.fromEnvironment('DIKASA_LIVE_API_URL');
  test(
    'local photos, real XLSX, stock adjustment dedupe and variation sale round trip',
    () async {
      expect(['127.0.0.1', 'localhost'], contains(Uri.parse(base).host));
      dotenv.loadFromString(
        envString: 'API_BASE_URL=$base\nUSE_MOCK_API=false',
      );
      final client = ApiClient();
      final auth = AuthRepository(
        authService: AuthService(client),
        apiClient: client,
      );
      await auth.login(
        username: const String.fromEnvironment(
          'DIKASA_LIVE_USERNAME',
          defaultValue: 'admin',
        ),
        password: const String.fromEnvironment(
          'DIKASA_LIVE_PASSWORD',
          defaultValue: 'dikasa123',
        ),
      );
      final catalog = CatalogService(client);
      CatalogCategory? category;
      CatalogProduct? product;
      final label =
          'Completion verification ${DateTime.now().millisecondsSinceEpoch}';
      try {
        category = await catalog.saveCategory(
          'food',
          CatalogCategory(name: label),
        );
        final image = await File(
          'assets/images/catalog_placeholder.png',
        ).readAsBytes();
        product = await catalog.saveProduct(
          CatalogProduct(
            name: label,
            category: category,
            productType: 'food',
            price: 10000,
            costPrice: 5000,
            image: CatalogImage(
              name: 'verification.png',
              bytes: image,
              mimeType: 'image/png',
            ),
            variations: const [
              CatalogVariant(name: 'Jumbo', price: 15000, costPrice: 7000),
            ],
          ),
        );
        expect(product.imageUrl, contains('/dikasa/v1/product-images/'));
        final publicImage = await Dio().get<List<int>>(
          product.imageUrl!,
          options: Options(responseType: ResponseType.bytes),
        );
        expect(publicImage.statusCode, 200);
        expect(publicImage.data, image);
        await catalog.stockCommand(product.id, {
          'request_id': stockRequestId(),
          'reason': 'Local completion verification initial',
          'track_stock': true,
          'initial_quantity': 3,
          'low_stock_threshold': 2,
        });
        final adjustment = {
          'request_id': stockRequestId(),
          'reason': 'Deduplication verification',
          'quantity_delta': 1,
        };
        final first = await catalog.stockCommand(
          product.id,
          adjustment,
          adjust: true,
        );
        final repeated = await catalog.stockCommand(
          product.id,
          adjustment,
          adjust: true,
        );
        expect(repeated['id'], first['id']);
        expect((await catalog.product(product.id)).stockQuantity, 4);
        final bytes = await catalog.exportProducts(productId: product.id);
        expect(bytes.take(2), [80, 75]);
        await Directory('build/catalog-qa').create(recursive: true);
        await File(
          'build/catalog-qa/live-completion-export.xlsx',
        ).writeAsBytes(bytes);
        final pos = PosService(client);
        final vm = NewOrderViewModel(
          productRepository: ProductRepository(
            productService: ProductService(client),
          ),
          authRepository: auth,
          posService: pos,
        );
        await vm.loadPos();
        if (vm.cashSession == null) expect(await vm.openCash(100000), isTrue);
        await vm.loadProducts(forceRefresh: true);
        final choice = vm.products.singleWhere((p) => p.id == product!.id);
        expect(choice.imageUrl, product.imageUrl);
        expect(choice.variations.single.name, 'Jumbo');
        vm.addProduct(choice);
        vm.addProduct(choice.selectVariant(choice.variations.single));
        vm.selectOrderType(
          vm.orderTypes.firstWhere((t) => t.code == 'takeaway'),
        );
        expect(await vm.preparePayment(), isTrue);
        final total = vm.paymentTotal;
        final receipt = await vm.pay(method: 'cash', paidAmount: total);
        expect(vm.checkoutError, isNull);
        expect(receipt, isNotNull);
        expect(vm.orderItems, isEmpty);
        final after = await catalog.product(product.id);
        expect(after.stockQuantity, 2);
        expect(after.availability, 'low_stock');
        final history = await catalog.stockMovements(product.id);
        expect(
          (history['data'] as List)
              .where((r) => r['kind'] == 'sale')
              .single['quantity_delta'],
          -2,
        );
        await expectLater(
          catalog.stockCommand(product.id, {
            'request_id': stockRequestId(),
            'reason': 'Invalid negative verification',
            'quantity_delta': -3,
          }, adjust: true),
          throwsA(isA<ApiException>()),
        );
        expect((await catalog.product(product.id)).stockQuantity, 2);
        // ignore: avoid_print
        print(
          'Verified completion receipt ${receipt!.number}; total $total Rupiah; final shared balance 2.',
        );
      } finally {
        if (product != null) {
          await catalog.saveProduct(
            CatalogProduct(
              name: label,
              category: category!,
              productType: 'food',
              price: 10000,
              removeImage: true,
            ),
            id: product.id,
          );
          await catalog.deactivateProduct(product.id);
        }
        if (category != null) {
          await catalog.saveCategory(
            'food',
            CatalogCategory(id: category.id, name: label, isActive: false),
          );
        }
        client.dio.close();
      }
    },
    skip: base.isEmpty
        ? 'Opt in with DIKASA_LIVE_API_URL; writes a marked local verification receipt.'
        : false,
  );
}
