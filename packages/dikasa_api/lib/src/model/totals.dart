//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'totals.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Totals {
  /// Returns a new [Totals] instance.
  Totals({
    required this.averageTransaction,

    required this.chargedSales,

    required this.discountAmount,

    required this.excludedReceipts,

    required this.grossSales,

    required this.netQuantity,

    required this.netSales,

    required this.netTax,

    required this.refundAmount,

    required this.refundCount,

    required this.refundNet,

    required this.refundTax,

    required this.returnedQuantity,

    required this.saleCount,

    required this.saleTax,

    required this.salesAfterDiscount,

    required this.soldQuantity,

    required this.unknownCategoryQuantity,

    required this.valueAfterRefunds,
  });

  @JsonKey(name: r'average_transaction', required: true, includeIfNull: true)
  final int? averageTransaction;

  @JsonKey(name: r'charged_sales', required: true, includeIfNull: false)
  final int chargedSales;

  @JsonKey(name: r'discount_amount', required: true, includeIfNull: false)
  final int discountAmount;

  @JsonKey(name: r'excluded_receipts', required: true, includeIfNull: false)
  final int excludedReceipts;

  @JsonKey(name: r'gross_sales', required: true, includeIfNull: false)
  final int grossSales;

  @JsonKey(name: r'net_quantity', required: true, includeIfNull: false)
  final int netQuantity;

  @JsonKey(name: r'net_sales', required: true, includeIfNull: false)
  final int netSales;

  @JsonKey(name: r'net_tax', required: true, includeIfNull: false)
  final int netTax;

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

  @JsonKey(
    name: r'unknown_category_quantity',
    required: true,
    includeIfNull: false,
  )
  final int unknownCategoryQuantity;

  @JsonKey(name: r'value_after_refunds', required: true, includeIfNull: false)
  final int valueAfterRefunds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Totals &&
          other.averageTransaction == averageTransaction &&
          other.chargedSales == chargedSales &&
          other.discountAmount == discountAmount &&
          other.excludedReceipts == excludedReceipts &&
          other.grossSales == grossSales &&
          other.netQuantity == netQuantity &&
          other.netSales == netSales &&
          other.netTax == netTax &&
          other.refundAmount == refundAmount &&
          other.refundCount == refundCount &&
          other.refundNet == refundNet &&
          other.refundTax == refundTax &&
          other.returnedQuantity == returnedQuantity &&
          other.saleCount == saleCount &&
          other.saleTax == saleTax &&
          other.salesAfterDiscount == salesAfterDiscount &&
          other.soldQuantity == soldQuantity &&
          other.unknownCategoryQuantity == unknownCategoryQuantity &&
          other.valueAfterRefunds == valueAfterRefunds;

  @override
  int get hashCode =>
      (averageTransaction == null ? 0 : averageTransaction.hashCode) +
      chargedSales.hashCode +
      discountAmount.hashCode +
      excludedReceipts.hashCode +
      grossSales.hashCode +
      netQuantity.hashCode +
      netSales.hashCode +
      netTax.hashCode +
      refundAmount.hashCode +
      refundCount.hashCode +
      refundNet.hashCode +
      refundTax.hashCode +
      returnedQuantity.hashCode +
      saleCount.hashCode +
      saleTax.hashCode +
      salesAfterDiscount.hashCode +
      soldQuantity.hashCode +
      unknownCategoryQuantity.hashCode +
      valueAfterRefunds.hashCode;

  factory Totals.fromJson(Map<String, dynamic> json) => _$TotalsFromJson(json);

  Map<String, dynamic> toJson() => _$TotalsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
