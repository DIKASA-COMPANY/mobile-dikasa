// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductsOutputBodyCWProxy {
  ProductsOutputBody data(List<ProductData>? data);

  ProductsOutputBody meta(MetaStruct meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductsOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductsOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductsOutputBody call({List<ProductData>? data, MetaStruct meta});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductsOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductsOutputBody.copyWith.fieldName(...)`
class _$ProductsOutputBodyCWProxyImpl implements _$ProductsOutputBodyCWProxy {
  const _$ProductsOutputBodyCWProxyImpl(this._value);

  final ProductsOutputBody _value;

  @override
  ProductsOutputBody data(List<ProductData>? data) => this(data: data);

  @override
  ProductsOutputBody meta(MetaStruct meta) => this(meta: meta);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductsOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductsOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductsOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return ProductsOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<ProductData>?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as MetaStruct,
    );
  }
}

extension $ProductsOutputBodyCopyWith on ProductsOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfProductsOutputBody.copyWith(...)` or like so:`instanceOfProductsOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductsOutputBodyCWProxy get copyWith =>
      _$ProductsOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsOutputBody _$ProductsOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ProductsOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data', 'meta']);
      final val = ProductsOutputBody(
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>?)
              ?.map((e) => ProductData.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        meta: $checkedConvert(
          'meta',
          (v) => MetaStruct.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ProductsOutputBodyToJson(ProductsOutputBody instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };
