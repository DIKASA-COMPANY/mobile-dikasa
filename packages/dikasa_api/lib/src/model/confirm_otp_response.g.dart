// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_otp_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfirmOTPResponseCWProxy {
  ConfirmOTPResponse data(ConfirmOTPResponseData data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfirmOTPResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfirmOTPResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfirmOTPResponse call({ConfirmOTPResponseData data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConfirmOTPResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConfirmOTPResponse.copyWith.fieldName(...)`
class _$ConfirmOTPResponseCWProxyImpl implements _$ConfirmOTPResponseCWProxy {
  const _$ConfirmOTPResponseCWProxyImpl(this._value);

  final ConfirmOTPResponse _value;

  @override
  ConfirmOTPResponse data(ConfirmOTPResponseData data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfirmOTPResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfirmOTPResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfirmOTPResponse call({Object? data = const $CopyWithPlaceholder()}) {
    return ConfirmOTPResponse(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ConfirmOTPResponseData,
    );
  }
}

extension $ConfirmOTPResponseCopyWith on ConfirmOTPResponse {
  /// Returns a callable class that can be used as follows: `instanceOfConfirmOTPResponse.copyWith(...)` or like so:`instanceOfConfirmOTPResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfirmOTPResponseCWProxy get copyWith =>
      _$ConfirmOTPResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmOTPResponse _$ConfirmOTPResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ConfirmOTPResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = ConfirmOTPResponse(
        data: $checkedConvert(
          'data',
          (v) => ConfirmOTPResponseData.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ConfirmOTPResponseToJson(ConfirmOTPResponse instance) =>
    <String, dynamic>{'data': instance.data.toJson()};
