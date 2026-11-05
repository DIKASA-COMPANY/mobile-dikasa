//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_record.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceRecord {
  /// Returns a new [AttendanceRecord] instance.
  AttendanceRecord({
    required this.clockIn,

    required this.clockOut,

    required this.createdBy,

    required this.employeeId,

    required this.employeeName,

    required this.id,

    required this.inMethod,

    required this.outMethod,

    required this.outletId,

    required this.updatedBy,

    required this.workDate,
  });

  @JsonKey(name: r'clock_in', required: true, includeIfNull: false)
  final DateTime clockIn;

  @JsonKey(name: r'clock_out', required: true, includeIfNull: true)
  final DateTime? clockOut;

  @JsonKey(name: r'created_by', required: true, includeIfNull: false)
  final String createdBy;

  @JsonKey(name: r'employee_id', required: true, includeIfNull: false)
  final String employeeId;

  @JsonKey(name: r'employee_name', required: true, includeIfNull: false)
  final String employeeName;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'in_method', required: true, includeIfNull: false)
  final String inMethod;

  @JsonKey(name: r'out_method', required: true, includeIfNull: true)
  final String? outMethod;

  @JsonKey(name: r'outlet_id', required: true, includeIfNull: false)
  final String outletId;

  @JsonKey(name: r'updated_by', required: true, includeIfNull: false)
  final String updatedBy;

  @JsonKey(name: r'work_date', required: true, includeIfNull: false)
  final String workDate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceRecord &&
          other.clockIn == clockIn &&
          other.clockOut == clockOut &&
          other.createdBy == createdBy &&
          other.employeeId == employeeId &&
          other.employeeName == employeeName &&
          other.id == id &&
          other.inMethod == inMethod &&
          other.outMethod == outMethod &&
          other.outletId == outletId &&
          other.updatedBy == updatedBy &&
          other.workDate == workDate;

  @override
  int get hashCode =>
      clockIn.hashCode +
      (clockOut == null ? 0 : clockOut.hashCode) +
      createdBy.hashCode +
      employeeId.hashCode +
      employeeName.hashCode +
      id.hashCode +
      inMethod.hashCode +
      (outMethod == null ? 0 : outMethod.hashCode) +
      outletId.hashCode +
      updatedBy.hashCode +
      workDate.hashCode;

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRecordFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceRecordToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
