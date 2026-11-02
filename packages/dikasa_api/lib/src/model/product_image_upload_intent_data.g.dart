// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_image_upload_intent_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductImageUploadIntentDataCWProxy {
  ProductImageUploadIntentData expiresIn(int expiresIn);

  ProductImageUploadIntentData objectName(String objectName);

  ProductImageUploadIntentData uploadUrl(String uploadUrl);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductImageUploadIntentData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductImageUploadIntentData(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductImageUploadIntentData call({
    int expiresIn,
    String objectName,
    String uploadUrl,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductImageUploadIntentData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductImageUploadIntentData.copyWith.fieldName(...)`
class _$ProductImageUploadIntentDataCWProxyImpl
    implements _$ProductImageUploadIntentDataCWProxy {
  const _$ProductImageUploadIntentDataCWProxyImpl(this._value);

  final ProductImageUploadIntentData _value;

  @override
  ProductImageUploadIntentData expiresIn(int expiresIn) =>
      this(expiresIn: expiresIn);

  @override
  ProductImageUploadIntentData objectName(String objectName) =>
      this(objectName: objectName);

  @override
  ProductImageUploadIntentData uploadUrl(String uploadUrl) =>
      this(uploadUrl: uploadUrl);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductImageUploadIntentData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductImageUploadIntentData(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductImageUploadIntentData call({
    Object? expiresIn = const $CopyWithPlaceholder(),
    Object? objectName = const $CopyWithPlaceholder(),
    Object? uploadUrl = const $CopyWithPlaceholder(),
  }) {
    return ProductImageUploadIntentData(
      expiresIn: expiresIn == const $CopyWithPlaceholder()
          ? _value.expiresIn
          // ignore: cast_nullable_to_non_nullable
          : expiresIn as int,
      objectName: objectName == const $CopyWithPlaceholder()
          ? _value.objectName
          // ignore: cast_nullable_to_non_nullable
          : objectName as String,
      uploadUrl: uploadUrl == const $CopyWithPlaceholder()
          ? _value.uploadUrl
          // ignore: cast_nullable_to_non_nullable
          : uploadUrl as String,
    );
  }
}

extension $ProductImageUploadIntentDataCopyWith
    on ProductImageUploadIntentData {
  /// Returns a callable class that can be used as follows: `instanceOfProductImageUploadIntentData.copyWith(...)` or like so:`instanceOfProductImageUploadIntentData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductImageUploadIntentDataCWProxy get copyWith =>
      _$ProductImageUploadIntentDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductImageUploadIntentData _$ProductImageUploadIntentDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ProductImageUploadIntentData',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['expires_in', 'object_name', 'upload_url'],
    );
    final val = ProductImageUploadIntentData(
      expiresIn: $checkedConvert('expires_in', (v) => (v as num).toInt()),
      objectName: $checkedConvert('object_name', (v) => v as String),
      uploadUrl: $checkedConvert('upload_url', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'expiresIn': 'expires_in',
    'objectName': 'object_name',
    'uploadUrl': 'upload_url',
  },
);

Map<String, dynamic> _$ProductImageUploadIntentDataToJson(
  ProductImageUploadIntentData instance,
) => <String, dynamic>{
  'expires_in': instance.expiresIn,
  'object_name': instance.objectName,
  'upload_url': instance.uploadUrl,
};
