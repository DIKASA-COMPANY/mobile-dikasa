// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_type_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderTypeDataCWProxy {
  OrderTypeData code(String code);

  OrderTypeData iconKey(String? iconKey);

  OrderTypeData id(String id);

  OrderTypeData isActive(bool isActive);

  OrderTypeData name(String name);

  OrderTypeData sortOrder(int sortOrder);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderTypeData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderTypeData(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderTypeData call({
    String code,
    String? iconKey,
    String id,
    bool isActive,
    String name,
    int sortOrder,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderTypeData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderTypeData.copyWith.fieldName(...)`
class _$OrderTypeDataCWProxyImpl implements _$OrderTypeDataCWProxy {
  const _$OrderTypeDataCWProxyImpl(this._value);

  final OrderTypeData _value;

  @override
  OrderTypeData code(String code) => this(code: code);

  @override
  OrderTypeData iconKey(String? iconKey) => this(iconKey: iconKey);

  @override
  OrderTypeData id(String id) => this(id: id);

  @override
  OrderTypeData isActive(bool isActive) => this(isActive: isActive);

  @override
  OrderTypeData name(String name) => this(name: name);

  @override
  OrderTypeData sortOrder(int sortOrder) => this(sortOrder: sortOrder);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderTypeData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderTypeData(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderTypeData call({
    Object? code = const $CopyWithPlaceholder(),
    Object? iconKey = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return OrderTypeData(
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

extension $OrderTypeDataCopyWith on OrderTypeData {
  /// Returns a callable class that can be used as follows: `instanceOfOrderTypeData.copyWith(...)` or like so:`instanceOfOrderTypeData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderTypeDataCWProxy get copyWith => _$OrderTypeDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTypeData _$OrderTypeDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'OrderTypeData',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['code', 'id', 'is_active', 'name', 'sort_order'],
        );
        final val = OrderTypeData(
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

Map<String, dynamic> _$OrderTypeDataToJson(OrderTypeData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'icon_key': ?instance.iconKey,
      'id': instance.id,
      'is_active': instance.isActive,
      'name': instance.name,
      'sort_order': instance.sortOrder,
    };
