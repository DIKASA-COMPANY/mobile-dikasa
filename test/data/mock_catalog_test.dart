import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';
import 'package:mobile_dikasa/data/models/product.dart';
import 'package:mobile_dikasa/data/services/catalog_service.dart';
import 'package:mobile_dikasa/data/services/product_service.dart';
import 'package:mobile_dikasa/features/product/stock_panel.dart';
import 'dart:io';

void main() {
  test(
    'demo inventory deduplicates adjustments and exports a real workbook',
    () async {
      dotenv.loadFromString(
        envString: 'API_BASE_URL=http://mock.local\nUSE_MOCK_API=true',
      );
      final service = CatalogService(ApiClient());
      final product = (await service.products()).first;
      await service.stockCommand(product.id, {
        'request_id': stockRequestId(),
        'reason': 'Initial demo',
        'track_stock': true,
        'initial_quantity': 2,
        'low_stock_threshold': 1,
      });
      final adjust = {
        'request_id': stockRequestId(),
        'reason': 'One restock',
        'quantity_delta': 1,
      };
      final first = await service.stockCommand(
            product.id,
            adjust,
            adjust: true,
          ),
          second = await service.stockCommand(product.id, adjust, adjust: true);
      expect(second['id'], first['id']);
      expect((await service.product(product.id)).stockQuantity, 3);
      final workbook = await service.exportProducts(productId: product.id);
      expect(workbook.take(2), [80, 75]);
      await Directory('build/catalog-qa').create(recursive: true);
      await File('build/catalog-qa/mock-export.xlsx').writeAsBytes(workbook);
    },
  );
  test(
    'demo catalog changes are shared with cashier and survive category renames',
    () async {
      dotenv.loadFromString(
        envString: 'API_BASE_URL=http://mock.local\nUSE_MOCK_API=true',
      );
      final client = ApiClient();
      final service = CatalogService(client);
      final category = await service.saveCategory(
        'drink',
        const CatalogCategory(name: 'Minuman Baru'),
      );
      final product = await service.saveProduct(
        CatalogProduct(
          name: 'Demo Baru',
          category: category,
          productType: 'drink',
          price: 5000,
          stockStatus: 'out_of_stock',
        ),
      );
      await service.saveCategory(
        'drink',
        CatalogCategory(id: category.id, name: 'Kategori Diganti'),
      );
      final result = (await ProductService(
        client,
      ).fetchProducts()).singleWhere((p) => p.id == product.id);
      expect(result.group, ProductGroup.minuman);
      expect(result.category, 'Kategori Diganti');
      expect(result.isAvailable, isFalse);
      await service.deactivateProduct(product.id);
      expect(
        (await service.products()).any((p) => p.id == product.id),
        isFalse,
      );
      expect(
        (await service.products(
          includeInactive: true,
        )).singleWhere((p) => p.id == product.id).isActive,
        isFalse,
      );
      client.dio.close();
    },
  );
}
