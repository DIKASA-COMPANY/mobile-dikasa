//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/refund_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'preview.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Preview {
  /// Returns a new [Preview] instance.
  Preview({
    required this.items,

    required this.netAmount,

    required this.previewHash,

    required this.refundRevision,

    required this.resultStatus,

    required this.taxAmount,

    required this.totalAmount,

    required this.transactionId,
  });

  @JsonKey(name: r'items', required: true, includeIfNull: true)
  final List<RefundItem>? items;

  @JsonKey(name: r'net_amount', required: true, includeIfNull: false)
  final int netAmount;

  @JsonKey(name: r'preview_hash', required: true, includeIfNull: false)
  final String previewHash;

  @JsonKey(name: r'refund_revision', required: true, includeIfNull: false)
  final int refundRevision;

  @JsonKey(name: r'result_status', required: true, includeIfNull: false)
  final String resultStatus;

  @JsonKey(name: r'tax_amount', required: true, includeIfNull: false)
  final int taxAmount;

  @JsonKey(name: r'total_amount', required: true, includeIfNull: false)
  final int totalAmount;

  @JsonKey(name: r'transaction_id', required: true, includeIfNull: false)
  final String transactionId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Preview &&
          other.items == items &&
          other.netAmount == netAmount &&
          other.previewHash == previewHash &&
          other.refundRevision == refundRevision &&
          other.resultStatus == resultStatus &&
          other.taxAmount == taxAmount &&
          other.totalAmount == totalAmount &&
          other.transactionId == transactionId;

  @override
  int get hashCode =>
      (items == null ? 0 : items.hashCode) +
      netAmount.hashCode +
      previewHash.hashCode +
      refundRevision.hashCode +
      resultStatus.hashCode +
      taxAmount.hashCode +
      totalAmount.hashCode +
      transactionId.hashCode;

  factory Preview.fromJson(Map<String, dynamic> json) =>
      _$PreviewFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
