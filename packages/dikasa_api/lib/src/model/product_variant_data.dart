//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_variant_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProductVariantData {
  /// Returns a new [ProductVariantData] instance.
  ProductVariantData({
    this.costPrice,

    required this.id,

    required this.isActive,

    required this.name,

    this.onlineCostPrice,

    this.onlineSellingPrice,

    required this.sellingPrice,

    required this.sortOrder,

    required this.stockStatus,
  });

  // minimum: 0
  @JsonKey(name: r'cost_price', required: false, includeIfNull: false)
  final int? costPrice;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'is_active', required: true, includeIfNull: false)
  final bool isActive;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  // minimum: 0
  @JsonKey(name: r'online_cost_price', required: false, includeIfNull: false)
  final int? onlineCostPrice;

  // minimum: 0
  @JsonKey(name: r'online_selling_price', required: false, includeIfNull: false)
  final int? onlineSellingPrice;

  // minimum: 0
  @JsonKey(name: r'selling_price', required: true, includeIfNull: false)
  final int sellingPrice;

  @JsonKey(name: r'sort_order', required: true, includeIfNull: false)
  final int sortOrder;

  @JsonKey(
    name: r'stock_status',
    required: true,
    includeIfNull: false,
    unknownEnumValue: ProductVariantDataStockStatusEnum.unknownDefaultOpenApi,
  )
  final ProductVariantDataStockStatusEnum stockStatus;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductVariantData &&
          other.costPrice == costPrice &&
          other.id == id &&
          other.isActive == isActive &&
          other.name == name &&
          other.onlineCostPrice == onlineCostPrice &&
          other.onlineSellingPrice == onlineSellingPrice &&
          other.sellingPrice == sellingPrice &&
          other.sortOrder == sortOrder &&
          other.stockStatus == stockStatus;

  @override
  int get hashCode =>
      costPrice.hashCode +
      id.hashCode +
      isActive.hashCode +
      name.hashCode +
      onlineCostPrice.hashCode +
      onlineSellingPrice.hashCode +
      sellingPrice.hashCode +
      sortOrder.hashCode +
      stockStatus.hashCode;

  factory ProductVariantData.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ProductVariantDataStockStatusEnum {
  @JsonValue(r'available')
  available(r'available'),
  @JsonValue(r'out_of_stock')
  outOfStock(r'out_of_stock'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const ProductVariantDataStockStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
