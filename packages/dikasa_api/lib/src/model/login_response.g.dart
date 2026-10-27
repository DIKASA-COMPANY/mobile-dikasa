// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LoginResponseCWProxy {
  LoginResponse data(LoginResponseData data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginResponse call({LoginResponseData data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLoginResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLoginResponse.copyWith.fieldName(...)`
class _$LoginResponseCWProxyImpl implements _$LoginResponseCWProxy {
  const _$LoginResponseCWProxyImpl(this._value);

  final LoginResponse _value;

  @override
  LoginResponse data(LoginResponseData data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginResponse call({Object? data = const $CopyWithPlaceholder()}) {
    return LoginResponse(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as LoginResponseData,
    );
  }
}

extension $LoginResponseCopyWith on LoginResponse {
  /// Returns a callable class that can be used as follows: `instanceOfLoginResponse.copyWith(...)` or like so:`instanceOfLoginResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LoginResponseCWProxy get copyWith => _$LoginResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LoginResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = LoginResponse(
        data: $checkedConvert(
          'data',
          (v) => LoginResponseData.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{'data': instance.data.toJson()};
