// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list_type_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderListTypeDataCWProxy {
  OrderListTypeData code(String code);

  OrderListTypeData id(String id);

  OrderListTypeData name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderListTypeData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderListTypeData(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderListTypeData call({String code, String id, String name});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderListTypeData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderListTypeData.copyWith.fieldName(...)`
class _$OrderListTypeDataCWProxyImpl implements _$OrderListTypeDataCWProxy {
  const _$OrderListTypeDataCWProxyImpl(this._value);

  final OrderListTypeData _value;

  @override
  OrderListTypeData code(String code) => this(code: code);

  @override
  OrderListTypeData id(String id) => this(id: id);

  @override
  OrderListTypeData name(String name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderListTypeData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderListTypeData(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderListTypeData call({
    Object? code = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return OrderListTypeData(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $OrderListTypeDataCopyWith on OrderListTypeData {
  /// Returns a callable class that can be used as follows: `instanceOfOrderListTypeData.copyWith(...)` or like so:`instanceOfOrderListTypeData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderListTypeDataCWProxy get copyWith =>
      _$OrderListTypeDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListTypeData _$OrderListTypeDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderListTypeData', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['code', 'id', 'name']);
      final val = OrderListTypeData(
        code: $checkedConvert('code', (v) => v as String),
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$OrderListTypeDataToJson(OrderListTypeData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'id': instance.id,
      'name': instance.name,
    };
