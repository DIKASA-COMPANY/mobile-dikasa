//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_point.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DailyPoint {
  /// Returns a new [DailyPoint] instance.
  DailyPoint({
    required this.chargedSales,

    required this.date,

    required this.netSales,

    required this.refundAmount,

    required this.saleCount,
  });

  @JsonKey(name: r'charged_sales', required: true, includeIfNull: false)
  final int chargedSales;

  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'net_sales', required: true, includeIfNull: false)
  final int netSales;

  @JsonKey(name: r'refund_amount', required: true, includeIfNull: false)
  final int refundAmount;

  @JsonKey(name: r'sale_count', required: true, includeIfNull: false)
  final int saleCount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyPoint &&
          other.chargedSales == chargedSales &&
          other.date == date &&
          other.netSales == netSales &&
          other.refundAmount == refundAmount &&
          other.saleCount == saleCount;

  @override
  int get hashCode =>
      chargedSales.hashCode +
      date.hashCode +
      netSales.hashCode +
      refundAmount.hashCode +
      saleCount.hashCode;

  factory DailyPoint.fromJson(Map<String, dynamic> json) =>
      _$DailyPointFromJson(json);

  Map<String, dynamic> toJson() => _$DailyPointToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
