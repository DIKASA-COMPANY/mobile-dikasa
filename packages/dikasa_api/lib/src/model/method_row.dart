//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'method_row.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MethodRow {
  /// Returns a new [MethodRow] instance.
  MethodRow({
    required this.method,

    required this.netAmount,

    required this.refundAmount,

    required this.refundCount,

    required this.saleCount,

    required this.salesAmount,
  });

  @JsonKey(name: r'method', required: true, includeIfNull: false)
  final String method;

  @JsonKey(name: r'net_amount', required: true, includeIfNull: false)
  final int netAmount;

  @JsonKey(name: r'refund_amount', required: true, includeIfNull: false)
  final int refundAmount;

  @JsonKey(name: r'refund_count', required: true, includeIfNull: false)
  final int refundCount;

  @JsonKey(name: r'sale_count', required: true, includeIfNull: false)
  final int saleCount;

  @JsonKey(name: r'sales_amount', required: true, includeIfNull: false)
  final int salesAmount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MethodRow &&
          other.method == method &&
          other.netAmount == netAmount &&
          other.refundAmount == refundAmount &&
          other.refundCount == refundCount &&
          other.saleCount == saleCount &&
          other.salesAmount == salesAmount;

  @override
  int get hashCode =>
      method.hashCode +
      netAmount.hashCode +
      refundAmount.hashCode +
      refundCount.hashCode +
      saleCount.hashCode +
      salesAmount.hashCode;

  factory MethodRow.fromJson(Map<String, dynamic> json) =>
      _$MethodRowFromJson(json);

  Map<String, dynamic> toJson() => _$MethodRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
