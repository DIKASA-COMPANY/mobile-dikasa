// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_history_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceHistoryOutputBodyCWProxy {
  AttendanceHistoryOutputBody data(List<AttendanceRecord>? data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceHistoryOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceHistoryOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceHistoryOutputBody call({List<AttendanceRecord>? data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceHistoryOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceHistoryOutputBody.copyWith.fieldName(...)`
class _$AttendanceHistoryOutputBodyCWProxyImpl
    implements _$AttendanceHistoryOutputBodyCWProxy {
  const _$AttendanceHistoryOutputBodyCWProxyImpl(this._value);

  final AttendanceHistoryOutputBody _value;

  @override
  AttendanceHistoryOutputBody data(List<AttendanceRecord>? data) =>
      this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceHistoryOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceHistoryOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceHistoryOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return AttendanceHistoryOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<AttendanceRecord>?,
    );
  }
}

extension $AttendanceHistoryOutputBodyCopyWith on AttendanceHistoryOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceHistoryOutputBody.copyWith(...)` or like so:`instanceOfAttendanceHistoryOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceHistoryOutputBodyCWProxy get copyWith =>
      _$AttendanceHistoryOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceHistoryOutputBody _$AttendanceHistoryOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AttendanceHistoryOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = AttendanceHistoryOutputBody(
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>?)
          ?.map((e) => AttendanceRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$AttendanceHistoryOutputBodyToJson(
  AttendanceHistoryOutputBody instance,
) => <String, dynamic>{'data': instance.data?.map((e) => e.toJson()).toList()};
