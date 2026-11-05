// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceOutputBodyCWProxy {
  AttendanceOutputBody data(AttendanceRecord data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceOutputBody call({AttendanceRecord data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceOutputBody.copyWith.fieldName(...)`
class _$AttendanceOutputBodyCWProxyImpl
    implements _$AttendanceOutputBodyCWProxy {
  const _$AttendanceOutputBodyCWProxyImpl(this._value);

  final AttendanceOutputBody _value;

  @override
  AttendanceOutputBody data(AttendanceRecord data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return AttendanceOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as AttendanceRecord,
    );
  }
}

extension $AttendanceOutputBodyCopyWith on AttendanceOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceOutputBody.copyWith(...)` or like so:`instanceOfAttendanceOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceOutputBodyCWProxy get copyWith =>
      _$AttendanceOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceOutputBody _$AttendanceOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AttendanceOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = AttendanceOutputBody(
    data: $checkedConvert(
      'data',
      (v) => AttendanceRecord.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AttendanceOutputBodyToJson(
  AttendanceOutputBody instance,
) => <String, dynamic>{'data': instance.data.toJson()};
