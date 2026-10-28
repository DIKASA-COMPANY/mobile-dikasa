// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_otp_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfirmOTPRequestCWProxy {
  ConfirmOTPRequest email(String email);

  ConfirmOTPRequest otp(String otp);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfirmOTPRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfirmOTPRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfirmOTPRequest call({String email, String otp});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConfirmOTPRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConfirmOTPRequest.copyWith.fieldName(...)`
class _$ConfirmOTPRequestCWProxyImpl implements _$ConfirmOTPRequestCWProxy {
  const _$ConfirmOTPRequestCWProxyImpl(this._value);

  final ConfirmOTPRequest _value;

  @override
  ConfirmOTPRequest email(String email) => this(email: email);

  @override
  ConfirmOTPRequest otp(String otp) => this(otp: otp);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfirmOTPRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfirmOTPRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfirmOTPRequest call({
    Object? email = const $CopyWithPlaceholder(),
    Object? otp = const $CopyWithPlaceholder(),
  }) {
    return ConfirmOTPRequest(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      otp: otp == const $CopyWithPlaceholder()
          ? _value.otp
          // ignore: cast_nullable_to_non_nullable
          : otp as String,
    );
  }
}

extension $ConfirmOTPRequestCopyWith on ConfirmOTPRequest {
  /// Returns a callable class that can be used as follows: `instanceOfConfirmOTPRequest.copyWith(...)` or like so:`instanceOfConfirmOTPRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfirmOTPRequestCWProxy get copyWith =>
      _$ConfirmOTPRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmOTPRequest _$ConfirmOTPRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ConfirmOTPRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['email', 'otp']);
      final val = ConfirmOTPRequest(
        email: $checkedConvert('email', (v) => v as String),
        otp: $checkedConvert('otp', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ConfirmOTPRequestToJson(ConfirmOTPRequest instance) =>
    <String, dynamic>{'email': instance.email, 'otp': instance.otp};
