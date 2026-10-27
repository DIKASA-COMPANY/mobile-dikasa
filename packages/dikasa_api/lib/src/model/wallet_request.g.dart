// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletRequestCWProxy {
  WalletRequest code(String code);

  WalletRequest iconKey(String? iconKey);

  WalletRequest isActive(bool isActive);

  WalletRequest name(String name);

  WalletRequest sortOrder(int sortOrder);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletRequest call({
    String code,
    String? iconKey,
    bool isActive,
    String name,
    int sortOrder,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWalletRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWalletRequest.copyWith.fieldName(...)`
class _$WalletRequestCWProxyImpl implements _$WalletRequestCWProxy {
  const _$WalletRequestCWProxyImpl(this._value);

  final WalletRequest _value;

  @override
  WalletRequest code(String code) => this(code: code);

  @override
  WalletRequest iconKey(String? iconKey) => this(iconKey: iconKey);

  @override
  WalletRequest isActive(bool isActive) => this(isActive: isActive);

  @override
  WalletRequest name(String name) => this(name: name);

  @override
  WalletRequest sortOrder(int sortOrder) => this(sortOrder: sortOrder);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletRequest call({
    Object? code = const $CopyWithPlaceholder(),
    Object? iconKey = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return WalletRequest(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      iconKey: iconKey == const $CopyWithPlaceholder()
          ? _value.iconKey
          // ignore: cast_nullable_to_non_nullable
          : iconKey as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      sortOrder: sortOrder == const $CopyWithPlaceholder()
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as int,
    );
  }
}

extension $WalletRequestCopyWith on WalletRequest {
  /// Returns a callable class that can be used as follows: `instanceOfWalletRequest.copyWith(...)` or like so:`instanceOfWalletRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletRequestCWProxy get copyWith => _$WalletRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletRequest _$WalletRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'WalletRequest',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['code', 'is_active', 'name', 'sort_order'],
        );
        final val = WalletRequest(
          code: $checkedConvert('code', (v) => v as String),
          iconKey: $checkedConvert('icon_key', (v) => v as String?),
          isActive: $checkedConvert('is_active', (v) => v as bool? ?? true),
          name: $checkedConvert('name', (v) => v as String),
          sortOrder: $checkedConvert('sort_order', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'iconKey': 'icon_key',
        'isActive': 'is_active',
        'sortOrder': 'sort_order',
      },
    );

Map<String, dynamic> _$WalletRequestToJson(WalletRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'icon_key': ?instance.iconKey,
      'is_active': instance.isActive,
      'name': instance.name,
      'sort_order': instance.sortOrder,
    };
