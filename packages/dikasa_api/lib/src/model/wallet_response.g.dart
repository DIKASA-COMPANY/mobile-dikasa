// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletResponseCWProxy {
  WalletResponse data(WalletData data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletResponse call({WalletData data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWalletResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWalletResponse.copyWith.fieldName(...)`
class _$WalletResponseCWProxyImpl implements _$WalletResponseCWProxy {
  const _$WalletResponseCWProxyImpl(this._value);

  final WalletResponse _value;

  @override
  WalletResponse data(WalletData data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletResponse call({Object? data = const $CopyWithPlaceholder()}) {
    return WalletResponse(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as WalletData,
    );
  }
}

extension $WalletResponseCopyWith on WalletResponse {
  /// Returns a callable class that can be used as follows: `instanceOfWalletResponse.copyWith(...)` or like so:`instanceOfWalletResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletResponseCWProxy get copyWith => _$WalletResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletResponse _$WalletResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WalletResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = WalletResponse(
        data: $checkedConvert(
          'data',
          (v) => WalletData.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$WalletResponseToJson(WalletResponse instance) =>
    <String, dynamic>{'data': instance.data.toJson()};
