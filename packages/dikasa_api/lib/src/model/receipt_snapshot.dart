//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/receipt_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receipt_snapshot.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReceiptSnapshot {
  /// Returns a new [ReceiptSnapshot] instance.
  ReceiptSnapshot({
    required this.discountAmount,

    required this.id,

    required this.items,

    required this.paymentMethod,

    required this.refundRevision,

    required this.refundedAmount,

    required this.refundsSupported,

    required this.status,

    required this.subtotal,

    required this.taxAmount,

    required this.totalAmount,

    required this.transactionNumber,
  });

  @JsonKey(name: r'discount_amount', required: true, includeIfNull: false)
  final int discountAmount;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'items', required: true, includeIfNull: true)
  final List<ReceiptItem>? items;

  @JsonKey(name: r'payment_method', required: true, includeIfNull: false)
  final String paymentMethod;

  @JsonKey(name: r'refund_revision', required: true, includeIfNull: false)
  final int refundRevision;

  @JsonKey(name: r'refunded_amount', required: true, includeIfNull: false)
  final int refundedAmount;

  @JsonKey(name: r'refunds_supported', required: true, includeIfNull: false)
  final bool refundsSupported;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final String status;

  @JsonKey(name: r'subtotal', required: true, includeIfNull: false)
  final int subtotal;

  @JsonKey(name: r'tax_amount', required: true, includeIfNull: false)
  final int taxAmount;

  @JsonKey(name: r'total_amount', required: true, includeIfNull: false)
  final int totalAmount;

  @JsonKey(name: r'transaction_number', required: true, includeIfNull: false)
  final String transactionNumber;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReceiptSnapshot &&
          other.discountAmount == discountAmount &&
          other.id == id &&
          other.items == items &&
          other.paymentMethod == paymentMethod &&
          other.refundRevision == refundRevision &&
          other.refundedAmount == refundedAmount &&
          other.refundsSupported == refundsSupported &&
          other.status == status &&
          other.subtotal == subtotal &&
          other.taxAmount == taxAmount &&
          other.totalAmount == totalAmount &&
          other.transactionNumber == transactionNumber;

  @override
  int get hashCode =>
      discountAmount.hashCode +
      id.hashCode +
      (items == null ? 0 : items.hashCode) +
      paymentMethod.hashCode +
      refundRevision.hashCode +
      refundedAmount.hashCode +
      refundsSupported.hashCode +
      status.hashCode +
      subtotal.hashCode +
      taxAmount.hashCode +
      totalAmount.hashCode +
      transactionNumber.hashCode;

  factory ReceiptSnapshot.fromJson(Map<String, dynamic> json) =>
      _$ReceiptSnapshotFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptSnapshotToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
