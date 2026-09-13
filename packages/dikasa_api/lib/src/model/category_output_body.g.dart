// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CategoryOutputBodyCWProxy {
  CategoryOutputBody data(CategoryData data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategoryOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategoryOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CategoryOutputBody call({CategoryData data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCategoryOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCategoryOutputBody.copyWith.fieldName(...)`
class _$CategoryOutputBodyCWProxyImpl implements _$CategoryOutputBodyCWProxy {
  const _$CategoryOutputBodyCWProxyImpl(this._value);

  final CategoryOutputBody _value;

  @override
  CategoryOutputBody data(CategoryData data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategoryOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategoryOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CategoryOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return CategoryOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as CategoryData,
    );
  }
}

extension $CategoryOutputBodyCopyWith on CategoryOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfCategoryOutputBody.copyWith(...)` or like so:`instanceOfCategoryOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CategoryOutputBodyCWProxy get copyWith =>
      _$CategoryOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryOutputBody _$CategoryOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CategoryOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = CategoryOutputBody(
        data: $checkedConvert(
          'data',
          (v) => CategoryData.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CategoryOutputBodyToJson(CategoryOutputBody instance) =>
    <String, dynamic>{'data': instance.data.toJson()};
