import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/services/catalog_service.dart';
import 'package:mobile_dikasa/data/services/product_service.dart';

void main() {
  const baseUrl = String.fromEnvironment('DIKASA_LIVE_API_URL');
  test(
    'local catalog create, edit, categories and cashier availability',
    () async {
      expect([
        'localhost',
        '127.0.0.1',
        '::1',
      ], contains(Uri.parse(baseUrl).host));
      dotenv.loadFromString(
        envString: 'API_BASE_URL=$baseUrl\nUSE_MOCK_API=false',
      );
      final client = ApiClient();
      await AuthRepository(
        authService: AuthService(client),
        apiClient: client,
      ).login(
        username: const String.fromEnvironment(
          'DIKASA_LIVE_USERNAME',
          defaultValue: 'admin',
        ),
        password: const String.fromEnvironment(
          'DIKASA_LIVE_PASSWORD',
          defaultValue: 'dikasa123',
        ),
      );
      final service = CatalogService(client);
      final label =
          'Catalog verification ${DateTime.now().millisecondsSinceEpoch}';
      CatalogCategory? category;
      CatalogProduct? product;
      try {
        category = await service.saveCategory(
          'food',
          CatalogCategory(name: label),
        );
        product = await service.saveProduct(
          CatalogProduct(
            name: label,
            category: category,
            productType: 'food',
            price: 12500,
            onlinePrice: 14000,
            costPrice: 7000,
            variations: const [
              CatalogVariant(name: 'Jumbo', price: 18000, costPrice: 10000),
            ],
          ),
        );
        expect(product.variations.single.name, 'Jumbo');
        final before = await client.dio.get<Map<String, dynamic>>(
          '/products/${product.id}',
        );
        final variantId = (before.data!['data'] as Map)['variations'][0]['id'];
        product = await service.saveProduct(
          CatalogProduct(
            id: product.id,
            name: '$label edited',
            category: category,
            productType: 'food',
            price: 13000,
            onlinePrice: 14500,
            costPrice: 7500,
            stockStatus: 'out_of_stock',
            variations: product.variations,
          ),
          id: product.id,
        );
        expect(product.price, 13000);
        expect(product.onlinePrice, 14500);
        expect(product.costPrice, 7500);
        expect(product.variations.single.costPrice, 10000);
        final after = await client.dio.get<Map<String, dynamic>>(
          '/products/${product.id}',
        );
        expect((after.data!['data'] as Map)['variations'][0]['id'], variantId);
        final cashier = await ProductService(client).fetchProducts();
        expect(
          cashier.singleWhere((p) => p.id == product!.id).isAvailable,
          isFalse,
        );
        final updatedCategory = await service.saveCategory(
          'food',
          CatalogCategory(id: category.id, name: '$label renamed'),
        );
        expect(updatedCategory.name, '$label renamed');
        final list = await service.products();
        expect(
          list.singleWhere((p) => p.id == product!.id).category.name,
          '$label renamed',
        );
      } finally {
        if (product != null) await service.deactivateProduct(product.id);
        if (category != null) {
          await service.saveCategory(
            'food',
            CatalogCategory(id: category.id, name: label, isActive: false),
          );
        }
        client.dio.close();
      }
    },
    skip: baseUrl.isEmpty
        ? 'Opt in with DIKASA_LIVE_API_URL pointing to a local API.'
        : false,
  );
}
