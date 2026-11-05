// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_biometric_input_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceBiometricInputBodyCWProxy {
  AttendanceBiometricInputBody challengeId(String challengeId);

  AttendanceBiometricInputBody signature(String signature);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceBiometricInputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceBiometricInputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceBiometricInputBody call({String challengeId, String signature});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceBiometricInputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceBiometricInputBody.copyWith.fieldName(...)`
class _$AttendanceBiometricInputBodyCWProxyImpl
    implements _$AttendanceBiometricInputBodyCWProxy {
  const _$AttendanceBiometricInputBodyCWProxyImpl(this._value);

  final AttendanceBiometricInputBody _value;

  @override
  AttendanceBiometricInputBody challengeId(String challengeId) =>
      this(challengeId: challengeId);

  @override
  AttendanceBiometricInputBody signature(String signature) =>
      this(signature: signature);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceBiometricInputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceBiometricInputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceBiometricInputBody call({
    Object? challengeId = const $CopyWithPlaceholder(),
    Object? signature = const $CopyWithPlaceholder(),
  }) {
    return AttendanceBiometricInputBody(
      challengeId: challengeId == const $CopyWithPlaceholder()
          ? _value.challengeId
          // ignore: cast_nullable_to_non_nullable
          : challengeId as String,
      signature: signature == const $CopyWithPlaceholder()
          ? _value.signature
          // ignore: cast_nullable_to_non_nullable
          : signature as String,
    );
  }
}

extension $AttendanceBiometricInputBodyCopyWith
    on AttendanceBiometricInputBody {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceBiometricInputBody.copyWith(...)` or like so:`instanceOfAttendanceBiometricInputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceBiometricInputBodyCWProxy get copyWith =>
      _$AttendanceBiometricInputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceBiometricInputBody _$AttendanceBiometricInputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'AttendanceBiometricInputBody',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['challenge_id', 'signature']);
    final val = AttendanceBiometricInputBody(
      challengeId: $checkedConvert('challenge_id', (v) => v as String),
      signature: $checkedConvert('signature', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {'challengeId': 'challenge_id'},
);

Map<String, dynamic> _$AttendanceBiometricInputBodyToJson(
  AttendanceBiometricInputBody instance,
) => <String, dynamic>{
  'challenge_id': instance.challengeId,
  'signature': instance.signature,
};
