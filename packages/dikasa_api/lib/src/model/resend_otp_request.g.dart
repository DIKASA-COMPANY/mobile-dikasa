// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_otp_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ResendOTPRequestCWProxy {
  ResendOTPRequest email(String email);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResendOTPRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResendOTPRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ResendOTPRequest call({String email});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResendOTPRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfResendOTPRequest.copyWith.fieldName(...)`
class _$ResendOTPRequestCWProxyImpl implements _$ResendOTPRequestCWProxy {
  const _$ResendOTPRequestCWProxyImpl(this._value);

  final ResendOTPRequest _value;

  @override
  ResendOTPRequest email(String email) => this(email: email);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResendOTPRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResendOTPRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ResendOTPRequest call({Object? email = const $CopyWithPlaceholder()}) {
    return ResendOTPRequest(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
    );
  }
}

extension $ResendOTPRequestCopyWith on ResendOTPRequest {
  /// Returns a callable class that can be used as follows: `instanceOfResendOTPRequest.copyWith(...)` or like so:`instanceOfResendOTPRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResendOTPRequestCWProxy get copyWith => _$ResendOTPRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResendOTPRequest _$ResendOTPRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ResendOTPRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['email']);
      final val = ResendOTPRequest(
        email: $checkedConvert('email', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ResendOTPRequestToJson(ResendOTPRequest instance) =>
    <String, dynamic>{'email': instance.email};
