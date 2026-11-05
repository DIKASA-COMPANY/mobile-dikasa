// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_upload_intent_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AvatarUploadIntentRequestCWProxy {
  AvatarUploadIntentRequest contentType(
    AvatarUploadIntentRequestContentTypeEnum contentType,
  );

  AvatarUploadIntentRequest size(int size);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AvatarUploadIntentRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AvatarUploadIntentRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AvatarUploadIntentRequest call({
    AvatarUploadIntentRequestContentTypeEnum contentType,
    int size,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAvatarUploadIntentRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAvatarUploadIntentRequest.copyWith.fieldName(...)`
class _$AvatarUploadIntentRequestCWProxyImpl
    implements _$AvatarUploadIntentRequestCWProxy {
  const _$AvatarUploadIntentRequestCWProxyImpl(this._value);

  final AvatarUploadIntentRequest _value;

  @override
  AvatarUploadIntentRequest contentType(
    AvatarUploadIntentRequestContentTypeEnum contentType,
  ) => this(contentType: contentType);

  @override
  AvatarUploadIntentRequest size(int size) => this(size: size);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AvatarUploadIntentRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AvatarUploadIntentRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AvatarUploadIntentRequest call({
    Object? contentType = const $CopyWithPlaceholder(),
    Object? size = const $CopyWithPlaceholder(),
  }) {
    return AvatarUploadIntentRequest(
      contentType: contentType == const $CopyWithPlaceholder()
          ? _value.contentType
          // ignore: cast_nullable_to_non_nullable
          : contentType as AvatarUploadIntentRequestContentTypeEnum,
      size: size == const $CopyWithPlaceholder()
          ? _value.size
          // ignore: cast_nullable_to_non_nullable
          : size as int,
    );
  }
}

extension $AvatarUploadIntentRequestCopyWith on AvatarUploadIntentRequest {
  /// Returns a callable class that can be used as follows: `instanceOfAvatarUploadIntentRequest.copyWith(...)` or like so:`instanceOfAvatarUploadIntentRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AvatarUploadIntentRequestCWProxy get copyWith =>
      _$AvatarUploadIntentRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarUploadIntentRequest _$AvatarUploadIntentRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'AvatarUploadIntentRequest',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['content_type', 'size']);
    final val = AvatarUploadIntentRequest(
      contentType: $checkedConvert(
        'content_type',
        (v) => $enumDecode(
          _$AvatarUploadIntentRequestContentTypeEnumEnumMap,
          v,
          unknownValue:
              AvatarUploadIntentRequestContentTypeEnum.unknownDefaultOpenApi,
        ),
      ),
      size: $checkedConvert('size', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {'contentType': 'content_type'},
);

Map<String, dynamic> _$AvatarUploadIntentRequestToJson(
  AvatarUploadIntentRequest instance,
) => <String, dynamic>{
  'content_type':
      _$AvatarUploadIntentRequestContentTypeEnumEnumMap[instance.contentType]!,
  'size': instance.size,
};

const _$AvatarUploadIntentRequestContentTypeEnumEnumMap = {
  AvatarUploadIntentRequestContentTypeEnum.imageSlashPng: 'image/png',
  AvatarUploadIntentRequestContentTypeEnum.imageSlashJpeg: 'image/jpeg',
  AvatarUploadIntentRequestContentTypeEnum.unknownDefaultOpenApi:
      'unknown_default_open_api',
};
