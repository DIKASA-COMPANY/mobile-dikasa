import 'package:mobile_dikasa/data/models/product.dart';
import 'package:mobile_dikasa/data/services/product_service.dart';

/// Sumber kebenaran tunggal untuk katalog produk.
///
/// Katalog jarang berubah selama satu shift kasir, sehingga hasilnya disimpan
/// agar berpindah tab kategori tidak memicu request baru.
class ProductRepository {
  ProductRepository({required ProductService productService})
    : _productService = productService;

  final ProductService _productService;

  List<Product>? _cachedProducts;
  int _generation = 0;

  Future<List<Product>> getProducts({bool forceRefresh = false}) async {
    final generation = _generation;
    final List<Product>? cached = _cachedProducts;
    if (cached != null && !forceRefresh) {
      return cached;
    }

    final List<Product> products = await _productService.fetchProducts();
    if (generation == _generation) _cachedProducts = products;
    return products;
  }

  void clear() {
    _generation++;
    _cachedProducts = null;
  }
}
