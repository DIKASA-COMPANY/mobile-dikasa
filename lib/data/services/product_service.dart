import 'package:dikasa_api/dikasa_api.dart' as generated;
import 'package:dio/dio.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
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

  Product _toProduct(generated.ProductData data) {
    return Product(
      id: data.id,
      name: data.name,
      price: data.sellingPrice,
      imageUrl: data.imageUrl,
      imageAsset: _demoAssets[data.name],
      group: ProductGroup.fromApi(data.productType.value),
      category: data.category.name,
      isHighlighted: data.isHighlighted,
      isAvailable:
          data.stockStatus == generated.ProductDataStockStatusEnum.available,
    );
  }

  static const Map<String, String> _demoAssets = <String, String>{
    'Cumi Goreng Asam Manis': 'assets/images/cumia_goreng_asam_manis.png',
    'Cumi Goreng Mentega': 'assets/images/cumi_goreng_mentega.png',
    "Se'i Sapi Single Portion": 'assets/images/sei_sapi_single_portion.png',
    "Se'i Sapi Double Portion": 'assets/images/sei_sapi_double_portion.png',
    'Ayam Geprek Sambal Matah': 'assets/images/ayam_geprek_sambel_matah.png',
    'Ayam Geprek Spesial': 'assets/images/ayam_geprek_spesial.png',
    'Nasi Goreng Nugget': 'assets/images/nasi_goreng_nugget.png',
    'Nasi Goreng Spesial': 'assets/images/nasi_goreng_spesial.png',
    'Nasi Goreng Sosis': 'assets/images/nasi_goreng_sosis.png',
    'Nasi Goreng Katsu': 'assets/images/nasi_goreng_katsu.png',
    'Chicken Katsu with Rice': 'assets/images/chicken_katsu_with_rice.png',
    'Es Teh Manis Jumbo': 'assets/images/es_teh_manis_jumbo.png',
    'Teh Manis Panas': 'assets/images/teh_manis_panas.png',
    'Ice Lemon Tea': 'assets/images/ice_lemon_tea.png',
    'Ice Choco Hazelnut': 'assets/images/ice_choco_hazelnut.png',
  };
}
