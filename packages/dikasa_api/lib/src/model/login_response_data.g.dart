// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LoginResponseDataCWProxy {
  LoginResponseData accessToken(String accessToken);

  LoginResponseData expiresIn(int expiresIn);

  LoginResponseData firebaseUid(String firebaseUid);

  LoginResponseData refreshToken(String refreshToken);

  LoginResponseData tokenType(LoginResponseDataTokenTypeEnum tokenType);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginResponseData call({
    String accessToken,
    int expiresIn,
    String firebaseUid,
    String refreshToken,
    LoginResponseDataTokenTypeEnum tokenType,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLoginResponseData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLoginResponseData.copyWith.fieldName(...)`
class _$LoginResponseDataCWProxyImpl implements _$LoginResponseDataCWProxy {
  const _$LoginResponseDataCWProxyImpl(this._value);

  final LoginResponseData _value;

  @override
  LoginResponseData accessToken(String accessToken) =>
      this(accessToken: accessToken);

  @override
  LoginResponseData expiresIn(int expiresIn) => this(expiresIn: expiresIn);

  @override
  LoginResponseData firebaseUid(String firebaseUid) =>
      this(firebaseUid: firebaseUid);

  @override
  LoginResponseData refreshToken(String refreshToken) =>
      this(refreshToken: refreshToken);

  @override
  LoginResponseData tokenType(LoginResponseDataTokenTypeEnum tokenType) =>
      this(tokenType: tokenType);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginResponseData call({
    Object? accessToken = const $CopyWithPlaceholder(),
    Object? expiresIn = const $CopyWithPlaceholder(),
    Object? firebaseUid = const $CopyWithPlaceholder(),
    Object? refreshToken = const $CopyWithPlaceholder(),
    Object? tokenType = const $CopyWithPlaceholder(),
  }) {
    return LoginResponseData(
      accessToken: accessToken == const $CopyWithPlaceholder()
          ? _value.accessToken
          // ignore: cast_nullable_to_non_nullable
          : accessToken as String,
      expiresIn: expiresIn == const $CopyWithPlaceholder()
          ? _value.expiresIn
          // ignore: cast_nullable_to_non_nullable
          : expiresIn as int,
      firebaseUid: firebaseUid == const $CopyWithPlaceholder()
          ? _value.firebaseUid
          // ignore: cast_nullable_to_non_nullable
          : firebaseUid as String,
      refreshToken: refreshToken == const $CopyWithPlaceholder()
          ? _value.refreshToken
          // ignore: cast_nullable_to_non_nullable
          : refreshToken as String,
      tokenType: tokenType == const $CopyWithPlaceholder()
          ? _value.tokenType
          // ignore: cast_nullable_to_non_nullable
          : tokenType as LoginResponseDataTokenTypeEnum,
    );
  }
}

extension $LoginResponseDataCopyWith on LoginResponseData {
  /// Returns a callable class that can be used as follows: `instanceOfLoginResponseData.copyWith(...)` or like so:`instanceOfLoginResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LoginResponseDataCWProxy get copyWith =>
      _$LoginResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LoginResponseData',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'access_token',
            'expires_in',
            'firebase_uid',
            'refresh_token',
            'token_type',
          ],
        );
        final val = LoginResponseData(
          accessToken: $checkedConvert('access_token', (v) => v as String),
          expiresIn: $checkedConvert('expires_in', (v) => (v as num).toInt()),
          firebaseUid: $checkedConvert('firebase_uid', (v) => v as String),
          refreshToken: $checkedConvert('refresh_token', (v) => v as String),
          tokenType: $checkedConvert(
            'token_type',
            (v) => $enumDecode(
              _$LoginResponseDataTokenTypeEnumEnumMap,
              v,
              unknownValue:
                  LoginResponseDataTokenTypeEnum.unknownDefaultOpenApi,
            ),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'accessToken': 'access_token',
        'expiresIn': 'expires_in',
        'firebaseUid': 'firebase_uid',
        'refreshToken': 'refresh_token',
        'tokenType': 'token_type',
      },
    );

Map<String, dynamic> _$LoginResponseDataToJson(
  LoginResponseData instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'expires_in': instance.expiresIn,
  'firebase_uid': instance.firebaseUid,
  'refresh_token': instance.refreshToken,
  'token_type': _$LoginResponseDataTokenTypeEnumEnumMap[instance.tokenType]!,
};

const _$LoginResponseDataTokenTypeEnumEnumMap = {
  LoginResponseDataTokenTypeEnum.bearer: 'Bearer',
  LoginResponseDataTokenTypeEnum.unknownDefaultOpenApi:
      'unknown_default_open_api',
};
