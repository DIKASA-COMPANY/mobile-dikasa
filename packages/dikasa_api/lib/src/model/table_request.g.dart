// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TableRequestCWProxy {
  TableRequest capacity(int capacity);

  TableRequest isActive(bool isActive);

  TableRequest name(String name);

  TableRequest sortOrder(int sortOrder);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TableRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TableRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  TableRequest call({int capacity, bool isActive, String name, int sortOrder});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTableRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTableRequest.copyWith.fieldName(...)`
class _$TableRequestCWProxyImpl implements _$TableRequestCWProxy {
  const _$TableRequestCWProxyImpl(this._value);

  final TableRequest _value;

  @override
  TableRequest capacity(int capacity) => this(capacity: capacity);

  @override
  TableRequest isActive(bool isActive) => this(isActive: isActive);

  @override
  TableRequest name(String name) => this(name: name);

  @override
  TableRequest sortOrder(int sortOrder) => this(sortOrder: sortOrder);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TableRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TableRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  TableRequest call({
    Object? capacity = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return TableRequest(
      capacity: capacity == const $CopyWithPlaceholder()
          ? _value.capacity
          // ignore: cast_nullable_to_non_nullable
          : capacity as int,
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

extension $TableRequestCopyWith on TableRequest {
  /// Returns a callable class that can be used as follows: `instanceOfTableRequest.copyWith(...)` or like so:`instanceOfTableRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TableRequestCWProxy get copyWith => _$TableRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableRequest _$TableRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TableRequest',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['capacity', 'is_active', 'name', 'sort_order'],
        );
        final val = TableRequest(
          capacity: $checkedConvert('capacity', (v) => (v as num).toInt()),
          isActive: $checkedConvert('is_active', (v) => v as bool),
          name: $checkedConvert('name', (v) => v as String),
          sortOrder: $checkedConvert('sort_order', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {'isActive': 'is_active', 'sortOrder': 'sort_order'},
    );

Map<String, dynamic> _$TableRequestToJson(TableRequest instance) =>
    <String, dynamic>{
      'capacity': instance.capacity,
      'is_active': instance.isActive,
      'name': instance.name,
      'sort_order': instance.sortOrder,
    };
