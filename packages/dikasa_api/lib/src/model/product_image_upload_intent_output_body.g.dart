// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_image_upload_intent_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductImageUploadIntentOutputBodyCWProxy {
  ProductImageUploadIntentOutputBody data(ProductImageUploadIntentData data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductImageUploadIntentOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductImageUploadIntentOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductImageUploadIntentOutputBody call({ProductImageUploadIntentData data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductImageUploadIntentOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductImageUploadIntentOutputBody.copyWith.fieldName(...)`
class _$ProductImageUploadIntentOutputBodyCWProxyImpl
    implements _$ProductImageUploadIntentOutputBodyCWProxy {
  const _$ProductImageUploadIntentOutputBodyCWProxyImpl(this._value);

  final ProductImageUploadIntentOutputBody _value;

  @override
  ProductImageUploadIntentOutputBody data(ProductImageUploadIntentData data) =>
      this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductImageUploadIntentOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductImageUploadIntentOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductImageUploadIntentOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return ProductImageUploadIntentOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ProductImageUploadIntentData,
    );
  }
}

extension $ProductImageUploadIntentOutputBodyCopyWith
    on ProductImageUploadIntentOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfProductImageUploadIntentOutputBody.copyWith(...)` or like so:`instanceOfProductImageUploadIntentOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductImageUploadIntentOutputBodyCWProxy get copyWith =>
      _$ProductImageUploadIntentOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductImageUploadIntentOutputBody _$ProductImageUploadIntentOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ProductImageUploadIntentOutputBody', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = ProductImageUploadIntentOutputBody(
    data: $checkedConvert(
      'data',
      (v) => ProductImageUploadIntentData.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$ProductImageUploadIntentOutputBodyToJson(
  ProductImageUploadIntentOutputBody instance,
) => <String, dynamic>{'data': instance.data.toJson()};
