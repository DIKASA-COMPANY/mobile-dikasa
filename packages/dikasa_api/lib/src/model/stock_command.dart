//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_command.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StockCommand {
  /// Returns a new [StockCommand] instance.
  StockCommand({
    this.initialQuantity,

    this.lowStockThreshold,

    this.quantityDelta,

    required this.reason,

    required this.requestId,

    this.trackStock,
  });

  // minimum: 0
  // maximum: 1000000000
  @JsonKey(name: r'initial_quantity', required: false, includeIfNull: false)
  final int? initialQuantity;

  // minimum: 0
  // maximum: 1000000000
  @JsonKey(name: r'low_stock_threshold', required: false, includeIfNull: false)
  final int? lowStockThreshold;

  // minimum: -1000000000
  // maximum: 1000000000
  @JsonKey(name: r'quantity_delta', required: false, includeIfNull: false)
  final int? quantityDelta;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'request_id', required: true, includeIfNull: false)
  final String requestId;

  @JsonKey(name: r'track_stock', required: false, includeIfNull: false)
  final bool? trackStock;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockCommand &&
          other.initialQuantity == initialQuantity &&
          other.lowStockThreshold == lowStockThreshold &&
          other.quantityDelta == quantityDelta &&
          other.reason == reason &&
          other.requestId == requestId &&
          other.trackStock == trackStock;

  @override
  int get hashCode =>
      initialQuantity.hashCode +
      lowStockThreshold.hashCode +
      quantityDelta.hashCode +
      reason.hashCode +
      requestId.hashCode +
      trackStock.hashCode;

  factory StockCommand.fromJson(Map<String, dynamic> json) =>
      _$StockCommandFromJson(json);

  Map<String, dynamic> toJson() => _$StockCommandToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
