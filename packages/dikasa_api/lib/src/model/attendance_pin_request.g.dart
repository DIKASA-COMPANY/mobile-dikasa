// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_pin_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendancePINRequestCWProxy {
  AttendancePINRequest action(AttendancePINRequestActionEnum action);

  AttendancePINRequest employeeId(String employeeId);

  AttendancePINRequest pin(String pin);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendancePINRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendancePINRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendancePINRequest call({
    AttendancePINRequestActionEnum action,
    String employeeId,
    String pin,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendancePINRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendancePINRequest.copyWith.fieldName(...)`
class _$AttendancePINRequestCWProxyImpl
    implements _$AttendancePINRequestCWProxy {
  const _$AttendancePINRequestCWProxyImpl(this._value);

  final AttendancePINRequest _value;

  @override
  AttendancePINRequest action(AttendancePINRequestActionEnum action) =>
      this(action: action);

  @override
  AttendancePINRequest employeeId(String employeeId) =>
      this(employeeId: employeeId);

  @override
  AttendancePINRequest pin(String pin) => this(pin: pin);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendancePINRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendancePINRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendancePINRequest call({
    Object? action = const $CopyWithPlaceholder(),
    Object? employeeId = const $CopyWithPlaceholder(),
    Object? pin = const $CopyWithPlaceholder(),
  }) {
    return AttendancePINRequest(
      action: action == const $CopyWithPlaceholder()
          ? _value.action
          // ignore: cast_nullable_to_non_nullable
          : action as AttendancePINRequestActionEnum,
      employeeId: employeeId == const $CopyWithPlaceholder()
          ? _value.employeeId
          // ignore: cast_nullable_to_non_nullable
          : employeeId as String,
      pin: pin == const $CopyWithPlaceholder()
          ? _value.pin
          // ignore: cast_nullable_to_non_nullable
          : pin as String,
    );
  }
}

extension $AttendancePINRequestCopyWith on AttendancePINRequest {
  /// Returns a callable class that can be used as follows: `instanceOfAttendancePINRequest.copyWith(...)` or like so:`instanceOfAttendancePINRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendancePINRequestCWProxy get copyWith =>
      _$AttendancePINRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendancePINRequest _$AttendancePINRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AttendancePINRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['action', 'employee_id', 'pin']);
  final val = AttendancePINRequest(
    action: $checkedConvert(
      'action',
      (v) => $enumDecode(
        _$AttendancePINRequestActionEnumEnumMap,
        v,
        unknownValue: AttendancePINRequestActionEnum.unknownDefaultOpenApi,
      ),
    ),
    employeeId: $checkedConvert('employee_id', (v) => v as String),
    pin: $checkedConvert('pin', (v) => v as String),
  );
  return val;
}, fieldKeyMap: const {'employeeId': 'employee_id'});

Map<String, dynamic> _$AttendancePINRequestToJson(
  AttendancePINRequest instance,
) => <String, dynamic>{
  'action': _$AttendancePINRequestActionEnumEnumMap[instance.action]!,
  'employee_id': instance.employeeId,
  'pin': instance.pin,
};

const _$AttendancePINRequestActionEnumEnumMap = {
  AttendancePINRequestActionEnum.in_: 'in',
  AttendancePINRequestActionEnum.out_: 'out',
  AttendancePINRequestActionEnum.unknownDefaultOpenApi:
      'unknown_default_open_api',
};
