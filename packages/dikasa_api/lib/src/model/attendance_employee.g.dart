// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_employee.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceEmployeeCWProxy {
  AttendanceEmployee fingerprintEnrolled(bool fingerprintEnrolled);

  AttendanceEmployee hasPin(bool hasPin);

  AttendanceEmployee id(String id);

  AttendanceEmployee name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceEmployee(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceEmployee(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceEmployee call({
    bool fingerprintEnrolled,
    bool hasPin,
    String id,
    String name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceEmployee.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceEmployee.copyWith.fieldName(...)`
class _$AttendanceEmployeeCWProxyImpl implements _$AttendanceEmployeeCWProxy {
  const _$AttendanceEmployeeCWProxyImpl(this._value);

  final AttendanceEmployee _value;

  @override
  AttendanceEmployee fingerprintEnrolled(bool fingerprintEnrolled) =>
      this(fingerprintEnrolled: fingerprintEnrolled);

  @override
  AttendanceEmployee hasPin(bool hasPin) => this(hasPin: hasPin);

  @override
  AttendanceEmployee id(String id) => this(id: id);

  @override
  AttendanceEmployee name(String name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceEmployee(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceEmployee(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceEmployee call({
    Object? fingerprintEnrolled = const $CopyWithPlaceholder(),
    Object? hasPin = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return AttendanceEmployee(
      fingerprintEnrolled: fingerprintEnrolled == const $CopyWithPlaceholder()
          ? _value.fingerprintEnrolled
          // ignore: cast_nullable_to_non_nullable
          : fingerprintEnrolled as bool,
      hasPin: hasPin == const $CopyWithPlaceholder()
          ? _value.hasPin
          // ignore: cast_nullable_to_non_nullable
          : hasPin as bool,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $AttendanceEmployeeCopyWith on AttendanceEmployee {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceEmployee.copyWith(...)` or like so:`instanceOfAttendanceEmployee.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceEmployeeCWProxy get copyWith =>
      _$AttendanceEmployeeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceEmployee _$AttendanceEmployeeFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AttendanceEmployee',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['fingerprint_enrolled', 'has_pin', 'id', 'name'],
        );
        final val = AttendanceEmployee(
          fingerprintEnrolled: $checkedConvert(
            'fingerprint_enrolled',
            (v) => v as bool,
          ),
          hasPin: $checkedConvert('has_pin', (v) => v as bool),
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'fingerprintEnrolled': 'fingerprint_enrolled',
        'hasPin': 'has_pin',
      },
    );

Map<String, dynamic> _$AttendanceEmployeeToJson(AttendanceEmployee instance) =>
    <String, dynamic>{
      'fingerprint_enrolled': instance.fingerprintEnrolled,
      'has_pin': instance.hasPin,
      'id': instance.id,
      'name': instance.name,
    };
