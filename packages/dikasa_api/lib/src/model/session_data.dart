//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SessionData {
  /// Returns a new [SessionData] instance.
  SessionData({
    this.closedAt,

    this.closingCash,

    required this.id,

    required this.openedAt,

    required this.openingCash,

    required this.outletId,

    required this.status,

    required this.userId,
  });

  @JsonKey(name: r'closed_at', required: false, includeIfNull: false)
  final DateTime? closedAt;

  @JsonKey(name: r'closing_cash', required: false, includeIfNull: false)
  final int? closingCash;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'opened_at', required: true, includeIfNull: false)
  final DateTime openedAt;

  @JsonKey(name: r'opening_cash', required: true, includeIfNull: false)
  final int openingCash;

  @JsonKey(name: r'outlet_id', required: true, includeIfNull: false)
  final String outletId;

  @JsonKey(
    name: r'status',
    required: true,
    includeIfNull: false,
    unknownEnumValue: SessionDataStatusEnum.unknownDefaultOpenApi,
  )
  final SessionDataStatusEnum status;

  @JsonKey(name: r'user_id', required: true, includeIfNull: false)
  final String userId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionData &&
          other.closedAt == closedAt &&
          other.closingCash == closingCash &&
          other.id == id &&
          other.openedAt == openedAt &&
          other.openingCash == openingCash &&
          other.outletId == outletId &&
          other.status == status &&
          other.userId == userId;

  @override
  int get hashCode =>
      closedAt.hashCode +
      closingCash.hashCode +
      id.hashCode +
      openedAt.hashCode +
      openingCash.hashCode +
      outletId.hashCode +
      status.hashCode +
      userId.hashCode;

  factory SessionData.fromJson(Map<String, dynamic> json) =>
      _$SessionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum SessionDataStatusEnum {
  @JsonValue(r'open')
  open(r'open'),
  @JsonValue(r'closed')
  closed(r'closed'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const SessionDataStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
