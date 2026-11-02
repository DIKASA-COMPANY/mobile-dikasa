//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receipt_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReceiptItem {
  /// Returns a new [ReceiptItem] instance.
  ReceiptItem({
    required this.id,

    required this.lineTotal,

    required this.productId,

    required this.productName,

    this.productVariantId,

    required this.quantity,

    required this.refundedQuantity,

    required this.restockBudget,

    required this.returnedQuantity,

    required this.stockQuantity,

    required this.trackStock,

    required this.unitPrice,

    this.variantName,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'line_total', required: true, includeIfNull: false)
  final int lineTotal;

  @JsonKey(name: r'product_id', required: true, includeIfNull: false)
  final String productId;

  @JsonKey(name: r'product_name', required: true, includeIfNull: false)
  final String productName;

  @JsonKey(name: r'product_variant_id', required: false, includeIfNull: false)
  final String? productVariantId;

  @JsonKey(name: r'quantity', required: true, includeIfNull: false)
  final int quantity;

  @JsonKey(name: r'refunded_quantity', required: true, includeIfNull: false)
  final int refundedQuantity;

  @JsonKey(name: r'restock_budget', required: true, includeIfNull: false)
  final int restockBudget;

  @JsonKey(name: r'returned_quantity', required: true, includeIfNull: false)
  final int returnedQuantity;

  @JsonKey(name: r'stock_quantity', required: true, includeIfNull: false)
  final int stockQuantity;

  @JsonKey(name: r'track_stock', required: true, includeIfNull: false)
  final bool trackStock;

  @JsonKey(name: r'unit_price', required: true, includeIfNull: false)
  final int unitPrice;

  @JsonKey(name: r'variant_name', required: false, includeIfNull: false)
  final String? variantName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReceiptItem &&
          other.id == id &&
          other.lineTotal == lineTotal &&
          other.productId == productId &&
          other.productName == productName &&
          other.productVariantId == productVariantId &&
          other.quantity == quantity &&
          other.refundedQuantity == refundedQuantity &&
          other.restockBudget == restockBudget &&
          other.returnedQuantity == returnedQuantity &&
          other.stockQuantity == stockQuantity &&
          other.trackStock == trackStock &&
          other.unitPrice == unitPrice &&
          other.variantName == variantName;

  @override
  int get hashCode =>
      id.hashCode +
      lineTotal.hashCode +
      productId.hashCode +
      productName.hashCode +
      productVariantId.hashCode +
      quantity.hashCode +
      refundedQuantity.hashCode +
      restockBudget.hashCode +
      returnedQuantity.hashCode +
      stockQuantity.hashCode +
      trackStock.hashCode +
      unitPrice.hashCode +
      variantName.hashCode;

  factory ReceiptItem.fromJson(Map<String, dynamic> json) =>
      _$ReceiptItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
