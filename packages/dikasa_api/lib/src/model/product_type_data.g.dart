// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_type_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductTypeDataCWProxy {
  ProductTypeData code(ProductTypeDataCodeEnum code);

  ProductTypeData id(String id);

  ProductTypeData name(String name);

  ProductTypeData sortOrder(int sortOrder);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductTypeData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductTypeData(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductTypeData call({
    ProductTypeDataCodeEnum code,
    String id,
    String name,
    int sortOrder,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductTypeData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductTypeData.copyWith.fieldName(...)`
class _$ProductTypeDataCWProxyImpl implements _$ProductTypeDataCWProxy {
  const _$ProductTypeDataCWProxyImpl(this._value);

  final ProductTypeData _value;

  @override
  ProductTypeData code(ProductTypeDataCodeEnum code) => this(code: code);

  @override
  ProductTypeData id(String id) => this(id: id);

  @override
  ProductTypeData name(String name) => this(name: name);

  @override
  ProductTypeData sortOrder(int sortOrder) => this(sortOrder: sortOrder);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductTypeData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductTypeData(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductTypeData call({
    Object? code = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return ProductTypeData(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as ProductTypeDataCodeEnum,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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

extension $ProductTypeDataCopyWith on ProductTypeData {
  /// Returns a callable class that can be used as follows: `instanceOfProductTypeData.copyWith(...)` or like so:`instanceOfProductTypeData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductTypeDataCWProxy get copyWith => _$ProductTypeDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductTypeData _$ProductTypeDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ProductTypeData', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['code', 'id', 'name', 'sort_order'],
      );
      final val = ProductTypeData(
        code: $checkedConvert(
          'code',
          (v) => $enumDecode(
            _$ProductTypeDataCodeEnumEnumMap,
            v,
            unknownValue: ProductTypeDataCodeEnum.unknownDefaultOpenApi,
          ),
        ),
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        sortOrder: $checkedConvert('sort_order', (v) => (v as num).toInt()),
      );
      return val;
    }, fieldKeyMap: const {'sortOrder': 'sort_order'});

Map<String, dynamic> _$ProductTypeDataToJson(ProductTypeData instance) =>
    <String, dynamic>{
      'code': _$ProductTypeDataCodeEnumEnumMap[instance.code]!,
      'id': instance.id,
      'name': instance.name,
      'sort_order': instance.sortOrder,
    };

const _$ProductTypeDataCodeEnumEnumMap = {
  ProductTypeDataCodeEnum.food: 'food',
  ProductTypeDataCodeEnum.drink: 'drink',
  ProductTypeDataCodeEnum.additional: 'additional',
  ProductTypeDataCodeEnum.unknownDefaultOpenApi: 'unknown_default_open_api',
};
