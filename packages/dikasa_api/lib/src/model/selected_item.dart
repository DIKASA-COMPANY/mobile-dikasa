//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'selected_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SelectedItem {
  /// Returns a new [SelectedItem] instance.
  SelectedItem({
    required this.quantity,

    required this.restockQuantity,

    required this.transactionItemId,
  });

  // minimum: 1
  // maximum: 1000
  @JsonKey(name: r'quantity', required: true, includeIfNull: false)
  final int quantity;

  // minimum: 0
  // maximum: 1000
  @JsonKey(name: r'restock_quantity', required: true, includeIfNull: false)
  final int restockQuantity;

  @JsonKey(name: r'transaction_item_id', required: true, includeIfNull: false)
  final String transactionItemId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedItem &&
          other.quantity == quantity &&
          other.restockQuantity == restockQuantity &&
          other.transactionItemId == transactionItemId;

  @override
  int get hashCode =>
      quantity.hashCode + restockQuantity.hashCode + transactionItemId.hashCode;

  factory SelectedItem.fromJson(Map<String, dynamic> json) =>
      _$SelectedItemFromJson(json);

  Map<String, dynamic> toJson() => _$SelectedItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
