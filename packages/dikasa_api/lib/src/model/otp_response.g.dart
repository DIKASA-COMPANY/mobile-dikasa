// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OTPResponseCWProxy {
  OTPResponse data(OTPResponseData data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OTPResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OTPResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  OTPResponse call({OTPResponseData data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOTPResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOTPResponse.copyWith.fieldName(...)`
class _$OTPResponseCWProxyImpl implements _$OTPResponseCWProxy {
  const _$OTPResponseCWProxyImpl(this._value);

  final OTPResponse _value;

  @override
  OTPResponse data(OTPResponseData data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OTPResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OTPResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  OTPResponse call({Object? data = const $CopyWithPlaceholder()}) {
    return OTPResponse(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as OTPResponseData,
    );
  }
}

extension $OTPResponseCopyWith on OTPResponse {
  /// Returns a callable class that can be used as follows: `instanceOfOTPResponse.copyWith(...)` or like so:`instanceOfOTPResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OTPResponseCWProxy get copyWith => _$OTPResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPResponse _$OTPResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OTPResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = OTPResponse(
        data: $checkedConvert(
          'data',
          (v) => OTPResponseData.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OTPResponseToJson(OTPResponse instance) =>
    <String, dynamic>{'data': instance.data.toJson()};
