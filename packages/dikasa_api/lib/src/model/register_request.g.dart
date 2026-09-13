// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegisterRequestCWProxy {
  RegisterRequest businessAddress(String businessAddress);

  RegisterRequest businessEmail(String? businessEmail);

  RegisterRequest businessName(String businessName);

  RegisterRequest businessPhone(String businessPhone);

  RegisterRequest ownerDateOfBirth(DateTime ownerDateOfBirth);

  RegisterRequest ownerEmail(String ownerEmail);

  RegisterRequest ownerName(String ownerName);

  RegisterRequest ownerPhone(String ownerPhone);

  RegisterRequest password(String password);

  RegisterRequest passwordConfirmation(String passwordConfirmation);

  RegisterRequest username(String username);

  RegisterRequest verificationEmail(String verificationEmail);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegisterRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegisterRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  RegisterRequest call({
    String businessAddress,
    String? businessEmail,
    String businessName,
    String businessPhone,
    DateTime ownerDateOfBirth,
    String ownerEmail,
    String ownerName,
    String ownerPhone,
    String password,
    String passwordConfirmation,
    String username,
    String verificationEmail,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRegisterRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRegisterRequest.copyWith.fieldName(...)`
class _$RegisterRequestCWProxyImpl implements _$RegisterRequestCWProxy {
  const _$RegisterRequestCWProxyImpl(this._value);

  final RegisterRequest _value;

  @override
  RegisterRequest businessAddress(String businessAddress) =>
      this(businessAddress: businessAddress);

  @override
  RegisterRequest businessEmail(String? businessEmail) =>
      this(businessEmail: businessEmail);

  @override
  RegisterRequest businessName(String businessName) =>
      this(businessName: businessName);

  @override
  RegisterRequest businessPhone(String businessPhone) =>
      this(businessPhone: businessPhone);

  @override
  RegisterRequest ownerDateOfBirth(DateTime ownerDateOfBirth) =>
      this(ownerDateOfBirth: ownerDateOfBirth);

  @override
  RegisterRequest ownerEmail(String ownerEmail) => this(ownerEmail: ownerEmail);

  @override
  RegisterRequest ownerName(String ownerName) => this(ownerName: ownerName);

  @override
  RegisterRequest ownerPhone(String ownerPhone) => this(ownerPhone: ownerPhone);

  @override
  RegisterRequest password(String password) => this(password: password);

  @override
  RegisterRequest passwordConfirmation(String passwordConfirmation) =>
      this(passwordConfirmation: passwordConfirmation);

  @override
  RegisterRequest username(String username) => this(username: username);

  @override
  RegisterRequest verificationEmail(String verificationEmail) =>
      this(verificationEmail: verificationEmail);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegisterRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegisterRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  RegisterRequest call({
    Object? businessAddress = const $CopyWithPlaceholder(),
    Object? businessEmail = const $CopyWithPlaceholder(),
    Object? businessName = const $CopyWithPlaceholder(),
    Object? businessPhone = const $CopyWithPlaceholder(),
    Object? ownerDateOfBirth = const $CopyWithPlaceholder(),
    Object? ownerEmail = const $CopyWithPlaceholder(),
    Object? ownerName = const $CopyWithPlaceholder(),
    Object? ownerPhone = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? passwordConfirmation = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
    Object? verificationEmail = const $CopyWithPlaceholder(),
  }) {
    return RegisterRequest(
      businessAddress: businessAddress == const $CopyWithPlaceholder()
          ? _value.businessAddress
          // ignore: cast_nullable_to_non_nullable
          : businessAddress as String,
      businessEmail: businessEmail == const $CopyWithPlaceholder()
          ? _value.businessEmail
          // ignore: cast_nullable_to_non_nullable
          : businessEmail as String?,
      businessName: businessName == const $CopyWithPlaceholder()
          ? _value.businessName
          // ignore: cast_nullable_to_non_nullable
          : businessName as String,
      businessPhone: businessPhone == const $CopyWithPlaceholder()
          ? _value.businessPhone
          // ignore: cast_nullable_to_non_nullable
          : businessPhone as String,
      ownerDateOfBirth: ownerDateOfBirth == const $CopyWithPlaceholder()
          ? _value.ownerDateOfBirth
          // ignore: cast_nullable_to_non_nullable
          : ownerDateOfBirth as DateTime,
      ownerEmail: ownerEmail == const $CopyWithPlaceholder()
          ? _value.ownerEmail
          // ignore: cast_nullable_to_non_nullable
          : ownerEmail as String,
      ownerName: ownerName == const $CopyWithPlaceholder()
          ? _value.ownerName
          // ignore: cast_nullable_to_non_nullable
          : ownerName as String,
      ownerPhone: ownerPhone == const $CopyWithPlaceholder()
          ? _value.ownerPhone
          // ignore: cast_nullable_to_non_nullable
          : ownerPhone as String,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      passwordConfirmation: passwordConfirmation == const $CopyWithPlaceholder()
          ? _value.passwordConfirmation
          // ignore: cast_nullable_to_non_nullable
          : passwordConfirmation as String,
      username: username == const $CopyWithPlaceholder()
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
      verificationEmail: verificationEmail == const $CopyWithPlaceholder()
          ? _value.verificationEmail
          // ignore: cast_nullable_to_non_nullable
          : verificationEmail as String,
    );
  }
}

extension $RegisterRequestCopyWith on RegisterRequest {
  /// Returns a callable class that can be used as follows: `instanceOfRegisterRequest.copyWith(...)` or like so:`instanceOfRegisterRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegisterRequestCWProxy get copyWith => _$RegisterRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RegisterRequest',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'business_address',
            'business_name',
            'business_phone',
            'owner_date_of_birth',
            'owner_email',
            'owner_name',
            'owner_phone',
            'password',
            'password_confirmation',
            'username',
            'verification_email',
          ],
        );
        final val = RegisterRequest(
          businessAddress: $checkedConvert(
            'business_address',
            (v) => v as String,
          ),
          businessEmail: $checkedConvert('business_email', (v) => v as String?),
          businessName: $checkedConvert('business_name', (v) => v as String),
          businessPhone: $checkedConvert('business_phone', (v) => v as String),
          ownerDateOfBirth: $checkedConvert(
            'owner_date_of_birth',
            (v) => DateTime.parse(v as String),
          ),
          ownerEmail: $checkedConvert('owner_email', (v) => v as String),
          ownerName: $checkedConvert('owner_name', (v) => v as String),
          ownerPhone: $checkedConvert('owner_phone', (v) => v as String),
          password: $checkedConvert('password', (v) => v as String),
          passwordConfirmation: $checkedConvert(
            'password_confirmation',
            (v) => v as String,
          ),
          username: $checkedConvert('username', (v) => v as String),
          verificationEmail: $checkedConvert(
            'verification_email',
            (v) => v as String,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'businessAddress': 'business_address',
        'businessEmail': 'business_email',
        'businessName': 'business_name',
        'businessPhone': 'business_phone',
        'ownerDateOfBirth': 'owner_date_of_birth',
        'ownerEmail': 'owner_email',
        'ownerName': 'owner_name',
        'ownerPhone': 'owner_phone',
        'passwordConfirmation': 'password_confirmation',
        'verificationEmail': 'verification_email',
      },
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'business_address': instance.businessAddress,
      'business_email': ?instance.businessEmail,
      'business_name': instance.businessName,
      'business_phone': instance.businessPhone,
      'owner_date_of_birth': instance.ownerDateOfBirth.toIso8601String(),
      'owner_email': instance.ownerEmail,
      'owner_name': instance.ownerName,
      'owner_phone': instance.ownerPhone,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
      'username': instance.username,
      'verification_email': instance.verificationEmail,
    };
