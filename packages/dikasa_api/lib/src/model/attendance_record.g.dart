// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_record.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceRecordCWProxy {
  AttendanceRecord clockIn(DateTime clockIn);

  AttendanceRecord clockOut(DateTime? clockOut);

  AttendanceRecord createdBy(String createdBy);

  AttendanceRecord employeeId(String employeeId);

  AttendanceRecord employeeName(String employeeName);

  AttendanceRecord id(String id);

  AttendanceRecord inMethod(String inMethod);

  AttendanceRecord outMethod(String? outMethod);

  AttendanceRecord outletId(String outletId);

  AttendanceRecord updatedBy(String updatedBy);

  AttendanceRecord workDate(String workDate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceRecord(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceRecord(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceRecord call({
    DateTime clockIn,
    DateTime? clockOut,
    String createdBy,
    String employeeId,
    String employeeName,
    String id,
    String inMethod,
    String? outMethod,
    String outletId,
    String updatedBy,
    String workDate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceRecord.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceRecord.copyWith.fieldName(...)`
class _$AttendanceRecordCWProxyImpl implements _$AttendanceRecordCWProxy {
  const _$AttendanceRecordCWProxyImpl(this._value);

  final AttendanceRecord _value;

  @override
  AttendanceRecord clockIn(DateTime clockIn) => this(clockIn: clockIn);

  @override
  AttendanceRecord clockOut(DateTime? clockOut) => this(clockOut: clockOut);

  @override
  AttendanceRecord createdBy(String createdBy) => this(createdBy: createdBy);

  @override
  AttendanceRecord employeeId(String employeeId) =>
      this(employeeId: employeeId);

  @override
  AttendanceRecord employeeName(String employeeName) =>
      this(employeeName: employeeName);

  @override
  AttendanceRecord id(String id) => this(id: id);

  @override
  AttendanceRecord inMethod(String inMethod) => this(inMethod: inMethod);

  @override
  AttendanceRecord outMethod(String? outMethod) => this(outMethod: outMethod);

  @override
  AttendanceRecord outletId(String outletId) => this(outletId: outletId);

  @override
  AttendanceRecord updatedBy(String updatedBy) => this(updatedBy: updatedBy);

  @override
  AttendanceRecord workDate(String workDate) => this(workDate: workDate);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceRecord(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceRecord(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceRecord call({
    Object? clockIn = const $CopyWithPlaceholder(),
    Object? clockOut = const $CopyWithPlaceholder(),
    Object? createdBy = const $CopyWithPlaceholder(),
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? employeeName = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? inMethod = const $CopyWithPlaceholder(),
    Object? outMethod = const $CopyWithPlaceholder(),
    Object? outletId = const $CopyWithPlaceholder(),
    Object? updatedBy = const $CopyWithPlaceholder(),
    Object? workDate = const $CopyWithPlaceholder(),
  }) {
    return AttendanceRecord(
      clockIn: clockIn == const $CopyWithPlaceholder()
          ? _value.clockIn
          // ignore: cast_nullable_to_non_nullable
          : clockIn as DateTime,
      clockOut: clockOut == const $CopyWithPlaceholder()
          ? _value.clockOut
          // ignore: cast_nullable_to_non_nullable
          : clockOut as DateTime?,
      createdBy: createdBy == const $CopyWithPlaceholder()
          ? _value.createdBy
          // ignore: cast_nullable_to_non_nullable
          : createdBy as String,
      employeeId: employeeId == const $CopyWithPlaceholder()
          ? _value.employeeId
          // ignore: cast_nullable_to_non_nullable
          : employeeId as String,
      employeeName: employeeName == const $CopyWithPlaceholder()
          ? _value.employeeName
          // ignore: cast_nullable_to_non_nullable
          : employeeName as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      inMethod: inMethod == const $CopyWithPlaceholder()
          ? _value.inMethod
          // ignore: cast_nullable_to_non_nullable
          : inMethod as String,
      outMethod: outMethod == const $CopyWithPlaceholder()
          ? _value.outMethod
          // ignore: cast_nullable_to_non_nullable
          : outMethod as String?,
      outletId: outletId == const $CopyWithPlaceholder()
          ? _value.outletId
          // ignore: cast_nullable_to_non_nullable
          : outletId as String,
      updatedBy: updatedBy == const $CopyWithPlaceholder()
          ? _value.updatedBy
          // ignore: cast_nullable_to_non_nullable
          : updatedBy as String,
      workDate: workDate == const $CopyWithPlaceholder()
          ? _value.workDate
          // ignore: cast_nullable_to_non_nullable
          : workDate as String,
    );
  }
}

extension $AttendanceRecordCopyWith on AttendanceRecord {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceRecord.copyWith(...)` or like so:`instanceOfAttendanceRecord.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceRecordCWProxy get copyWith => _$AttendanceRecordCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceRecord _$AttendanceRecordFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AttendanceRecord',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'clock_in',
            'clock_out',
            'created_by',
            'employee_id',
            'employee_name',
            'id',
            'in_method',
            'out_method',
            'outlet_id',
            'updated_by',
            'work_date',
          ],
        );
        final val = AttendanceRecord(
          clockIn: $checkedConvert(
            'clock_in',
            (v) => DateTime.parse(v as String),
          ),
          clockOut: $checkedConvert(
            'clock_out',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          createdBy: $checkedConvert('created_by', (v) => v as String),
          employeeId: $checkedConvert('employee_id', (v) => v as String),
          employeeName: $checkedConvert('employee_name', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String),
          inMethod: $checkedConvert('in_method', (v) => v as String),
          outMethod: $checkedConvert('out_method', (v) => v as String?),
          outletId: $checkedConvert('outlet_id', (v) => v as String),
          updatedBy: $checkedConvert('updated_by', (v) => v as String),
          workDate: $checkedConvert('work_date', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'clockIn': 'clock_in',
        'clockOut': 'clock_out',
        'createdBy': 'created_by',
        'employeeId': 'employee_id',
        'employeeName': 'employee_name',
        'inMethod': 'in_method',
        'outMethod': 'out_method',
        'outletId': 'outlet_id',
        'updatedBy': 'updated_by',
        'workDate': 'work_date',
      },
    );

Map<String, dynamic> _$AttendanceRecordToJson(AttendanceRecord instance) =>
    <String, dynamic>{
      'clock_in': instance.clockIn.toIso8601String(),
      'clock_out': instance.clockOut?.toIso8601String(),
      'created_by': instance.createdBy,
      'employee_id': instance.employeeId,
      'employee_name': instance.employeeName,
      'id': instance.id,
      'in_method': instance.inMethod,
      'out_method': instance.outMethod,
      'outlet_id': instance.outletId,
      'updated_by': instance.updatedBy,
      'work_date': instance.workDate,
    };
