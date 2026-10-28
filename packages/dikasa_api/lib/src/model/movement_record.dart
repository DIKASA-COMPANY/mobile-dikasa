//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movement_record.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MovementRecord {
  /// Returns a new [MovementRecord] instance.
  MovementRecord({
    required this.amount,

    required this.createdAt,

    required this.createdBy,

    required this.createdByName,

    required this.hasProof,

    required this.id,

    required this.kind,

    required this.name,

    required this.outletId,

    required this.reason,

    required this.requestId,

    required this.reversesId,

    required this.sessionId,
  });

  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final int amount;

  @JsonKey(name: r'created_at', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'created_by', required: true, includeIfNull: false)
  final String createdBy;

  @JsonKey(name: r'created_by_name', required: true, includeIfNull: false)
  final String createdByName;

  @JsonKey(name: r'has_proof', required: true, includeIfNull: false)
  final bool hasProof;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'kind', required: true, includeIfNull: false)
  final String kind;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'outlet_id', required: true, includeIfNull: false)
  final String outletId;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'request_id', required: true, includeIfNull: false)
  final String requestId;

  @JsonKey(name: r'reverses_id', required: true, includeIfNull: true)
  final String? reversesId;

  @JsonKey(name: r'session_id', required: true, includeIfNull: false)
  final String sessionId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovementRecord &&
          other.amount == amount &&
          other.createdAt == createdAt &&
          other.createdBy == createdBy &&
          other.createdByName == createdByName &&
          other.hasProof == hasProof &&
          other.id == id &&
          other.kind == kind &&
          other.name == name &&
          other.outletId == outletId &&
          other.reason == reason &&
          other.requestId == requestId &&
          other.reversesId == reversesId &&
          other.sessionId == sessionId;

  @override
  int get hashCode =>
      amount.hashCode +
      createdAt.hashCode +
      createdBy.hashCode +
      createdByName.hashCode +
      hasProof.hashCode +
      id.hashCode +
      kind.hashCode +
      name.hashCode +
      outletId.hashCode +
      reason.hashCode +
      requestId.hashCode +
      (reversesId == null ? 0 : reversesId.hashCode) +
      sessionId.hashCode;

  factory MovementRecord.fromJson(Map<String, dynamic> json) =>
      _$MovementRecordFromJson(json);

  Map<String, dynamic> toJson() => _$MovementRecordToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
