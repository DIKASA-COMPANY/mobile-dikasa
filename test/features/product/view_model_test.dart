import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';
import 'package:mobile_dikasa/data/services/catalog_files.dart';
import 'package:mobile_dikasa/data/services/catalog_service.dart';
import 'package:mobile_dikasa/features/product/view_model.dart';

import '../../helpers/test_env.dart';

class _CatalogService extends CatalogService {
  _CatalogService() : super(ApiClient());

  Map<String, dynamic>? exportedFilters;

  @override
  Future<List<Map<String, dynamic>>> types() async => [];

  @override
  Future<List<CatalogProduct>> products({bool includeInactive = false}) async =>
      [];

  @override
  Future<Uint8List> exportProducts({
    Map<String, dynamic> filters = const {},
    String? productId,
  }) async {
    exportedFilters = filters;
    return Uint8List.fromList([80, 75]);
  }
}

class _CatalogFiles extends CatalogFiles {
  int saves = 0;

  @override
  Future<bool> saveWorkbook(Uint8List bytes) async {
    saves++;
    return true;
  }
}

void main() {
  setUp(loadTestEnv);

  test(
    'load and export orchestration stays in the catalog ViewModel',
    () async {
      final service = _CatalogService();
      final files = _CatalogFiles();
      final viewModel = CatalogViewModel(service: service, files: files);

      await viewModel.load();
      expect(viewModel.loading, isFalse);
      expect(viewModel.error, isNull);

      viewModel.setSearch(' Kopi ');
      final reload = viewModel.applyFilters(
        type: 'drink',
        stock: 'available',
        category: 'category-1',
        includeInactive: true,
      );
      expect(reload, isTrue);
      expect(await viewModel.export(), isTrue);
      expect(files.saves, 1);
      expect(service.exportedFilters, {
        'searchByProductName': 'kopi',
        'product_type': 'drink',
        'category_id': 'category-1',
        'availability': 'available',
        'include_inactive': true,
      });
    },
  );
}
