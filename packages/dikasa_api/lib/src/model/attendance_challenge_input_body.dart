//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_challenge_input_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceChallengeInputBody {
  /// Returns a new [AttendanceChallengeInputBody] instance.
  AttendanceChallengeInputBody({required this.action});

  @JsonKey(
    name: r'action',
    required: true,
    includeIfNull: false,
    unknownEnumValue:
        AttendanceChallengeInputBodyActionEnum.unknownDefaultOpenApi,
  )
  final AttendanceChallengeInputBodyActionEnum action;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceChallengeInputBody && other.action == action;

  @override
  int get hashCode => action.hashCode;

  factory AttendanceChallengeInputBody.fromJson(Map<String, dynamic> json) =>
      _$AttendanceChallengeInputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceChallengeInputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum AttendanceChallengeInputBodyActionEnum {
  @JsonValue(r'in')
  in_(r'in'),
  @JsonValue(r'out')
  out_(r'out'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const AttendanceChallengeInputBodyActionEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
