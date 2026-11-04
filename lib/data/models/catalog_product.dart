import 'dart:typed_data';

class CatalogImage {
  const CatalogImage({
    required this.name,
    required this.bytes,
    required this.mimeType,
  });
  final String name, mimeType;
  final Uint8List bytes;
}

/// Commerce fields used by management; kept separate from cashier snapshots.
class CatalogCategory {
  const CatalogCategory({
    this.id = '',
    required this.name,
    this.sortOrder = 0,
    this.isActive = true,
  });
  final String id, name;
  final int sortOrder;
  final bool isActive;
  factory CatalogCategory.fromJson(Map<String, dynamic> j) => CatalogCategory(
    id: j['id'] as String,
    name: j['name'] as String,
    sortOrder: (j['sort_order'] as num?)?.toInt() ?? 0,
    isActive: j['is_active'] as bool? ?? true,
  );
  Map<String, dynamic> toRequest() => {
    'name': name.trim(),
    'sort_order': sortOrder,
    'is_active': isActive,
  };
}

class CatalogVariant {
  const CatalogVariant({
    required this.name,
    required this.price,
    this.onlinePrice,
    this.costPrice,
    this.onlineCostPrice,
    this.stockStatus = 'available',
    this.sortOrder = 0,
  });
  final String name, stockStatus;
  final int price, sortOrder;
  final int? onlinePrice, costPrice, onlineCostPrice;
  factory CatalogVariant.fromJson(Map<String, dynamic> j) => CatalogVariant(
    name: j['name'] as String,
    price: (j['selling_price'] as num).toInt(),
    onlinePrice: (j['online_selling_price'] as num?)?.toInt(),
    costPrice: (j['cost_price'] as num?)?.toInt(),
    onlineCostPrice: (j['online_cost_price'] as num?)?.toInt(),
    stockStatus: j['stock_status'] as String? ?? 'available',
    sortOrder: (j['sort_order'] as num?)?.toInt() ?? 0,
  );
  Map<String, dynamic> toRequest() => {
    'name': name.trim(),
    'selling_price': price,
    if (onlinePrice != null) 'online_selling_price': onlinePrice,
    if (costPrice != null) 'cost_price': costPrice,
    if (onlineCostPrice != null) 'online_cost_price': onlineCostPrice,
    'stock_status': stockStatus,
    'sort_order': sortOrder,
  };
}

class CatalogProduct {
  const CatalogProduct({
    this.id = '',
    required this.name,
    required this.category,
    required this.productType,
    required this.price,
    this.onlinePrice,
    this.costPrice,
    this.onlineCostPrice,
    this.stockStatus = 'available',
    this.description = '',
    this.imageUrl,
    this.isHighlighted = false,
    this.isActive = true,
    this.sortOrder = 0,
    this.variations = const [],
    this.image,
    this.removeImage = false,
    this.trackStock = false,
    this.stockQuantity = 0,
    this.lowStockThreshold = 0,
    this.effectiveStockStatus = "available",
  });
  final String id, name, productType, stockStatus, description;
  final CatalogCategory category;
  final int price, sortOrder;
  final int? onlinePrice, costPrice, onlineCostPrice;
  final String? imageUrl;
  final bool isHighlighted, isActive;
  final List<CatalogVariant> variations;
  final CatalogImage? image;
  final bool removeImage, trackStock;
  final int stockQuantity, lowStockThreshold;
  final String effectiveStockStatus;
  String get availability =>
      stockStatus == "out_of_stock" || (trackStock && stockQuantity == 0)
      ? "out_of_stock"
      : trackStock && stockQuantity <= lowStockThreshold
      ? "low_stock"
      : effectiveStockStatus;
  factory CatalogProduct.fromJson(Map<String, dynamic> j) => CatalogProduct(
    id: j['id'] as String,
    name: j['name'] as String,
    category: CatalogCategory.fromJson(j['category'] as Map<String, dynamic>),
    productType: j['product_type'] as String,
    price: ((j['selling_price'] ?? j['price']) as num).toInt(),
    onlinePrice: (j['online_selling_price'] as num?)?.toInt(),
    costPrice: (j['cost_price'] as num?)?.toInt(),
    onlineCostPrice: (j['online_cost_price'] as num?)?.toInt(),
    stockStatus: j['stock_status'] as String? ?? 'available',
    trackStock: j['track_stock'] == true,
    stockQuantity: (j['stock_quantity'] as num?)?.toInt() ?? 0,
    lowStockThreshold: (j['low_stock_threshold'] as num?)?.toInt() ?? 0,
    effectiveStockStatus:
        (j['effective_stock_status'] ?? j['stock_status']) as String? ??
        'available',
    description: j['description'] as String? ?? '',
    imageUrl: j['image_url'] as String?,
    isHighlighted: j['is_highlighted'] as bool? ?? false,
    isActive: j['is_active'] as bool? ?? true,
    sortOrder: (j['sort_order'] as num?)?.toInt() ?? 0,
    variations: ((j['variations'] as List?) ?? [])
        .map((v) => CatalogVariant.fromJson(v as Map<String, dynamic>))
        .toList(),
  );
  Map<String, dynamic> toFields() => {
    'name': name.trim(),
    'category_id': category.id,
    'product_type': productType,
    'selling_price': price,
    'stock_status': stockStatus,
    'description': description.trim(),
    if (onlinePrice != null) 'online_selling_price': onlinePrice,
    if (costPrice != null) 'cost_price': costPrice,
    if (onlineCostPrice != null) 'online_cost_price': onlineCostPrice,
    'remove_image': removeImage,
    'is_highlighted': isHighlighted,
    'is_active': isActive,
    'sort_order': sortOrder,
  };
}
