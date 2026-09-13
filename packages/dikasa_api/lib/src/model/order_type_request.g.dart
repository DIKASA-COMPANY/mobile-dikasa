// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_type_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderTypeRequestCWProxy {
  OrderTypeRequest code(String code);

  OrderTypeRequest iconKey(String? iconKey);

  OrderTypeRequest isActive(bool isActive);

  OrderTypeRequest name(String name);

  OrderTypeRequest sortOrder(int sortOrder);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderTypeRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderTypeRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderTypeRequest call({
    String code,
    String? iconKey,
    bool isActive,
    String name,
    int sortOrder,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderTypeRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderTypeRequest.copyWith.fieldName(...)`
class _$OrderTypeRequestCWProxyImpl implements _$OrderTypeRequestCWProxy {
  const _$OrderTypeRequestCWProxyImpl(this._value);

  final OrderTypeRequest _value;

  @override
  OrderTypeRequest code(String code) => this(code: code);

  @override
  OrderTypeRequest iconKey(String? iconKey) => this(iconKey: iconKey);

  @override
  OrderTypeRequest isActive(bool isActive) => this(isActive: isActive);

  @override
  OrderTypeRequest name(String name) => this(name: name);

  @override
  OrderTypeRequest sortOrder(int sortOrder) => this(sortOrder: sortOrder);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderTypeRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderTypeRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderTypeRequest call({
    Object? code = const $CopyWithPlaceholder(),
    Object? iconKey = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return OrderTypeRequest(
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

extension $OrderTypeRequestCopyWith on OrderTypeRequest {
  /// Returns a callable class that can be used as follows: `instanceOfOrderTypeRequest.copyWith(...)` or like so:`instanceOfOrderTypeRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderTypeRequestCWProxy get copyWith => _$OrderTypeRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTypeRequest _$OrderTypeRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'OrderTypeRequest',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['code', 'is_active', 'name', 'sort_order'],
        );
        final val = OrderTypeRequest(
          code: $checkedConvert('code', (v) => v as String),
          iconKey: $checkedConvert('icon_key', (v) => v as String?),
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

Map<String, dynamic> _$OrderTypeRequestToJson(OrderTypeRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'icon_key': ?instance.iconKey,
      'is_active': instance.isActive,
      'name': instance.name,
      'sort_order': instance.sortOrder,
    };
