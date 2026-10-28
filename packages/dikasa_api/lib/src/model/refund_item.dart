//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refund_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RefundItem {
  /// Returns a new [RefundItem] instance.
  RefundItem({
    required this.id,

    required this.netAmount,

    required this.quantity,

    required this.restockQuantity,

    required this.taxAmount,

    required this.totalAmount,

    required this.transactionItemId,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'net_amount', required: true, includeIfNull: false)
  final int netAmount;

  @JsonKey(name: r'quantity', required: true, includeIfNull: false)
  final int quantity;

  @JsonKey(name: r'restock_quantity', required: true, includeIfNull: false)
  final int restockQuantity;

  @JsonKey(name: r'tax_amount', required: true, includeIfNull: false)
  final int taxAmount;

  @JsonKey(name: r'total_amount', required: true, includeIfNull: false)
  final int totalAmount;

  @JsonKey(name: r'transaction_item_id', required: true, includeIfNull: false)
  final String transactionItemId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RefundItem &&
          other.id == id &&
          other.netAmount == netAmount &&
          other.quantity == quantity &&
          other.restockQuantity == restockQuantity &&
          other.taxAmount == taxAmount &&
          other.totalAmount == totalAmount &&
          other.transactionItemId == transactionItemId;

  @override
  int get hashCode =>
      id.hashCode +
      netAmount.hashCode +
      quantity.hashCode +
      restockQuantity.hashCode +
      taxAmount.hashCode +
      totalAmount.hashCode +
      transactionItemId.hashCode;

  factory RefundItem.fromJson(Map<String, dynamic> json) =>
      _$RefundItemFromJson(json);

  Map<String, dynamic> toJson() => _$RefundItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
