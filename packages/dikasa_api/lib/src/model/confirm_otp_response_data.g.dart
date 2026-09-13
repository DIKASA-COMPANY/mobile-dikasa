// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_otp_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfirmOTPResponseDataCWProxy {
  ConfirmOTPResponseData verified(bool verified);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfirmOTPResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfirmOTPResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfirmOTPResponseData call({bool verified});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConfirmOTPResponseData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConfirmOTPResponseData.copyWith.fieldName(...)`
class _$ConfirmOTPResponseDataCWProxyImpl
    implements _$ConfirmOTPResponseDataCWProxy {
  const _$ConfirmOTPResponseDataCWProxyImpl(this._value);

  final ConfirmOTPResponseData _value;

  @override
  ConfirmOTPResponseData verified(bool verified) => this(verified: verified);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfirmOTPResponseData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfirmOTPResponseData(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfirmOTPResponseData call({
    Object? verified = const $CopyWithPlaceholder(),
  }) {
    return ConfirmOTPResponseData(
      verified: verified == const $CopyWithPlaceholder()
          ? _value.verified
          // ignore: cast_nullable_to_non_nullable
          : verified as bool,
    );
  }
}

extension $ConfirmOTPResponseDataCopyWith on ConfirmOTPResponseData {
  /// Returns a callable class that can be used as follows: `instanceOfConfirmOTPResponseData.copyWith(...)` or like so:`instanceOfConfirmOTPResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfirmOTPResponseDataCWProxy get copyWith =>
      _$ConfirmOTPResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmOTPResponseData _$ConfirmOTPResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ConfirmOTPResponseData', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['verified']);
  final val = ConfirmOTPResponseData(
    verified: $checkedConvert('verified', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$ConfirmOTPResponseDataToJson(
  ConfirmOTPResponseData instance,
) => <String, dynamic>{'verified': instance.verified};
