//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'method_summary.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MethodSummary {
  /// Returns a new [MethodSummary] instance.
  MethodSummary({
    required this.method,

    required this.refundCount,

    required this.refundsAmount,

    required this.saleCount,

    required this.salesAmount,
  });

  @JsonKey(name: r'method', required: true, includeIfNull: false)
  final String method;

  @JsonKey(name: r'refund_count', required: true, includeIfNull: false)
  final int refundCount;

  @JsonKey(name: r'refunds_amount', required: true, includeIfNull: false)
  final int refundsAmount;

  @JsonKey(name: r'sale_count', required: true, includeIfNull: false)
  final int saleCount;

  @JsonKey(name: r'sales_amount', required: true, includeIfNull: false)
  final int salesAmount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MethodSummary &&
          other.method == method &&
          other.refundCount == refundCount &&
          other.refundsAmount == refundsAmount &&
          other.saleCount == saleCount &&
          other.salesAmount == salesAmount;

  @override
  int get hashCode =>
      method.hashCode +
      refundCount.hashCode +
      refundsAmount.hashCode +
      saleCount.hashCode +
      salesAmount.hashCode;

  factory MethodSummary.fromJson(Map<String, dynamic> json) =>
      _$MethodSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$MethodSummaryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
