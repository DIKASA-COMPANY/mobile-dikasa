//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_employee.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceEmployee {
  /// Returns a new [AttendanceEmployee] instance.
  AttendanceEmployee({
    required this.fingerprintEnrolled,

    required this.hasPin,

    required this.id,

    required this.name,
  });

  @JsonKey(name: r'fingerprint_enrolled', required: true, includeIfNull: false)
  final bool fingerprintEnrolled;

  @JsonKey(name: r'has_pin', required: true, includeIfNull: false)
  final bool hasPin;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceEmployee &&
          other.fingerprintEnrolled == fingerprintEnrolled &&
          other.hasPin == hasPin &&
          other.id == id &&
          other.name == name;

  @override
  int get hashCode =>
      fingerprintEnrolled.hashCode +
      hasPin.hashCode +
      id.hashCode +
      name.hashCode;

  factory AttendanceEmployee.fromJson(Map<String, dynamic> json) =>
      _$AttendanceEmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceEmployeeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
