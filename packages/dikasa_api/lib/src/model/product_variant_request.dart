//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_variant_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProductVariantRequest {
  /// Returns a new [ProductVariantRequest] instance.
  ProductVariantRequest({
    this.costPrice,

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
    unknownEnumValue:
        ProductVariantRequestStockStatusEnum.unknownDefaultOpenApi,
  )
  final ProductVariantRequestStockStatusEnum stockStatus;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductVariantRequest &&
          other.costPrice == costPrice &&
          other.name == name &&
          other.onlineCostPrice == onlineCostPrice &&
          other.onlineSellingPrice == onlineSellingPrice &&
          other.sellingPrice == sellingPrice &&
          other.sortOrder == sortOrder &&
          other.stockStatus == stockStatus;

  @override
  int get hashCode =>
      costPrice.hashCode +
      name.hashCode +
      onlineCostPrice.hashCode +
      onlineSellingPrice.hashCode +
      sellingPrice.hashCode +
      sortOrder.hashCode +
      stockStatus.hashCode;

  factory ProductVariantRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ProductVariantRequestStockStatusEnum {
  @JsonValue(r'available')
  available(r'available'),
  @JsonValue(r'out_of_stock')
  outOfStock(r'out_of_stock'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const ProductVariantRequestStockStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
