import 'package:dio/dio.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_endpoints.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/product.dart';

/// Lapisan jaringan untuk katalog produk.
class ProductService {
  const ProductService(this._apiClient);

  final ApiClient _apiClient;

  /// GET /products
  Future<List<Product>> fetchProducts() async {
    try {
      final products = <Product>[];
      var page = 1;
      while (true) {
        final Response<dynamic> response = await _apiClient.dio.get<dynamic>(
          ApiEndpoints.products,
          queryParameters: {'page': page, 'page_size': 100},
        );

        final body = response.data;
        final List<dynamic> data =
            (body is List ? body : (body as Map<String, dynamic>)['data'])
                as List<dynamic>;
        products.addAll(
          data
              .map(
                (dynamic item) =>
                    Product.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
        );
        if (body is List || data.isEmpty) return products;
        final meta =
            (body as Map<String, dynamic>)['meta'] as Map<String, dynamic>;
        final total = (meta['total'] as num).toInt();
        if (products.length >= total) return products;
        page++;
      }
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    } on TypeError {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format data dari server tidak sesuai.',
      );
    }
  }
}
