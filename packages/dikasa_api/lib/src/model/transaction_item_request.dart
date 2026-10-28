//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_item_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TransactionItemRequest {
  /// Returns a new [TransactionItemRequest] instance.
  TransactionItemRequest({
    required this.lineTotal,

    this.notes,

    required this.productId,

    required this.productName,

    this.productVariantId,

    required this.quantity,

    required this.unitPrice,

    this.variantName,
  });

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'line_total', required: true, includeIfNull: false)
  final int lineTotal;

  @JsonKey(name: r'notes', required: false, includeIfNull: false)
  final String? notes;

  @JsonKey(name: r'product_id', required: true, includeIfNull: false)
  final String productId;

  @JsonKey(name: r'product_name', required: true, includeIfNull: false)
  final String productName;

  @JsonKey(name: r'product_variant_id', required: false, includeIfNull: false)
  final String? productVariantId;

  // minimum: 1
  // maximum: 1000
  @JsonKey(name: r'quantity', required: true, includeIfNull: false)
  final int quantity;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'unit_price', required: true, includeIfNull: false)
  final int unitPrice;

  @JsonKey(name: r'variant_name', required: false, includeIfNull: false)
  final String? variantName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionItemRequest &&
          other.lineTotal == lineTotal &&
          other.notes == notes &&
          other.productId == productId &&
          other.productName == productName &&
          other.productVariantId == productVariantId &&
          other.quantity == quantity &&
          other.unitPrice == unitPrice &&
          other.variantName == variantName;

  @override
  int get hashCode =>
      lineTotal.hashCode +
      notes.hashCode +
      productId.hashCode +
      productName.hashCode +
      productVariantId.hashCode +
      quantity.hashCode +
      unitPrice.hashCode +
      variantName.hashCode;

  factory TransactionItemRequest.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionItemRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
