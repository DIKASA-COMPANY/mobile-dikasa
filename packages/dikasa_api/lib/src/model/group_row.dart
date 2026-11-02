//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_row.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GroupRow {
  /// Returns a new [GroupRow] instance.
  GroupRow({
    required this.averageTransaction,

    this.categoryId,

    this.categoryName,

    required this.chargedSales,

    required this.discountAmount,

    required this.excludedReceipts,

    required this.grossSales,

    required this.key,

    required this.name,

    required this.netQuantity,

    required this.netSales,

    required this.netTax,

    this.productId,

    required this.refundAmount,

    required this.refundCount,

    required this.refundNet,

    required this.refundTax,

    required this.returnedQuantity,

    required this.saleCount,

    required this.saleTax,

    required this.salesAfterDiscount,

    required this.soldQuantity,

    required this.unitPriceMax,

    required this.unitPriceMin,

    required this.unknownCategoryQuantity,

    required this.valueAfterRefunds,

    this.variantId,
  });

  @JsonKey(name: r'average_transaction', required: true, includeIfNull: true)
  final int? averageTransaction;

  @JsonKey(name: r'category_id', required: false, includeIfNull: false)
  final String? categoryId;

  @JsonKey(name: r'category_name', required: false, includeIfNull: false)
  final String? categoryName;

  @JsonKey(name: r'charged_sales', required: true, includeIfNull: false)
  final int chargedSales;

  @JsonKey(name: r'discount_amount', required: true, includeIfNull: false)
  final int discountAmount;

  @JsonKey(name: r'excluded_receipts', required: true, includeIfNull: false)
  final int excludedReceipts;

  @JsonKey(name: r'gross_sales', required: true, includeIfNull: false)
  final int grossSales;

  @JsonKey(name: r'key', required: true, includeIfNull: false)
  final String key;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'net_quantity', required: true, includeIfNull: false)
  final int netQuantity;

  @JsonKey(name: r'net_sales', required: true, includeIfNull: false)
  final int netSales;

  @JsonKey(name: r'net_tax', required: true, includeIfNull: false)
  final int netTax;

  @JsonKey(name: r'product_id', required: false, includeIfNull: false)
  final String? productId;

  @JsonKey(name: r'refund_amount', required: true, includeIfNull: false)
  final int refundAmount;

  @JsonKey(name: r'refund_count', required: true, includeIfNull: false)
  final int refundCount;

  @JsonKey(name: r'refund_net', required: true, includeIfNull: false)
  final int refundNet;

  @JsonKey(name: r'refund_tax', required: true, includeIfNull: false)
  final int refundTax;

  @JsonKey(name: r'returned_quantity', required: true, includeIfNull: false)
  final int returnedQuantity;

  @JsonKey(name: r'sale_count', required: true, includeIfNull: false)
  final int saleCount;

  @JsonKey(name: r'sale_tax', required: true, includeIfNull: false)
  final int saleTax;

  @JsonKey(name: r'sales_after_discount', required: true, includeIfNull: false)
  final int salesAfterDiscount;

  @JsonKey(name: r'sold_quantity', required: true, includeIfNull: false)
  final int soldQuantity;

  @JsonKey(name: r'unit_price_max', required: true, includeIfNull: true)
  final int? unitPriceMax;

  @JsonKey(name: r'unit_price_min', required: true, includeIfNull: true)
  final int? unitPriceMin;

  @JsonKey(
    name: r'unknown_category_quantity',
    required: true,
    includeIfNull: false,
  )
  final int unknownCategoryQuantity;

  @JsonKey(name: r'value_after_refunds', required: true, includeIfNull: false)
  final int valueAfterRefunds;

  @JsonKey(name: r'variant_id', required: false, includeIfNull: false)
  final String? variantId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupRow &&
          other.averageTransaction == averageTransaction &&
          other.categoryId == categoryId &&
          other.categoryName == categoryName &&
          other.chargedSales == chargedSales &&
          other.discountAmount == discountAmount &&
          other.excludedReceipts == excludedReceipts &&
          other.grossSales == grossSales &&
          other.key == key &&
          other.name == name &&
          other.netQuantity == netQuantity &&
          other.netSales == netSales &&
          other.netTax == netTax &&
          other.productId == productId &&
          other.refundAmount == refundAmount &&
          other.refundCount == refundCount &&
          other.refundNet == refundNet &&
          other.refundTax == refundTax &&
          other.returnedQuantity == returnedQuantity &&
          other.saleCount == saleCount &&
          other.saleTax == saleTax &&
          other.salesAfterDiscount == salesAfterDiscount &&
          other.soldQuantity == soldQuantity &&
          other.unitPriceMax == unitPriceMax &&
          other.unitPriceMin == unitPriceMin &&
          other.unknownCategoryQuantity == unknownCategoryQuantity &&
          other.valueAfterRefunds == valueAfterRefunds &&
          other.variantId == variantId;

  @override
  int get hashCode =>
      (averageTransaction == null ? 0 : averageTransaction.hashCode) +
      categoryId.hashCode +
      categoryName.hashCode +
      chargedSales.hashCode +
      discountAmount.hashCode +
      excludedReceipts.hashCode +
      grossSales.hashCode +
      key.hashCode +
      name.hashCode +
      netQuantity.hashCode +
      netSales.hashCode +
      netTax.hashCode +
      productId.hashCode +
      refundAmount.hashCode +
      refundCount.hashCode +
      refundNet.hashCode +
      refundTax.hashCode +
      returnedQuantity.hashCode +
      saleCount.hashCode +
      saleTax.hashCode +
      salesAfterDiscount.hashCode +
      soldQuantity.hashCode +
      (unitPriceMax == null ? 0 : unitPriceMax.hashCode) +
      (unitPriceMin == null ? 0 : unitPriceMin.hashCode) +
      unknownCategoryQuantity.hashCode +
      valueAfterRefunds.hashCode +
      variantId.hashCode;

  factory GroupRow.fromJson(Map<String, dynamic> json) =>
      _$GroupRowFromJson(json);

  Map<String, dynamic> toJson() => _$GroupRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
