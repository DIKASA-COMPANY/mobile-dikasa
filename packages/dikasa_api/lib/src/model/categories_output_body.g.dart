// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CategoriesOutputBodyCWProxy {
  CategoriesOutputBody data(List<CategoryData>? data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategoriesOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategoriesOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CategoriesOutputBody call({List<CategoryData>? data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCategoriesOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCategoriesOutputBody.copyWith.fieldName(...)`
class _$CategoriesOutputBodyCWProxyImpl
    implements _$CategoriesOutputBodyCWProxy {
  const _$CategoriesOutputBodyCWProxyImpl(this._value);

  final CategoriesOutputBody _value;

  @override
  CategoriesOutputBody data(List<CategoryData>? data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CategoriesOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CategoriesOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CategoriesOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return CategoriesOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<CategoryData>?,
    );
  }
}

extension $CategoriesOutputBodyCopyWith on CategoriesOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfCategoriesOutputBody.copyWith(...)` or like so:`instanceOfCategoriesOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CategoriesOutputBodyCWProxy get copyWith =>
      _$CategoriesOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesOutputBody _$CategoriesOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CategoriesOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = CategoriesOutputBody(
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>?)
          ?.map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$CategoriesOutputBodyToJson(
  CategoriesOutputBody instance,
) => <String, dynamic>{'data': instance.data?.map((e) => e.toJson()).toList()};
