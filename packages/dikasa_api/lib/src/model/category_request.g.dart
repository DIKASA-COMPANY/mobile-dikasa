// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CategoryRequestCWProxy {
  CategoryRequest isActive(bool isActive);

  CategoryRequest name(String name);

  CategoryRequest sortOrder(int sortOrder);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategoryRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategoryRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CategoryRequest call({bool isActive, String name, int sortOrder});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCategoryRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCategoryRequest.copyWith.fieldName(...)`
class _$CategoryRequestCWProxyImpl implements _$CategoryRequestCWProxy {
  const _$CategoryRequestCWProxyImpl(this._value);

  final CategoryRequest _value;

  @override
  CategoryRequest isActive(bool isActive) => this(isActive: isActive);

  @override
  CategoryRequest name(String name) => this(name: name);

  @override
  CategoryRequest sortOrder(int sortOrder) => this(sortOrder: sortOrder);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategoryRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategoryRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CategoryRequest call({
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return CategoryRequest(
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

extension $CategoryRequestCopyWith on CategoryRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCategoryRequest.copyWith(...)` or like so:`instanceOfCategoryRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CategoryRequestCWProxy get copyWith => _$CategoryRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryRequest _$CategoryRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CategoryRequest',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['is_active', 'name', 'sort_order'],
        );
        final val = CategoryRequest(
          isActive: $checkedConvert('is_active', (v) => v as bool),
          name: $checkedConvert('name', (v) => v as String),
          sortOrder: $checkedConvert('sort_order', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {'isActive': 'is_active', 'sortOrder': 'sort_order'},
    );

Map<String, dynamic> _$CategoryRequestToJson(CategoryRequest instance) =>
    <String, dynamic>{
      'is_active': instance.isActive,
      'name': instance.name,
      'sort_order': instance.sortOrder,
    };
