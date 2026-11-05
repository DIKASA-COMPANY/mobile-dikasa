//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_pin_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendancePINRequest {
  /// Returns a new [AttendancePINRequest] instance.
  AttendancePINRequest({
    required this.action,

    required this.employeeId,

    required this.pin,
  });

  @JsonKey(
    name: r'action',
    required: true,
    includeIfNull: false,
    unknownEnumValue: AttendancePINRequestActionEnum.unknownDefaultOpenApi,
  )
  final AttendancePINRequestActionEnum action;

  @JsonKey(name: r'employee_id', required: true, includeIfNull: false)
  final String employeeId;

  @JsonKey(name: r'pin', required: true, includeIfNull: false)
  final String pin;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendancePINRequest &&
          other.action == action &&
          other.employeeId == employeeId &&
          other.pin == pin;

  @override
  int get hashCode => action.hashCode + employeeId.hashCode + pin.hashCode;

  factory AttendancePINRequest.fromJson(Map<String, dynamic> json) =>
      _$AttendancePINRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AttendancePINRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum AttendancePINRequestActionEnum {
  @JsonValue(r'in')
  in_(r'in'),
  @JsonValue(r'out')
  out_(r'out'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const AttendancePINRequestActionEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
