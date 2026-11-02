//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/refund_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refund.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Refund {
  /// Returns a new [Refund] instance.
  Refund({
    required this.actorId,

    required this.actorName,

    required this.cashSessionId,

    required this.createdAt,

    required this.id,

    required this.items,

    required this.method,

    required this.mode,

    required this.netAmount,

    required this.reason,

    required this.refundNumber,

    required this.requestId,

    required this.taxAmount,

    required this.totalAmount,

    required this.transactionId,
  });

  @JsonKey(name: r'actor_id', required: true, includeIfNull: false)
  final String actorId;

  @JsonKey(name: r'actor_name', required: true, includeIfNull: false)
  final String actorName;

  @JsonKey(name: r'cash_session_id', required: true, includeIfNull: false)
  final String cashSessionId;

  @JsonKey(name: r'created_at', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'items', required: true, includeIfNull: true)
  final List<RefundItem>? items;

  @JsonKey(name: r'method', required: true, includeIfNull: false)
  final String method;

  @JsonKey(name: r'mode', required: true, includeIfNull: false)
  final String mode;

  @JsonKey(name: r'net_amount', required: true, includeIfNull: false)
  final int netAmount;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'refund_number', required: true, includeIfNull: false)
  final String refundNumber;

  @JsonKey(name: r'request_id', required: true, includeIfNull: false)
  final String requestId;

  @JsonKey(name: r'tax_amount', required: true, includeIfNull: false)
  final int taxAmount;

  @JsonKey(name: r'total_amount', required: true, includeIfNull: false)
  final int totalAmount;

  @JsonKey(name: r'transaction_id', required: true, includeIfNull: false)
  final String transactionId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Refund &&
          other.actorId == actorId &&
          other.actorName == actorName &&
          other.cashSessionId == cashSessionId &&
          other.createdAt == createdAt &&
          other.id == id &&
          other.items == items &&
          other.method == method &&
          other.mode == mode &&
          other.netAmount == netAmount &&
          other.reason == reason &&
          other.refundNumber == refundNumber &&
          other.requestId == requestId &&
          other.taxAmount == taxAmount &&
          other.totalAmount == totalAmount &&
          other.transactionId == transactionId;

  @override
  int get hashCode =>
      actorId.hashCode +
      actorName.hashCode +
      cashSessionId.hashCode +
      createdAt.hashCode +
      id.hashCode +
      (items == null ? 0 : items.hashCode) +
      method.hashCode +
      mode.hashCode +
      netAmount.hashCode +
      reason.hashCode +
      refundNumber.hashCode +
      requestId.hashCode +
      taxAmount.hashCode +
      totalAmount.hashCode +
      transactionId.hashCode;

  factory Refund.fromJson(Map<String, dynamic> json) => _$RefundFromJson(json);

  Map<String, dynamic> toJson() => _$RefundToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
