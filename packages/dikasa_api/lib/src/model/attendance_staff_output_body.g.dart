// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_staff_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceStaffOutputBodyCWProxy {
  AttendanceStaffOutputBody data(List<AttendanceEmployee>? data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceStaffOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceStaffOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceStaffOutputBody call({List<AttendanceEmployee>? data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceStaffOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceStaffOutputBody.copyWith.fieldName(...)`
class _$AttendanceStaffOutputBodyCWProxyImpl
    implements _$AttendanceStaffOutputBodyCWProxy {
  const _$AttendanceStaffOutputBodyCWProxyImpl(this._value);

  final AttendanceStaffOutputBody _value;

  @override
  AttendanceStaffOutputBody data(List<AttendanceEmployee>? data) =>
      this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceStaffOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceStaffOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceStaffOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return AttendanceStaffOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<AttendanceEmployee>?,
    );
  }
}

extension $AttendanceStaffOutputBodyCopyWith on AttendanceStaffOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceStaffOutputBody.copyWith(...)` or like so:`instanceOfAttendanceStaffOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceStaffOutputBodyCWProxy get copyWith =>
      _$AttendanceStaffOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceStaffOutputBody _$AttendanceStaffOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AttendanceStaffOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = AttendanceStaffOutputBody(
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>?)
          ?.map((e) => AttendanceEmployee.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$AttendanceStaffOutputBodyToJson(
  AttendanceStaffOutputBody instance,
) => <String, dynamic>{'data': instance.data?.map((e) => e.toJson()).toList()};
