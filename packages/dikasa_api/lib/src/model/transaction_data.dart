//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/transaction_item_data.dart';
import 'package:dikasa_api/src/model/wallet_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TransactionData {
  /// Returns a new [TransactionData] instance.
  TransactionData({
    required this.cashSessionId,

    required this.changeAmount,

    required this.discountAmount,

    required this.id,

    required this.items,

    required this.orderTypeId,

    required this.paidAmount,

    required this.paidAt,

    required this.paymentMethod,

    this.restaurantTableId,

    required this.roundingAmount,

    required this.status,

    required this.subtotal,

    required this.taxAmount,

    required this.taxPercentage,

    required this.tipAmount,

    required this.totalAmount,

    required this.totalQuantity,

    required this.transactionNumber,

    this.wallet,
  });

  @JsonKey(name: r'cash_session_id', required: true, includeIfNull: false)
  final String cashSessionId;

  @JsonKey(name: r'change_amount', required: true, includeIfNull: false)
  final int changeAmount;

  @JsonKey(name: r'discount_amount', required: true, includeIfNull: false)
  final int discountAmount;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'items', required: true, includeIfNull: true)
  final List<TransactionItemData>? items;

  @JsonKey(name: r'order_type_id', required: true, includeIfNull: false)
  final String orderTypeId;

  @JsonKey(name: r'paid_amount', required: true, includeIfNull: false)
  final int paidAmount;

  @JsonKey(name: r'paid_at', required: true, includeIfNull: false)
  final DateTime paidAt;

  @JsonKey(name: r'payment_method', required: true, includeIfNull: false)
  final String paymentMethod;

  @JsonKey(name: r'restaurant_table_id', required: false, includeIfNull: false)
  final String? restaurantTableId;

  @JsonKey(name: r'rounding_amount', required: true, includeIfNull: false)
  final int roundingAmount;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final String status;

  @JsonKey(name: r'subtotal', required: true, includeIfNull: false)
  final int subtotal;

  @JsonKey(name: r'tax_amount', required: true, includeIfNull: false)
  final int taxAmount;

  @JsonKey(name: r'tax_percentage', required: true, includeIfNull: false)
  final double taxPercentage;

  @JsonKey(name: r'tip_amount', required: true, includeIfNull: false)
  final int tipAmount;

  @JsonKey(name: r'total_amount', required: true, includeIfNull: false)
  final int totalAmount;

  @JsonKey(name: r'total_quantity', required: true, includeIfNull: false)
  final int totalQuantity;

  @JsonKey(name: r'transaction_number', required: true, includeIfNull: false)
  final String transactionNumber;

  @JsonKey(name: r'wallet', required: false, includeIfNull: false)
  final WalletData? wallet;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionData &&
          other.cashSessionId == cashSessionId &&
          other.changeAmount == changeAmount &&
          other.discountAmount == discountAmount &&
          other.id == id &&
          other.items == items &&
          other.orderTypeId == orderTypeId &&
          other.paidAmount == paidAmount &&
          other.paidAt == paidAt &&
          other.paymentMethod == paymentMethod &&
          other.restaurantTableId == restaurantTableId &&
          other.roundingAmount == roundingAmount &&
          other.status == status &&
          other.subtotal == subtotal &&
          other.taxAmount == taxAmount &&
          other.taxPercentage == taxPercentage &&
          other.tipAmount == tipAmount &&
          other.totalAmount == totalAmount &&
          other.totalQuantity == totalQuantity &&
          other.transactionNumber == transactionNumber &&
          other.wallet == wallet;

  @override
  int get hashCode =>
      cashSessionId.hashCode +
      changeAmount.hashCode +
      discountAmount.hashCode +
      id.hashCode +
      (items == null ? 0 : items.hashCode) +
      orderTypeId.hashCode +
      paidAmount.hashCode +
      paidAt.hashCode +
      paymentMethod.hashCode +
      restaurantTableId.hashCode +
      roundingAmount.hashCode +
      status.hashCode +
      subtotal.hashCode +
      taxAmount.hashCode +
      taxPercentage.hashCode +
      tipAmount.hashCode +
      totalAmount.hashCode +
      totalQuantity.hashCode +
      transactionNumber.hashCode +
      wallet.hashCode;

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      _$TransactionDataFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
