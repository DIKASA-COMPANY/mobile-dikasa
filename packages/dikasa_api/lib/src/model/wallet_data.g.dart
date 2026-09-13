// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletDataCWProxy {
  WalletData code(String code);

  WalletData iconKey(String? iconKey);

  WalletData id(String id);

  WalletData isActive(bool isActive);

  WalletData name(String name);

  WalletData sortOrder(int sortOrder);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletData(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletData call({
    String code,
    String? iconKey,
    String id,
    bool isActive,
    String name,
    int sortOrder,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWalletData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWalletData.copyWith.fieldName(...)`
class _$WalletDataCWProxyImpl implements _$WalletDataCWProxy {
  const _$WalletDataCWProxyImpl(this._value);

  final WalletData _value;

  @override
  WalletData code(String code) => this(code: code);

  @override
  WalletData iconKey(String? iconKey) => this(iconKey: iconKey);

  @override
  WalletData id(String id) => this(id: id);

  @override
  WalletData isActive(bool isActive) => this(isActive: isActive);

  @override
  WalletData name(String name) => this(name: name);

  @override
  WalletData sortOrder(int sortOrder) => this(sortOrder: sortOrder);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletData(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletData call({
    Object? code = const $CopyWithPlaceholder(),
    Object? iconKey = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return WalletData(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      iconKey: iconKey == const $CopyWithPlaceholder()
          ? _value.iconKey
          // ignore: cast_nullable_to_non_nullable
          : iconKey as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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

extension $WalletDataCopyWith on WalletData {
  /// Returns a callable class that can be used as follows: `instanceOfWalletData.copyWith(...)` or like so:`instanceOfWalletData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletDataCWProxy get copyWith => _$WalletDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletData _$WalletDataFromJson(Map<String, dynamic> json) => $checkedCreate(
  'WalletData',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['code', 'id', 'is_active', 'name', 'sort_order'],
    );
    final val = WalletData(
      code: $checkedConvert('code', (v) => v as String),
      iconKey: $checkedConvert('icon_key', (v) => v as String?),
      id: $checkedConvert('id', (v) => v as String),
      isActive: $checkedConvert('is_active', (v) => v as bool),
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

Map<String, dynamic> _$WalletDataToJson(WalletData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'icon_key': ?instance.iconKey,
      'id': instance.id,
      'is_active': instance.isActive,
      'name': instance.name,
      'sort_order': instance.sortOrder,
    };
