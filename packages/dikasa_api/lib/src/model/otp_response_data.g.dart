// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OTPResponseDataCWProxy {
  OTPResponseData email(String email);

  OTPResponseData otpExpiresIn(int otpExpiresIn);

  OTPResponseData resendAvailableIn(int resendAvailableIn);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OTPResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OTPResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  OTPResponseData call({String email, int otpExpiresIn, int resendAvailableIn});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOTPResponseData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOTPResponseData.copyWith.fieldName(...)`
class _$OTPResponseDataCWProxyImpl implements _$OTPResponseDataCWProxy {
  const _$OTPResponseDataCWProxyImpl(this._value);

  final OTPResponseData _value;

  @override
  OTPResponseData email(String email) => this(email: email);

  @override
  OTPResponseData otpExpiresIn(int otpExpiresIn) =>
      this(otpExpiresIn: otpExpiresIn);

  @override
  OTPResponseData resendAvailableIn(int resendAvailableIn) =>
      this(resendAvailableIn: resendAvailableIn);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OTPResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OTPResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  OTPResponseData call({
    Object? email = const $CopyWithPlaceholder(),
    Object? otpExpiresIn = const $CopyWithPlaceholder(),
    Object? resendAvailableIn = const $CopyWithPlaceholder(),
  }) {
    return OTPResponseData(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      otpExpiresIn: otpExpiresIn == const $CopyWithPlaceholder()
          ? _value.otpExpiresIn
          // ignore: cast_nullable_to_non_nullable
          : otpExpiresIn as int,
      resendAvailableIn: resendAvailableIn == const $CopyWithPlaceholder()
          ? _value.resendAvailableIn
          // ignore: cast_nullable_to_non_nullable
          : resendAvailableIn as int,
    );
  }
}

extension $OTPResponseDataCopyWith on OTPResponseData {
  /// Returns a callable class that can be used as follows: `instanceOfOTPResponseData.copyWith(...)` or like so:`instanceOfOTPResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OTPResponseDataCWProxy get copyWith => _$OTPResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPResponseData _$OTPResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'OTPResponseData',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'email',
            'otp_expires_in',
            'resend_available_in',
          ],
        );
        final val = OTPResponseData(
          email: $checkedConvert('email', (v) => v as String),
          otpExpiresIn: $checkedConvert(
            'otp_expires_in',
            (v) => (v as num).toInt(),
          ),
          resendAvailableIn: $checkedConvert(
            'resend_available_in',
            (v) => (v as num).toInt(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'otpExpiresIn': 'otp_expires_in',
        'resendAvailableIn': 'resend_available_in',
      },
    );

Map<String, dynamic> _$OTPResponseDataToJson(OTPResponseData instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp_expires_in': instance.otpExpiresIn,
      'resend_available_in': instance.resendAvailableIn,
    };
