// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_enrollment_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceEnrollmentRequestCWProxy {
  AttendanceEnrollmentRequest pin(String pin);

  AttendanceEnrollmentRequest publicKey(String publicKey);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceEnrollmentRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceEnrollmentRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceEnrollmentRequest call({String pin, String publicKey});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceEnrollmentRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceEnrollmentRequest.copyWith.fieldName(...)`
class _$AttendanceEnrollmentRequestCWProxyImpl
    implements _$AttendanceEnrollmentRequestCWProxy {
  const _$AttendanceEnrollmentRequestCWProxyImpl(this._value);

  final AttendanceEnrollmentRequest _value;

  @override
  AttendanceEnrollmentRequest pin(String pin) => this(pin: pin);

  @override
  AttendanceEnrollmentRequest publicKey(String publicKey) =>
      this(publicKey: publicKey);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceEnrollmentRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceEnrollmentRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceEnrollmentRequest call({
    Object? pin = const $CopyWithPlaceholder(),
    Object? publicKey = const $CopyWithPlaceholder(),
  }) {
    return AttendanceEnrollmentRequest(
      pin: pin == const $CopyWithPlaceholder()
          ? _value.pin
          // ignore: cast_nullable_to_non_nullable
          : pin as String,
      publicKey: publicKey == const $CopyWithPlaceholder()
          ? _value.publicKey
          // ignore: cast_nullable_to_non_nullable
          : publicKey as String,
    );
  }
}

extension $AttendanceEnrollmentRequestCopyWith on AttendanceEnrollmentRequest {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceEnrollmentRequest.copyWith(...)` or like so:`instanceOfAttendanceEnrollmentRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceEnrollmentRequestCWProxy get copyWith =>
      _$AttendanceEnrollmentRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceEnrollmentRequest _$AttendanceEnrollmentRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AttendanceEnrollmentRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['pin', 'public_key']);
  final val = AttendanceEnrollmentRequest(
    pin: $checkedConvert('pin', (v) => v as String),
    publicKey: $checkedConvert('public_key', (v) => v as String),
  );
  return val;
}, fieldKeyMap: const {'publicKey': 'public_key'});

Map<String, dynamic> _$AttendanceEnrollmentRequestToJson(
  AttendanceEnrollmentRequest instance,
) => <String, dynamic>{'pin': instance.pin, 'public_key': instance.publicKey};
