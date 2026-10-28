// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductOutputBodyCWProxy {
  ProductOutputBody data(ProductData data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductOutputBody call({ProductData data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductOutputBody.copyWith.fieldName(...)`
class _$ProductOutputBodyCWProxyImpl implements _$ProductOutputBodyCWProxy {
  const _$ProductOutputBodyCWProxyImpl(this._value);

  final ProductOutputBody _value;

  @override
  ProductOutputBody data(ProductData data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return ProductOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ProductData,
    );
  }
}

extension $ProductOutputBodyCopyWith on ProductOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfProductOutputBody.copyWith(...)` or like so:`instanceOfProductOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductOutputBodyCWProxy get copyWith =>
      _$ProductOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOutputBody _$ProductOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ProductOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = ProductOutputBody(
        data: $checkedConvert(
          'data',
          (v) => ProductData.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ProductOutputBodyToJson(ProductOutputBody instance) =>
    <String, dynamic>{'data': instance.data.toJson()};
