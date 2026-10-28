//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_activity_event.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CashActivityEvent {
  /// Returns a new [CashActivityEvent] instance.
  CashActivityEvent({
    required this.amount,

    required this.createdBy,

    required this.createdByName,

    required this.direction,

    required this.id,

    required this.kind,

    required this.name,

    required this.occurredAt,

    required this.reason,

    required this.reversesId,

    required this.sourceId,
  });

  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final int amount;

  @JsonKey(name: r'created_by', required: true, includeIfNull: false)
  final String createdBy;

  @JsonKey(name: r'created_by_name', required: true, includeIfNull: false)
  final String createdByName;

  @JsonKey(name: r'direction', required: true, includeIfNull: false)
  final String direction;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'kind', required: true, includeIfNull: false)
  final String kind;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'occurred_at', required: true, includeIfNull: false)
  final DateTime occurredAt;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'reverses_id', required: true, includeIfNull: true)
  final String? reversesId;

  @JsonKey(name: r'source_id', required: true, includeIfNull: false)
  final String sourceId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CashActivityEvent &&
          other.amount == amount &&
          other.createdBy == createdBy &&
          other.createdByName == createdByName &&
          other.direction == direction &&
          other.id == id &&
          other.kind == kind &&
          other.name == name &&
          other.occurredAt == occurredAt &&
          other.reason == reason &&
          other.reversesId == reversesId &&
          other.sourceId == sourceId;

  @override
  int get hashCode =>
      amount.hashCode +
      createdBy.hashCode +
      createdByName.hashCode +
      direction.hashCode +
      id.hashCode +
      kind.hashCode +
      name.hashCode +
      occurredAt.hashCode +
      reason.hashCode +
      (reversesId == null ? 0 : reversesId.hashCode) +
      sourceId.hashCode;

  factory CashActivityEvent.fromJson(Map<String, dynamic> json) =>
      _$CashActivityEventFromJson(json);

  Map<String, dynamic> toJson() => _$CashActivityEventToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
