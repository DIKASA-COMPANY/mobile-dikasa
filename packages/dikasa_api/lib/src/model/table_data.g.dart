// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TableDataCWProxy {
  TableData capacity(int capacity);

  TableData id(String id);

  TableData isActive(bool isActive);

  TableData name(String name);

  TableData sortOrder(int sortOrder);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TableData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TableData(...).copyWith(id: 12, name: "My name")
  /// ````
  TableData call({
    int capacity,
    String id,
    bool isActive,
    String name,
    int sortOrder,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTableData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTableData.copyWith.fieldName(...)`
class _$TableDataCWProxyImpl implements _$TableDataCWProxy {
  const _$TableDataCWProxyImpl(this._value);

  final TableData _value;

  @override
  TableData capacity(int capacity) => this(capacity: capacity);

  @override
  TableData id(String id) => this(id: id);

  @override
  TableData isActive(bool isActive) => this(isActive: isActive);

  @override
  TableData name(String name) => this(name: name);

  @override
  TableData sortOrder(int sortOrder) => this(sortOrder: sortOrder);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TableData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TableData(...).copyWith(id: 12, name: "My name")
  /// ````
  TableData call({
    Object? capacity = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return TableData(
      capacity: capacity == const $CopyWithPlaceholder()
          ? _value.capacity
          // ignore: cast_nullable_to_non_nullable
          : capacity as int,
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

extension $TableDataCopyWith on TableData {
  /// Returns a callable class that can be used as follows: `instanceOfTableData.copyWith(...)` or like so:`instanceOfTableData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TableDataCWProxy get copyWith => _$TableDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableData _$TableDataFromJson(Map<String, dynamic> json) => $checkedCreate(
  'TableData',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['capacity', 'id', 'is_active', 'name', 'sort_order'],
    );
    final val = TableData(
      capacity: $checkedConvert('capacity', (v) => (v as num).toInt()),
      id: $checkedConvert('id', (v) => v as String),
      isActive: $checkedConvert('is_active', (v) => v as bool),
      name: $checkedConvert('name', (v) => v as String),
      sortOrder: $checkedConvert('sort_order', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {'isActive': 'is_active', 'sortOrder': 'sort_order'},
);

Map<String, dynamic> _$TableDataToJson(TableData instance) => <String, dynamic>{
  'capacity': instance.capacity,
  'id': instance.id,
  'is_active': instance.isActive,
  'name': instance.name,
  'sort_order': instance.sortOrder,
};
