// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_status_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceStatusOutputBodyCWProxy {
  AttendanceStatusOutputBody data(AttendanceRecord? data);

  AttendanceStatusOutputBody serverTime(DateTime serverTime);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceStatusOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceStatusOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceStatusOutputBody call({
    AttendanceRecord? data,
    DateTime serverTime,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceStatusOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceStatusOutputBody.copyWith.fieldName(...)`
class _$AttendanceStatusOutputBodyCWProxyImpl
    implements _$AttendanceStatusOutputBodyCWProxy {
  const _$AttendanceStatusOutputBodyCWProxyImpl(this._value);

  final AttendanceStatusOutputBody _value;

  @override
  AttendanceStatusOutputBody data(AttendanceRecord? data) => this(data: data);

  @override
  AttendanceStatusOutputBody serverTime(DateTime serverTime) =>
      this(serverTime: serverTime);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceStatusOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceStatusOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceStatusOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
    Object? serverTime = const $CopyWithPlaceholder(),
  }) {
    return AttendanceStatusOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as AttendanceRecord?,
      serverTime: serverTime == const $CopyWithPlaceholder()
          ? _value.serverTime
          // ignore: cast_nullable_to_non_nullable
          : serverTime as DateTime,
    );
  }
}

extension $AttendanceStatusOutputBodyCopyWith on AttendanceStatusOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceStatusOutputBody.copyWith(...)` or like so:`instanceOfAttendanceStatusOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceStatusOutputBodyCWProxy get copyWith =>
      _$AttendanceStatusOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceStatusOutputBody _$AttendanceStatusOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'AttendanceStatusOutputBody',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['server_time']);
    final val = AttendanceStatusOutputBody(
      data: $checkedConvert(
        'data',
        (v) => v == null
            ? null
            : AttendanceRecord.fromJson(v as Map<String, dynamic>),
      ),
      serverTime: $checkedConvert(
        'server_time',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'serverTime': 'server_time'},
);

Map<String, dynamic> _$AttendanceStatusOutputBodyToJson(
  AttendanceStatusOutputBody instance,
) => <String, dynamic>{
  'data': ?instance.data?.toJson(),
  'server_time': instance.serverTime.toIso8601String(),
};
