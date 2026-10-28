//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_movement.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StockMovement {
  /// Returns a new [StockMovement] instance.
  StockMovement({
    required this.balanceAfter,

    required this.createdAt,

    required this.createdBy,

    required this.id,

    required this.kind,

    required this.lowStockThreshold,

    required this.productId,

    required this.quantityDelta,

    required this.reason,

    this.refundId,

    this.requestId,

    required this.trackStock,

    this.transactionId,
  });

  @JsonKey(name: r'balance_after', required: true, includeIfNull: false)
  final int balanceAfter;

  @JsonKey(name: r'created_at', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'created_by', required: true, includeIfNull: false)
  final String createdBy;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'kind', required: true, includeIfNull: false)
  final String kind;

  @JsonKey(name: r'low_stock_threshold', required: true, includeIfNull: false)
  final int lowStockThreshold;

  @JsonKey(name: r'product_id', required: true, includeIfNull: false)
  final String productId;

  @JsonKey(name: r'quantity_delta', required: true, includeIfNull: false)
  final int quantityDelta;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'refund_id', required: false, includeIfNull: false)
  final String? refundId;

  @JsonKey(name: r'request_id', required: false, includeIfNull: false)
  final String? requestId;

  @JsonKey(name: r'track_stock', required: true, includeIfNull: false)
  final bool trackStock;

  @JsonKey(name: r'transaction_id', required: false, includeIfNull: false)
  final String? transactionId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockMovement &&
          other.balanceAfter == balanceAfter &&
          other.createdAt == createdAt &&
          other.createdBy == createdBy &&
          other.id == id &&
          other.kind == kind &&
          other.lowStockThreshold == lowStockThreshold &&
          other.productId == productId &&
          other.quantityDelta == quantityDelta &&
          other.reason == reason &&
          other.refundId == refundId &&
          other.requestId == requestId &&
          other.trackStock == trackStock &&
          other.transactionId == transactionId;

  @override
  int get hashCode =>
      balanceAfter.hashCode +
      createdAt.hashCode +
      createdBy.hashCode +
      id.hashCode +
      kind.hashCode +
      lowStockThreshold.hashCode +
      productId.hashCode +
      quantityDelta.hashCode +
      reason.hashCode +
      refundId.hashCode +
      requestId.hashCode +
      trackStock.hashCode +
      transactionId.hashCode;

  factory StockMovement.fromJson(Map<String, dynamic> json) =>
      _$StockMovementFromJson(json);

  Map<String, dynamic> toJson() => _$StockMovementToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
