//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/transaction_item_request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TransactionRequest {
  /// Returns a new [TransactionRequest] instance.
  TransactionRequest({
    required this.changeAmount,

    required this.discountAmount,

    required this.items,

    required this.orderTypeId,

    required this.paidAmount,

    required this.paymentMethod,

    this.restaurantTableId,

    required this.roundingAmount,

    required this.subtotal,

    required this.taxAmount,

    required this.taxPercentage,

    required this.tipAmount,

    required this.totalAmount,

    this.walletId,
  });

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'change_amount', required: true, includeIfNull: false)
  final int changeAmount;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'discount_amount', required: true, includeIfNull: false)
  final int discountAmount;

  @JsonKey(name: r'items', required: true, includeIfNull: true)
  final List<TransactionItemRequest>? items;

  @JsonKey(name: r'order_type_id', required: true, includeIfNull: false)
  final String orderTypeId;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'paid_amount', required: true, includeIfNull: false)
  final int paidAmount;

  @JsonKey(
    name: r'payment_method',
    required: true,
    includeIfNull: false,
    unknownEnumValue: TransactionRequestPaymentMethodEnum.unknownDefaultOpenApi,
  )
  final TransactionRequestPaymentMethodEnum paymentMethod;

  @JsonKey(name: r'restaurant_table_id', required: false, includeIfNull: false)
  final String? restaurantTableId;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'rounding_amount', required: true, includeIfNull: false)
  final int roundingAmount;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'subtotal', required: true, includeIfNull: false)
  final int subtotal;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'tax_amount', required: true, includeIfNull: false)
  final int taxAmount;

  // minimum: 0
  // maximum: 100
  @JsonKey(name: r'tax_percentage', required: true, includeIfNull: false)
  final double taxPercentage;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'tip_amount', required: true, includeIfNull: false)
  final int tipAmount;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'total_amount', required: true, includeIfNull: false)
  final int totalAmount;

  @JsonKey(name: r'wallet_id', required: false, includeIfNull: false)
  final String? walletId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionRequest &&
          other.changeAmount == changeAmount &&
          other.discountAmount == discountAmount &&
          other.items == items &&
          other.orderTypeId == orderTypeId &&
          other.paidAmount == paidAmount &&
          other.paymentMethod == paymentMethod &&
          other.restaurantTableId == restaurantTableId &&
          other.roundingAmount == roundingAmount &&
          other.subtotal == subtotal &&
          other.taxAmount == taxAmount &&
          other.taxPercentage == taxPercentage &&
          other.tipAmount == tipAmount &&
          other.totalAmount == totalAmount &&
          other.walletId == walletId;

  @override
  int get hashCode =>
      changeAmount.hashCode +
      discountAmount.hashCode +
      (items == null ? 0 : items.hashCode) +
      orderTypeId.hashCode +
      paidAmount.hashCode +
      paymentMethod.hashCode +
      restaurantTableId.hashCode +
      roundingAmount.hashCode +
      subtotal.hashCode +
      taxAmount.hashCode +
      taxPercentage.hashCode +
      tipAmount.hashCode +
      totalAmount.hashCode +
      walletId.hashCode;

  factory TransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$TransactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum TransactionRequestPaymentMethodEnum {
  @JsonValue(r'cash')
  cash(r'cash'),
  @JsonValue(r'wallet')
  wallet(r'wallet'),
  @JsonValue(r'debit_card')
  debitCard(r'debit_card'),
  @JsonValue(r'qris')
  qris(r'qris'),
  @JsonValue(r'point')
  point(r'point'),
  @JsonValue(r'transfer')
  transfer(r'transfer'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const TransactionRequestPaymentMethodEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
