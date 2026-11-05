//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/attendance_record.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_history_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceHistoryOutputBody {
  /// Returns a new [AttendanceHistoryOutputBody] instance.
  AttendanceHistoryOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<AttendanceRecord>? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceHistoryOutputBody && other.data == data;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode);

  factory AttendanceHistoryOutputBody.fromJson(Map<String, dynamic> json) =>
      _$AttendanceHistoryOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceHistoryOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
