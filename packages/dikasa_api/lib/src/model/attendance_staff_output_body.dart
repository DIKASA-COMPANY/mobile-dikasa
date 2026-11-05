//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/attendance_employee.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_staff_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceStaffOutputBody {
  /// Returns a new [AttendanceStaffOutputBody] instance.
  AttendanceStaffOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<AttendanceEmployee>? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceStaffOutputBody && other.data == data;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode);

  factory AttendanceStaffOutputBody.fromJson(Map<String, dynamic> json) =>
      _$AttendanceStaffOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceStaffOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
