//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/closed_reconciliation.dart';
import 'package:dikasa_api/src/model/reconciliation_summary.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_record.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SessionRecord {
  /// Returns a new [SessionRecord] instance.
  SessionRecord({
    required this.canClose,

    this.closedAt,

    required this.closing,

    this.closingCash,

    required this.id,

    required this.openedAt,

    required this.openingCash,

    required this.openingUserName,

    required this.outletId,

    required this.reconciliationSupported,

    required this.status,

    required this.summary,

    this.unsupportedReason,

    required this.userId,
  });

  @JsonKey(name: r'can_close', required: true, includeIfNull: false)
  final bool canClose;

  @JsonKey(name: r'closed_at', required: false, includeIfNull: false)
  final DateTime? closedAt;

  @JsonKey(name: r'closing', required: true, includeIfNull: false)
  final ClosedReconciliation closing;

  @JsonKey(name: r'closing_cash', required: false, includeIfNull: false)
  final int? closingCash;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'opened_at', required: true, includeIfNull: false)
  final DateTime openedAt;

  @JsonKey(name: r'opening_cash', required: true, includeIfNull: false)
  final int openingCash;

  @JsonKey(name: r'opening_user_name', required: true, includeIfNull: false)
  final String openingUserName;

  @JsonKey(name: r'outlet_id', required: true, includeIfNull: false)
  final String outletId;

  @JsonKey(
    name: r'reconciliation_supported',
    required: true,
    includeIfNull: false,
  )
  final bool reconciliationSupported;

  @JsonKey(
    name: r'status',
    required: true,
    includeIfNull: false,
    unknownEnumValue: SessionRecordStatusEnum.unknownDefaultOpenApi,
  )
  final SessionRecordStatusEnum status;

  @JsonKey(name: r'summary', required: true, includeIfNull: false)
  final ReconciliationSummary summary;

  @JsonKey(name: r'unsupported_reason', required: false, includeIfNull: false)
  final String? unsupportedReason;

  @JsonKey(name: r'user_id', required: true, includeIfNull: false)
  final String userId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionRecord &&
          other.canClose == canClose &&
          other.closedAt == closedAt &&
          other.closing == closing &&
          other.closingCash == closingCash &&
          other.id == id &&
          other.openedAt == openedAt &&
          other.openingCash == openingCash &&
          other.openingUserName == openingUserName &&
          other.outletId == outletId &&
          other.reconciliationSupported == reconciliationSupported &&
          other.status == status &&
          other.summary == summary &&
          other.unsupportedReason == unsupportedReason &&
          other.userId == userId;

  @override
  int get hashCode =>
      canClose.hashCode +
      closedAt.hashCode +
      closing.hashCode +
      closingCash.hashCode +
      id.hashCode +
      openedAt.hashCode +
      openingCash.hashCode +
      openingUserName.hashCode +
      outletId.hashCode +
      reconciliationSupported.hashCode +
      status.hashCode +
      summary.hashCode +
      unsupportedReason.hashCode +
      userId.hashCode;

  factory SessionRecord.fromJson(Map<String, dynamic> json) =>
      _$SessionRecordFromJson(json);

  Map<String, dynamic> toJson() => _$SessionRecordToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum SessionRecordStatusEnum {
  @JsonValue(r'open')
  open(r'open'),
  @JsonValue(r'closed')
  closed(r'closed'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const SessionRecordStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
