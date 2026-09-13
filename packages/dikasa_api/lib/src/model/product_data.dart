//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/product_variant_data.dart';
import 'package:dikasa_api/src/model/category_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProductData {
  /// Returns a new [ProductData] instance.
  ProductData({
    required this.category,

    this.costPrice,

    required this.description,

    required this.id,

    this.imageUrl,

    required this.isActive,

    required this.isHighlighted,

    required this.name,

    this.onlineCostPrice,

    this.onlineSellingPrice,

    required this.price,

    required this.productType,

    required this.sellingPrice,

    required this.sortOrder,

    required this.stockStatus,

    required this.variations,
  });

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final CategoryData category;

  // minimum: 0
  @JsonKey(name: r'cost_price', required: false, includeIfNull: false)
  final int? costPrice;

  @JsonKey(name: r'description', required: true, includeIfNull: false)
  final String description;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'image_url', required: false, includeIfNull: false)
  final String? imageUrl;

  @JsonKey(name: r'is_active', required: true, includeIfNull: false)
  final bool isActive;

  @JsonKey(name: r'is_highlighted', required: true, includeIfNull: false)
  final bool isHighlighted;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  // minimum: 0
  @JsonKey(name: r'online_cost_price', required: false, includeIfNull: false)
  final int? onlineCostPrice;

  // minimum: 0
  @JsonKey(name: r'online_selling_price', required: false, includeIfNull: false)
  final int? onlineSellingPrice;

  // minimum: 0
  @JsonKey(name: r'price', required: true, includeIfNull: false)
  final int price;

  @JsonKey(
    name: r'product_type',
    required: true,
    includeIfNull: false,
    unknownEnumValue: ProductDataProductTypeEnum.unknownDefaultOpenApi,
  )
  final ProductDataProductTypeEnum productType;

  // minimum: 0
  @JsonKey(name: r'selling_price', required: true, includeIfNull: false)
  final int sellingPrice;

  @JsonKey(name: r'sort_order', required: true, includeIfNull: false)
  final int sortOrder;

  @JsonKey(
    name: r'stock_status',
    required: true,
    includeIfNull: false,
    unknownEnumValue: ProductDataStockStatusEnum.unknownDefaultOpenApi,
  )
  final ProductDataStockStatusEnum stockStatus;

  @JsonKey(name: r'variations', required: true, includeIfNull: true)
  final List<ProductVariantData>? variations;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductData &&
          other.category == category &&
          other.costPrice == costPrice &&
          other.description == description &&
          other.id == id &&
          other.imageUrl == imageUrl &&
          other.isActive == isActive &&
          other.isHighlighted == isHighlighted &&
          other.name == name &&
          other.onlineCostPrice == onlineCostPrice &&
          other.onlineSellingPrice == onlineSellingPrice &&
          other.price == price &&
          other.productType == productType &&
          other.sellingPrice == sellingPrice &&
          other.sortOrder == sortOrder &&
          other.stockStatus == stockStatus &&
          other.variations == variations;

  @override
  int get hashCode =>
      category.hashCode +
      costPrice.hashCode +
      description.hashCode +
      id.hashCode +
      imageUrl.hashCode +
      isActive.hashCode +
      isHighlighted.hashCode +
      name.hashCode +
      onlineCostPrice.hashCode +
      onlineSellingPrice.hashCode +
      price.hashCode +
      productType.hashCode +
      sellingPrice.hashCode +
      sortOrder.hashCode +
      stockStatus.hashCode +
      (variations == null ? 0 : variations.hashCode);

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ProductDataProductTypeEnum {
  @JsonValue(r'food')
  food(r'food'),
  @JsonValue(r'drink')
  drink(r'drink'),
  @JsonValue(r'additional')
  additional(r'additional'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const ProductDataProductTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum ProductDataStockStatusEnum {
  @JsonValue(r'available')
  available(r'available'),
  @JsonValue(r'out_of_stock')
  outOfStock(r'out_of_stock'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const ProductDataStockStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
