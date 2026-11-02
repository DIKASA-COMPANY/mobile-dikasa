//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/reconciliation_summary.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'closed_reconciliation.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ClosedReconciliation {
  /// Returns a new [ClosedReconciliation] instance.
  ClosedReconciliation({
    required this.closeRequestId,

    required this.closedAt,

    required this.closedBy,

    required this.closedByName,

    required this.countedCash,

    required this.difference,

    required this.previewHash,

    required this.reason,

    required this.sessionId,

    required this.summary,
  });

  @JsonKey(name: r'close_request_id', required: true, includeIfNull: false)
  final String closeRequestId;

  @JsonKey(name: r'closed_at', required: true, includeIfNull: false)
  final DateTime closedAt;

  @JsonKey(name: r'closed_by', required: true, includeIfNull: false)
  final String closedBy;

  @JsonKey(name: r'closed_by_name', required: true, includeIfNull: false)
  final String closedByName;

  @JsonKey(name: r'counted_cash', required: true, includeIfNull: false)
  final int countedCash;

  @JsonKey(name: r'difference', required: true, includeIfNull: false)
  final int difference;

  @JsonKey(name: r'preview_hash', required: true, includeIfNull: false)
  final String previewHash;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'session_id', required: true, includeIfNull: false)
  final String sessionId;

  @JsonKey(name: r'summary', required: true, includeIfNull: false)
  final ReconciliationSummary summary;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClosedReconciliation &&
          other.closeRequestId == closeRequestId &&
          other.closedAt == closedAt &&
          other.closedBy == closedBy &&
          other.closedByName == closedByName &&
          other.countedCash == countedCash &&
          other.difference == difference &&
          other.previewHash == previewHash &&
          other.reason == reason &&
          other.sessionId == sessionId &&
          other.summary == summary;

  @override
  int get hashCode =>
      closeRequestId.hashCode +
      closedAt.hashCode +
      closedBy.hashCode +
      closedByName.hashCode +
      countedCash.hashCode +
      difference.hashCode +
      previewHash.hashCode +
      reason.hashCode +
      sessionId.hashCode +
      summary.hashCode;

  factory ClosedReconciliation.fromJson(Map<String, dynamic> json) =>
      _$ClosedReconciliationFromJson(json);

  Map<String, dynamic> toJson() => _$ClosedReconciliationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
