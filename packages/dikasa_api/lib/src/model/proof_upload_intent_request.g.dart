// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proof_upload_intent_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProofUploadIntentRequestCWProxy {
  ProofUploadIntentRequest contentType(
    ProofUploadIntentRequestContentTypeEnum contentType,
  );

  ProofUploadIntentRequest requestId(String requestId);

  ProofUploadIntentRequest size(int size);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProofUploadIntentRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProofUploadIntentRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ProofUploadIntentRequest call({
    ProofUploadIntentRequestContentTypeEnum contentType,
    String requestId,
    int size,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProofUploadIntentRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProofUploadIntentRequest.copyWith.fieldName(...)`
class _$ProofUploadIntentRequestCWProxyImpl
    implements _$ProofUploadIntentRequestCWProxy {
  const _$ProofUploadIntentRequestCWProxyImpl(this._value);

  final ProofUploadIntentRequest _value;

  @override
  ProofUploadIntentRequest contentType(
    ProofUploadIntentRequestContentTypeEnum contentType,
  ) => this(contentType: contentType);

  @override
  ProofUploadIntentRequest requestId(String requestId) =>
      this(requestId: requestId);

  @override
  ProofUploadIntentRequest size(int size) => this(size: size);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProofUploadIntentRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProofUploadIntentRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ProofUploadIntentRequest call({
    Object? contentType = const $CopyWithPlaceholder(),
    Object? requestId = const $CopyWithPlaceholder(),
    Object? size = const $CopyWithPlaceholder(),
  }) {
    return ProofUploadIntentRequest(
      contentType: contentType == const $CopyWithPlaceholder()
          ? _value.contentType
          // ignore: cast_nullable_to_non_nullable
          : contentType as ProofUploadIntentRequestContentTypeEnum,
      requestId: requestId == const $CopyWithPlaceholder()
          ? _value.requestId
          // ignore: cast_nullable_to_non_nullable
          : requestId as String,
      size: size == const $CopyWithPlaceholder()
          ? _value.size
          // ignore: cast_nullable_to_non_nullable
          : size as int,
    );
  }
}

extension $ProofUploadIntentRequestCopyWith on ProofUploadIntentRequest {
  /// Returns a callable class that can be used as follows: `instanceOfProofUploadIntentRequest.copyWith(...)` or like so:`instanceOfProofUploadIntentRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProofUploadIntentRequestCWProxy get copyWith =>
      _$ProofUploadIntentRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProofUploadIntentRequest _$ProofUploadIntentRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ProofUploadIntentRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['content_type', 'request_id', 'size'],
    );
    final val = ProofUploadIntentRequest(
      contentType: $checkedConvert(
        'content_type',
        (v) => $enumDecode(
          _$ProofUploadIntentRequestContentTypeEnumEnumMap,
          v,
          unknownValue:
              ProofUploadIntentRequestContentTypeEnum.unknownDefaultOpenApi,
        ),
      ),
      requestId: $checkedConvert('request_id', (v) => v as String),
      size: $checkedConvert('size', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {'contentType': 'content_type', 'requestId': 'request_id'},
);

Map<String, dynamic> _$ProofUploadIntentRequestToJson(
  ProofUploadIntentRequest instance,
) => <String, dynamic>{
  'content_type':
      _$ProofUploadIntentRequestContentTypeEnumEnumMap[instance.contentType]!,
  'request_id': instance.requestId,
  'size': instance.size,
};

const _$ProofUploadIntentRequestContentTypeEnumEnumMap = {
  ProofUploadIntentRequestContentTypeEnum.imageSlashPng: 'image/png',
  ProofUploadIntentRequestContentTypeEnum.imageSlashJpeg: 'image/jpeg',
  ProofUploadIntentRequestContentTypeEnum.unknownDefaultOpenApi:
      'unknown_default_open_api',
};
