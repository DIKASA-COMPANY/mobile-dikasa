// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_image_upload_intent_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductImageUploadIntentRequestCWProxy {
  ProductImageUploadIntentRequest contentType(
    ProductImageUploadIntentRequestContentTypeEnum contentType,
  );

  ProductImageUploadIntentRequest size(int size);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductImageUploadIntentRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductImageUploadIntentRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductImageUploadIntentRequest call({
    ProductImageUploadIntentRequestContentTypeEnum contentType,
    int size,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductImageUploadIntentRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductImageUploadIntentRequest.copyWith.fieldName(...)`
class _$ProductImageUploadIntentRequestCWProxyImpl
    implements _$ProductImageUploadIntentRequestCWProxy {
  const _$ProductImageUploadIntentRequestCWProxyImpl(this._value);

  final ProductImageUploadIntentRequest _value;

  @override
  ProductImageUploadIntentRequest contentType(
    ProductImageUploadIntentRequestContentTypeEnum contentType,
  ) => this(contentType: contentType);

  @override
  ProductImageUploadIntentRequest size(int size) => this(size: size);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductImageUploadIntentRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductImageUploadIntentRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductImageUploadIntentRequest call({
    Object? contentType = const $CopyWithPlaceholder(),
    Object? size = const $CopyWithPlaceholder(),
  }) {
    return ProductImageUploadIntentRequest(
      contentType: contentType == const $CopyWithPlaceholder()
          ? _value.contentType
          // ignore: cast_nullable_to_non_nullable
          : contentType as ProductImageUploadIntentRequestContentTypeEnum,
      size: size == const $CopyWithPlaceholder()
          ? _value.size
          // ignore: cast_nullable_to_non_nullable
          : size as int,
    );
  }
}

extension $ProductImageUploadIntentRequestCopyWith
    on ProductImageUploadIntentRequest {
  /// Returns a callable class that can be used as follows: `instanceOfProductImageUploadIntentRequest.copyWith(...)` or like so:`instanceOfProductImageUploadIntentRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductImageUploadIntentRequestCWProxy get copyWith =>
      _$ProductImageUploadIntentRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductImageUploadIntentRequest _$ProductImageUploadIntentRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ProductImageUploadIntentRequest',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['content_type', 'size']);
    final val = ProductImageUploadIntentRequest(
      contentType: $checkedConvert(
        'content_type',
        (v) => $enumDecode(
          _$ProductImageUploadIntentRequestContentTypeEnumEnumMap,
          v,
          unknownValue: ProductImageUploadIntentRequestContentTypeEnum
              .unknownDefaultOpenApi,
        ),
      ),
      size: $checkedConvert('size', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {'contentType': 'content_type'},
);

Map<String, dynamic> _$ProductImageUploadIntentRequestToJson(
  ProductImageUploadIntentRequest instance,
) => <String, dynamic>{
  'content_type':
      _$ProductImageUploadIntentRequestContentTypeEnumEnumMap[instance
          .contentType]!,
  'size': instance.size,
};

const _$ProductImageUploadIntentRequestContentTypeEnumEnumMap = {
  ProductImageUploadIntentRequestContentTypeEnum.imageSlashPng: 'image/png',
  ProductImageUploadIntentRequestContentTypeEnum.imageSlashJpeg: 'image/jpeg',
  ProductImageUploadIntentRequestContentTypeEnum.unknownDefaultOpenApi:
      'unknown_default_open_api',
};
