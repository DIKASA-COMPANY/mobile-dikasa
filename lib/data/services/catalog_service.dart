import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';

/// The server may have committed a write before the response was lost.
class CatalogWriteUncertain extends ApiException {
  const CatalogWriteUncertain()
    : super(
        type: ApiErrorType.network,
        message:
            'Status penyimpanan belum pasti. Kembali ke katalog, muat ulang, lalu periksa hasilnya sebelum mencoba lagi.',
      );
}

class CatalogService {
  CatalogService(this.client);
  final ApiClient client;

  Future<T> _request<T>(
    Future<T> Function() action, {
    bool write = false,
  }) async {
    try {
      return await action();
    } on DioException catch (e) {
      if (write &&
          (e.response == null || (e.response?.statusCode ?? 500) >= 500)) {
        throw const CatalogWriteUncertain();
      }
      throw ApiException.fromDio(e);
    } on TypeError {
      if (write) throw const CatalogWriteUncertain();
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format katalog dari server tidak sesuai.',
      );
    }
  }

  Future<List<CatalogProduct>> products({bool includeInactive = false}) =>
      _request(() async {
        final result = <CatalogProduct>[];
        for (var page = 1; ; page++) {
          final r = await client.dio.get<Map<String, dynamic>>(
            '/products',
            queryParameters: {
              'page': page,
              'page_size': 100,
              if (includeInactive) 'include_inactive': true,
            },
          );
          final rows = r.data!['data'] as List;
          result.addAll(
            rows.map((j) => CatalogProduct.fromJson(j as Map<String, dynamic>)),
          );
          final total =
              (r.data!['meta'] as Map<String, dynamic>)['total'] as num;
          if (rows.isEmpty || result.length >= total) return result;
        }
      });

  Future<List<Map<String, dynamic>>> types() => _request(() async {
    final r = await client.dio.get<Map<String, dynamic>>('/product-types');
    return (r.data!['data'] as List).cast<Map<String, dynamic>>();
  });

  Future<List<CatalogCategory>> categories(String type) => _request(() async {
    final r = await client.dio.get<Map<String, dynamic>>(
      '/product-types/$type/categories',
    );
    return (r.data!['data'] as List)
        .map((j) => CatalogCategory.fromJson(j as Map<String, dynamic>))
        .toList();
  });

  /// PATCH leaves unchanged variation IDs intact; replacement is explicit.
  Future<CatalogProduct> saveProduct(
    CatalogProduct product, {
    String? id,
    bool replaceVariations = false,
  }) => _request(() async {
    final form = FormData.fromMap(product.toFields());
    if (product.image != null) {
      form.files.add(
        MapEntry(
          "image",
          MultipartFile.fromBytes(
            product.image!.bytes,
            filename: product.image!.name,
            contentType: DioMediaType.parse(product.image!.mimeType),
          ),
        ),
      );
    }
    if (id == null || replaceVariations) {
      form.files.add(
        MapEntry(
          'variations',
          MultipartFile.fromString(
            jsonEncode(product.variations.map((v) => v.toRequest()).toList()),
            contentType: DioMediaType('application', 'json'),
          ),
        ),
      );
    }
    final r = await client.dio.request<Map<String, dynamic>>(
      id == null ? '/products' : '/products/$id',
      data: form,
      options: Options(
        method: id == null ? 'POST' : 'PATCH',
        contentType: 'multipart/form-data',
      ),
    );
    return CatalogProduct.fromJson(r.data!['data'] as Map<String, dynamic>);
  }, write: true);

  Future<void> deactivateProduct(String id) => _request(() async {
    await client.dio.delete<void>('/products/$id');
  }, write: true);

  Future<CatalogCategory> saveCategory(
    String type,
    CatalogCategory category,
  ) => _request(() async {
    final r = await client.dio.request<Map<String, dynamic>>(
      '/product-types/$type/categories${category.id.isEmpty ? '' : '/${category.id}'}',
      data: category.toRequest(),
      options: Options(method: category.id.isEmpty ? 'POST' : 'PATCH'),
    );
    return CatalogCategory.fromJson(r.data!['data'] as Map<String, dynamic>);
  }, write: true);
  Future<Uint8List> exportProducts({
    Map<String, dynamic> filters = const {},
    String? productId,
  }) => _request(() async {
    final r = await client.dio.get<List<int>>(
      '/products/export.xlsx',
      queryParameters: {...filters, 'product_id': ?productId},
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(r.data!);
  });
  Future<Map<String, dynamic>> stockCommand(
    String id,
    Map<String, dynamic> command, {
    bool adjust = false,
  }) => _request(() async {
    final r = await client.dio.post<Map<String, dynamic>>(
      '/products/$id/${adjust ? 'stock-adjustments' : 'stock'}',
      data: command,
    );
    return r.data!['data'] as Map<String, dynamic>;
  }, write: true);
  Future<Map<String, dynamic>> stockMovements(String id, {int page = 1}) =>
      _request(() async {
        final r = await client.dio.get<Map<String, dynamic>>(
          '/products/$id/stock-movements',
          queryParameters: {'page': page, 'page_size': 20},
        );
        return r.data!;
      });
  Future<CatalogProduct> product(String id) => _request(() async {
    final r = await client.dio.get<Map<String, dynamic>>(
      '/products/$id',
      queryParameters: {'include_inactive': true},
    );
    return CatalogProduct.fromJson(r.data!['data'] as Map<String, dynamic>);
  });
}
