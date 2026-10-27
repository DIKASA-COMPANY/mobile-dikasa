// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_table_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RestaurantTableDataCWProxy {
  RestaurantTableData id(String id);

  RestaurantTableData name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RestaurantTableData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RestaurantTableData(...).copyWith(id: 12, name: "My name")
  /// ````
  RestaurantTableData call({String id, String name});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRestaurantTableData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRestaurantTableData.copyWith.fieldName(...)`
class _$RestaurantTableDataCWProxyImpl implements _$RestaurantTableDataCWProxy {
  const _$RestaurantTableDataCWProxyImpl(this._value);

  final RestaurantTableData _value;

  @override
  RestaurantTableData id(String id) => this(id: id);

  @override
  RestaurantTableData name(String name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RestaurantTableData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RestaurantTableData(...).copyWith(id: 12, name: "My name")
  /// ````
  RestaurantTableData call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return RestaurantTableData(
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

extension $RestaurantTableDataCopyWith on RestaurantTableData {
  /// Returns a callable class that can be used as follows: `instanceOfRestaurantTableData.copyWith(...)` or like so:`instanceOfRestaurantTableData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RestaurantTableDataCWProxy get copyWith =>
      _$RestaurantTableDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantTableData _$RestaurantTableDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RestaurantTableData', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'name']);
      final val = RestaurantTableData(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RestaurantTableDataToJson(
  RestaurantTableData instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
