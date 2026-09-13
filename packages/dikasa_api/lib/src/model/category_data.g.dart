// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CategoryDataCWProxy {
  CategoryData id(String id);

  CategoryData isActive(bool isActive);

  CategoryData name(String name);

  CategoryData sortOrder(int sortOrder);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategoryData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategoryData(...).copyWith(id: 12, name: "My name")
  /// ````
  CategoryData call({String id, bool isActive, String name, int sortOrder});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCategoryData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCategoryData.copyWith.fieldName(...)`
class _$CategoryDataCWProxyImpl implements _$CategoryDataCWProxy {
  const _$CategoryDataCWProxyImpl(this._value);

  final CategoryData _value;

  @override
  CategoryData id(String id) => this(id: id);

  @override
  CategoryData isActive(bool isActive) => this(isActive: isActive);

  @override
  CategoryData name(String name) => this(name: name);

  @override
  CategoryData sortOrder(int sortOrder) => this(sortOrder: sortOrder);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategoryData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategoryData(...).copyWith(id: 12, name: "My name")
  /// ````
  CategoryData call({
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return CategoryData(
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

extension $CategoryDataCopyWith on CategoryData {
  /// Returns a callable class that can be used as follows: `instanceOfCategoryData.copyWith(...)` or like so:`instanceOfCategoryData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CategoryDataCWProxy get copyWith => _$CategoryDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CategoryData',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['id', 'is_active', 'name', 'sort_order'],
        );
        final val = CategoryData(
          id: $checkedConvert('id', (v) => v as String),
          isActive: $checkedConvert('is_active', (v) => v as bool),
          name: $checkedConvert('name', (v) => v as String),
          sortOrder: $checkedConvert('sort_order', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {'isActive': 'is_active', 'sortOrder': 'sort_order'},
    );

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_active': instance.isActive,
      'name': instance.name,
      'sort_order': instance.sortOrder,
    };
