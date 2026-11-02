// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_upload_intent_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AvatarUploadIntentDataCWProxy {
  AvatarUploadIntentData expiresIn(int expiresIn);

  AvatarUploadIntentData objectName(String objectName);

  AvatarUploadIntentData uploadUrl(String uploadUrl);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AvatarUploadIntentData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AvatarUploadIntentData(...).copyWith(id: 12, name: "My name")
  /// ````
  AvatarUploadIntentData call({
    int expiresIn,
    String objectName,
    String uploadUrl,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAvatarUploadIntentData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAvatarUploadIntentData.copyWith.fieldName(...)`
class _$AvatarUploadIntentDataCWProxyImpl
    implements _$AvatarUploadIntentDataCWProxy {
  const _$AvatarUploadIntentDataCWProxyImpl(this._value);

  final AvatarUploadIntentData _value;

  @override
  AvatarUploadIntentData expiresIn(int expiresIn) => this(expiresIn: expiresIn);

  @override
  AvatarUploadIntentData objectName(String objectName) =>
      this(objectName: objectName);

  @override
  AvatarUploadIntentData uploadUrl(String uploadUrl) =>
      this(uploadUrl: uploadUrl);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AvatarUploadIntentData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AvatarUploadIntentData(...).copyWith(id: 12, name: "My name")
  /// ````
  AvatarUploadIntentData call({
    Object? expiresIn = const $CopyWithPlaceholder(),
    Object? objectName = const $CopyWithPlaceholder(),
    Object? uploadUrl = const $CopyWithPlaceholder(),
  }) {
    return AvatarUploadIntentData(
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

extension $AvatarUploadIntentDataCopyWith on AvatarUploadIntentData {
  /// Returns a callable class that can be used as follows: `instanceOfAvatarUploadIntentData.copyWith(...)` or like so:`instanceOfAvatarUploadIntentData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AvatarUploadIntentDataCWProxy get copyWith =>
      _$AvatarUploadIntentDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarUploadIntentData _$AvatarUploadIntentDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'AvatarUploadIntentData',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['expires_in', 'object_name', 'upload_url'],
    );
    final val = AvatarUploadIntentData(
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

Map<String, dynamic> _$AvatarUploadIntentDataToJson(
  AvatarUploadIntentData instance,
) => <String, dynamic>{
  'expires_in': instance.expiresIn,
  'object_name': instance.objectName,
  'upload_url': instance.uploadUrl,
};
