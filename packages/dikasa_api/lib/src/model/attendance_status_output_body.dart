//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/attendance_record.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_status_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceStatusOutputBody {
  /// Returns a new [AttendanceStatusOutputBody] instance.
  AttendanceStatusOutputBody({this.data, required this.serverTime});

  @JsonKey(name: r'data', required: false, includeIfNull: false)
  final AttendanceRecord? data;

  @JsonKey(name: r'server_time', required: true, includeIfNull: false)
  final DateTime serverTime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceStatusOutputBody &&
          other.data == data &&
          other.serverTime == serverTime;

  @override
  int get hashCode => data.hashCode + serverTime.hashCode;

  factory AttendanceStatusOutputBody.fromJson(Map<String, dynamic> json) =>
      _$AttendanceStatusOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceStatusOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
