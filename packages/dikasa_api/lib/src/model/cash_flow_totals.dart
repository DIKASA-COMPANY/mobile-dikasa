//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_flow_totals.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CashFlowTotals {
  /// Returns a new [CashFlowTotals] instance.
  CashFlowTotals({
    required this.cashIn,

    required this.cashOut,

    required this.cashRefunds,

    required this.cashSales,

    required this.expectedCash,

    required this.movementCount,

    required this.opening,

    required this.totalIn,

    required this.totalOut,
  });

  @JsonKey(name: r'cash_in', required: true, includeIfNull: false)
  final int cashIn;

  @JsonKey(name: r'cash_out', required: true, includeIfNull: false)
  final int cashOut;

  @JsonKey(name: r'cash_refunds', required: true, includeIfNull: false)
  final int cashRefunds;

  @JsonKey(name: r'cash_sales', required: true, includeIfNull: false)
  final int cashSales;

  @JsonKey(name: r'expected_cash', required: true, includeIfNull: false)
  final int expectedCash;

  @JsonKey(name: r'movement_count', required: true, includeIfNull: false)
  final int movementCount;

  @JsonKey(name: r'opening', required: true, includeIfNull: false)
  final int opening;

  @JsonKey(name: r'total_in', required: true, includeIfNull: false)
  final int totalIn;

  @JsonKey(name: r'total_out', required: true, includeIfNull: false)
  final int totalOut;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CashFlowTotals &&
          other.cashIn == cashIn &&
          other.cashOut == cashOut &&
          other.cashRefunds == cashRefunds &&
          other.cashSales == cashSales &&
          other.expectedCash == expectedCash &&
          other.movementCount == movementCount &&
          other.opening == opening &&
          other.totalIn == totalIn &&
          other.totalOut == totalOut;

  @override
  int get hashCode =>
      cashIn.hashCode +
      cashOut.hashCode +
      cashRefunds.hashCode +
      cashSales.hashCode +
      expectedCash.hashCode +
      movementCount.hashCode +
      opening.hashCode +
      totalIn.hashCode +
      totalOut.hashCode;

  factory CashFlowTotals.fromJson(Map<String, dynamic> json) =>
      _$CashFlowTotalsFromJson(json);

  Map<String, dynamic> toJson() => _$CashFlowTotalsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
