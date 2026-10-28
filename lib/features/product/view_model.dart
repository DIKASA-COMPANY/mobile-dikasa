import 'package:flutter/foundation.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';
import 'package:mobile_dikasa/data/services/catalog_files.dart';
import 'package:mobile_dikasa/data/services/catalog_service.dart';

class CatalogViewModel extends ChangeNotifier {
  CatalogViewModel({
    required CatalogService service,
    CatalogFiles files = const CatalogFiles(),
  }) : _service = service,
       _files = files;

  final CatalogService _service;
  final CatalogFiles _files;
  final Map<String, List<CatalogCategory>> categories = {};
  List<CatalogProduct> products = [];
  List<Map<String, dynamic>> types = [];
  String query = '', type = '', stock = '', category = '';
  String? error;
  bool loading = true, includeInactive = false, exporting = false;
  int page = 0;
  DateTime? updated;
  int _request = 0;
  bool _disposed = false;

  // Transitional dependency for the existing product editor/category dialogs.
  // Their data orchestration is migrated independently; the catalog screen itself
  // never calls this service directly.
  CatalogService get editorService => _service;

  Future<void> load() async {
    final request = ++_request;
    loading = true;
    error = null;
    _notify();
    try {
      final nextTypes = await _service.types();
      final results = await Future.wait([
        _service.products(includeInactive: includeInactive),
        ...nextTypes.map((item) => _service.categories(item['code'] as String)),
      ]);
      if (!_current(request)) return;
      types = nextTypes;
      products = results[0] as List<CatalogProduct>;
      categories.clear();
      for (var i = 0; i < nextTypes.length; i++) {
        categories[nextTypes[i]['code'] as String] =
            results[i + 1] as List<CatalogCategory>;
      }
      loading = false;
      updated = DateTime.now();
      page = 0;
      if (!categories.values
          .expand((value) => value)
          .any((item) => item.id == category)) {
        category = '';
      }
      _notify();
    } on ApiException catch (exception) {
      if (_current(request)) {
        error = exception.message;
        loading = false;
        _notify();
      }
    }
  }

  Future<bool> export() async {
    if (exporting) return false;
    exporting = true;
    error = null;
    _notify();
    try {
      final bytes = await _service.exportProducts(
        filters: {
          if (query.isNotEmpty) 'searchByProductName': query,
          if (type.isNotEmpty) 'product_type': type,
          if (category.isNotEmpty) 'category_id': category,
          if (stock.isNotEmpty) 'availability': stock,
          if (includeInactive) 'include_inactive': true,
        },
      );
      return await _files.saveWorkbook(bytes);
    } on ApiException catch (exception) {
      error = exception.message;
      return false;
    } finally {
      if (!_disposed) {
        exporting = false;
        _notify();
      }
    }
  }

  void setSearch(String value) {
    query = value.trim().toLowerCase();
    page = 0;
    _notify();
  }

  bool applyFilters({
    required String type,
    required String stock,
    required String category,
    required bool includeInactive,
  }) {
    final shouldReload = this.includeInactive != includeInactive;
    this.type = type;
    this.stock = stock;
    this.category = category;
    this.includeInactive = includeInactive;
    page = 0;
    _notify();
    return shouldReload;
  }

  List<CatalogProduct> get filteredProducts => products
      .where(
        (product) =>
            product.name.toLowerCase().contains(query) &&
            (type.isEmpty || product.productType == type) &&
            (stock.isEmpty || product.availability == stock) &&
            (category.isEmpty || product.category.id == category),
      )
      .toList();

  List<CatalogProduct> get visibleProducts =>
      filteredProducts.skip(page * 25).take(25).toList();

  String typeName(String code) =>
      types
          .where((item) => item['code'] == code)
          .map((item) => item['name'] as String)
          .firstOrNull ??
      code;

  String get capitalLabel {
    final tracked = products.where((product) => product.trackStock);
    if (tracked.isEmpty) return 'Nilai Modal Stok: — (stok belum dilacak)';
    final missing = tracked
        .where((product) => product.costPrice == null)
        .length;
    final total = tracked.fold<BigInt>(
      BigInt.zero,
      (sum, product) =>
          sum +
          BigInt.from(product.stockQuantity) *
              BigInt.from(product.costPrice ?? 0),
    );
    final digits = total.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
    return 'Nilai Modal Stok: Rp $digits${missing == 0 ? '' : ' ($missing produk tanpa harga modal)'}';
  }

  void previousPage() {
    if (page == 0) return;
    page--;
    _notify();
  }

  void nextPage() {
    if ((page + 1) * 25 >= filteredProducts.length) return;
    page++;
    _notify();
  }

  bool _current(int request) => !_disposed && request == _request;
  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _request++;
    super.dispose();
  }
}
