// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proof_upload_intent_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProofUploadIntentDataCWProxy {
  ProofUploadIntentData expiresIn(int expiresIn);

  ProofUploadIntentData objectName(String objectName);

  ProofUploadIntentData uploadUrl(String uploadUrl);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProofUploadIntentData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProofUploadIntentData(...).copyWith(id: 12, name: "My name")
  /// ````
  ProofUploadIntentData call({
    int expiresIn,
    String objectName,
    String uploadUrl,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProofUploadIntentData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProofUploadIntentData.copyWith.fieldName(...)`
class _$ProofUploadIntentDataCWProxyImpl
    implements _$ProofUploadIntentDataCWProxy {
  const _$ProofUploadIntentDataCWProxyImpl(this._value);

  final ProofUploadIntentData _value;

  @override
  ProofUploadIntentData expiresIn(int expiresIn) => this(expiresIn: expiresIn);

  @override
  ProofUploadIntentData objectName(String objectName) =>
      this(objectName: objectName);

  @override
  ProofUploadIntentData uploadUrl(String uploadUrl) =>
      this(uploadUrl: uploadUrl);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProofUploadIntentData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProofUploadIntentData(...).copyWith(id: 12, name: "My name")
  /// ````
  ProofUploadIntentData call({
    Object? expiresIn = const $CopyWithPlaceholder(),
    Object? objectName = const $CopyWithPlaceholder(),
    Object? uploadUrl = const $CopyWithPlaceholder(),
  }) {
    return ProofUploadIntentData(
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

extension $ProofUploadIntentDataCopyWith on ProofUploadIntentData {
  /// Returns a callable class that can be used as follows: `instanceOfProofUploadIntentData.copyWith(...)` or like so:`instanceOfProofUploadIntentData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProofUploadIntentDataCWProxy get copyWith =>
      _$ProofUploadIntentDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProofUploadIntentData _$ProofUploadIntentDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ProofUploadIntentData',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['expires_in', 'object_name', 'upload_url'],
    );
    final val = ProofUploadIntentData(
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

Map<String, dynamic> _$ProofUploadIntentDataToJson(
  ProofUploadIntentData instance,
) => <String, dynamic>{
  'expires_in': instance.expiresIn,
  'object_name': instance.objectName,
  'upload_url': instance.uploadUrl,
};
