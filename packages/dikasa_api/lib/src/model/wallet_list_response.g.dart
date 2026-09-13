// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_list_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletListResponseCWProxy {
  WalletListResponse data(List<WalletData>? data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletListResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletListResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletListResponse call({List<WalletData>? data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWalletListResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWalletListResponse.copyWith.fieldName(...)`
class _$WalletListResponseCWProxyImpl implements _$WalletListResponseCWProxy {
  const _$WalletListResponseCWProxyImpl(this._value);

  final WalletListResponse _value;

  @override
  WalletListResponse data(List<WalletData>? data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletListResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletListResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletListResponse call({Object? data = const $CopyWithPlaceholder()}) {
    return WalletListResponse(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<WalletData>?,
    );
  }
}

extension $WalletListResponseCopyWith on WalletListResponse {
  /// Returns a callable class that can be used as follows: `instanceOfWalletListResponse.copyWith(...)` or like so:`instanceOfWalletListResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletListResponseCWProxy get copyWith =>
      _$WalletListResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletListResponse _$WalletListResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WalletListResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = WalletListResponse(
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>?)
              ?.map((e) => WalletData.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$WalletListResponseToJson(WalletListResponse instance) =>
    <String, dynamic>{'data': instance.data?.map((e) => e.toJson()).toList()};
