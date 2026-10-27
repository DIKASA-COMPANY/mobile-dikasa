// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_types_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductTypesOutputBodyCWProxy {
  ProductTypesOutputBody data(List<ProductTypeData>? data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductTypesOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductTypesOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductTypesOutputBody call({List<ProductTypeData>? data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductTypesOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductTypesOutputBody.copyWith.fieldName(...)`
class _$ProductTypesOutputBodyCWProxyImpl
    implements _$ProductTypesOutputBodyCWProxy {
  const _$ProductTypesOutputBodyCWProxyImpl(this._value);

  final ProductTypesOutputBody _value;

  @override
  ProductTypesOutputBody data(List<ProductTypeData>? data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductTypesOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductTypesOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductTypesOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return ProductTypesOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<ProductTypeData>?,
    );
  }
}

extension $ProductTypesOutputBodyCopyWith on ProductTypesOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfProductTypesOutputBody.copyWith(...)` or like so:`instanceOfProductTypesOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductTypesOutputBodyCWProxy get copyWith =>
      _$ProductTypesOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductTypesOutputBody _$ProductTypesOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ProductTypesOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = ProductTypesOutputBody(
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>?)
          ?.map((e) => ProductTypeData.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ProductTypesOutputBodyToJson(
  ProductTypesOutputBody instance,
) => <String, dynamic>{'data': instance.data?.map((e) => e.toJson()).toList()};
