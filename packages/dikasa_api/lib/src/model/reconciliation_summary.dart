//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/method_summary.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reconciliation_summary.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReconciliationSummary {
  /// Returns a new [ReconciliationSummary] instance.
  ReconciliationSummary({
    required this.cashIn,

    required this.cashOut,

    required this.cashRefunds,

    required this.cashSales,

    required this.expectedCash,

    required this.methods,

    required this.movementCount,

    required this.openedAt,

    required this.openingCash,

    required this.openingUserId,

    required this.openingUserName,

    required this.refundCount,

    required this.saleCount,

    required this.sessionId,
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

  @JsonKey(name: r'methods', required: true, includeIfNull: true)
  final List<MethodSummary>? methods;

  @JsonKey(name: r'movement_count', required: true, includeIfNull: false)
  final int movementCount;

  @JsonKey(name: r'opened_at', required: true, includeIfNull: false)
  final DateTime openedAt;

  @JsonKey(name: r'opening_cash', required: true, includeIfNull: false)
  final int openingCash;

  @JsonKey(name: r'opening_user_id', required: true, includeIfNull: false)
  final String openingUserId;

  @JsonKey(name: r'opening_user_name', required: true, includeIfNull: false)
  final String openingUserName;

  @JsonKey(name: r'refund_count', required: true, includeIfNull: false)
  final int refundCount;

  @JsonKey(name: r'sale_count', required: true, includeIfNull: false)
  final int saleCount;

  @JsonKey(name: r'session_id', required: true, includeIfNull: false)
  final String sessionId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReconciliationSummary &&
          other.cashIn == cashIn &&
          other.cashOut == cashOut &&
          other.cashRefunds == cashRefunds &&
          other.cashSales == cashSales &&
          other.expectedCash == expectedCash &&
          other.methods == methods &&
          other.movementCount == movementCount &&
          other.openedAt == openedAt &&
          other.openingCash == openingCash &&
          other.openingUserId == openingUserId &&
          other.openingUserName == openingUserName &&
          other.refundCount == refundCount &&
          other.saleCount == saleCount &&
          other.sessionId == sessionId;

  @override
  int get hashCode =>
      cashIn.hashCode +
      cashOut.hashCode +
      cashRefunds.hashCode +
      cashSales.hashCode +
      expectedCash.hashCode +
      (methods == null ? 0 : methods.hashCode) +
      movementCount.hashCode +
      openedAt.hashCode +
      openingCash.hashCode +
      openingUserId.hashCode +
      openingUserName.hashCode +
      refundCount.hashCode +
      saleCount.hashCode +
      sessionId.hashCode;

  factory ReconciliationSummary.fromJson(Map<String, dynamic> json) =>
      _$ReconciliationSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$ReconciliationSummaryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
