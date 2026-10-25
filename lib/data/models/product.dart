/// Kelompok besar produk, sesuai tiga tab pada halaman Order.
enum ProductGroup {
  makanan('Makanan'),
  minuman('Minuman'),
  tambahan('Tambahan');

  const ProductGroup(this.label);

  /// Teks yang ditampilkan pada tab.
  final String label;

  static ProductGroup fromJson(String? value) {
    switch (value) {
      case 'food':
        return ProductGroup.makanan;
      case 'drink':
        return ProductGroup.minuman;
      case 'additional':
        return ProductGroup.tambahan;
    }
    return ProductGroup.values.firstWhere(
      (ProductGroup group) => group.name == value,
      orElse: () => ProductGroup.makanan,
    );
  }
}

/// One sellable variant; its quantity comes from the parent product's balance.
class ProductVariation {
  const ProductVariation({
    required this.id,
    required this.name,
    required this.price,
    this.isAvailable = true,
  });
  final String id, name;
  final int price;
  final bool isAvailable;
  factory ProductVariation.fromJson(Map<String, dynamic> j) => ProductVariation(
    id: j['id'] as String,
    name: j['name'] as String,
    price: (j['selling_price'] as num).toInt(),
    isAvailable: j['is_active'] != false && j['stock_status'] != 'out_of_stock',
  );
}

/// A catalog product or selected cart variation; [id] always remains the actual product ID.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageAsset,
    required this.group,
    required this.category,
    required this.isHighlighted,
    this.isAvailable = true,
    this.imageUrl,
    this.variantId,
    this.variantName,
    this.trackStock = false,
    this.stockQuantity = 0,
    this.variations = const [],
  });
  final String id, name, imageAsset, category;
  final String? imageUrl, variantId, variantName;
  final int price, stockQuantity;
  final ProductGroup group;
  final bool isHighlighted, isAvailable, trackStock;
  final List<ProductVariation> variations;
  String get cartKey => '$id:${variantId ?? "base"}';
  String get displayName => variantName == null ? name : '$name — $variantName';
  Product selectVariant(ProductVariation v) => Product(
    id: id,
    name: name,
    price: v.price,
    imageAsset: imageAsset,
    imageUrl: imageUrl,
    group: group,
    category: category,
    isHighlighted: isHighlighted,
    isAvailable: isAvailable && v.isAvailable,
    variantId: v.id,
    variantName: v.name,
    trackStock: trackStock,
    stockQuantity: stockQuantity,
  );
  factory Product.fromJson(Map<String, dynamic> j) => Product(
    id: j['id'].toString(),
    name: j['name'] as String? ?? '',
    price: ((j['price'] ?? j['selling_price']) as num?)?.toInt() ?? 0,
    imageAsset: j['image_asset'] as String? ?? '',
    imageUrl: j['image_url'] as String?,
    group: ProductGroup.fromJson((j['group'] ?? j['product_type']) as String?),
    category: j['category'] is Map
        ? (j['category'] as Map)['name'] as String? ?? ''
        : j['category'] as String? ?? '',
    isHighlighted: j['is_highlighted'] as bool? ?? false,
    isAvailable:
        j['stock_status'] != 'out_of_stock' &&
        j['effective_stock_status'] != 'out_of_stock' &&
        j['is_active'] != false &&
        !(j['track_stock'] == true && (j['stock_quantity'] as num? ?? 0) <= 0),
    trackStock: j['track_stock'] == true,
    stockQuantity: (j['stock_quantity'] as num?)?.toInt() ?? 0,
    variations: ((j['variations'] as List?) ?? [])
        .where((v) => v['is_active'] != false)
        .map((v) => ProductVariation.fromJson(v as Map<String, dynamic>))
        .toList(),
  );
}
