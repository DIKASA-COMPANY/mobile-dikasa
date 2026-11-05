//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/attendance_record.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceOutputBody {
  /// Returns a new [AttendanceOutputBody] instance.
  AttendanceOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final AttendanceRecord data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory AttendanceOutputBody.fromJson(Map<String, dynamic> json) =>
      _$AttendanceOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
