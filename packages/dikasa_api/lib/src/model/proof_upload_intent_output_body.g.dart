// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proof_upload_intent_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProofUploadIntentOutputBodyCWProxy {
  ProofUploadIntentOutputBody data(ProofUploadIntentData data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProofUploadIntentOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProofUploadIntentOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ProofUploadIntentOutputBody call({ProofUploadIntentData data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProofUploadIntentOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProofUploadIntentOutputBody.copyWith.fieldName(...)`
class _$ProofUploadIntentOutputBodyCWProxyImpl
    implements _$ProofUploadIntentOutputBodyCWProxy {
  const _$ProofUploadIntentOutputBodyCWProxyImpl(this._value);

  final ProofUploadIntentOutputBody _value;

  @override
  ProofUploadIntentOutputBody data(ProofUploadIntentData data) =>
      this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProofUploadIntentOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProofUploadIntentOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ProofUploadIntentOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return ProofUploadIntentOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ProofUploadIntentData,
    );
  }
}

extension $ProofUploadIntentOutputBodyCopyWith on ProofUploadIntentOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfProofUploadIntentOutputBody.copyWith(...)` or like so:`instanceOfProofUploadIntentOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProofUploadIntentOutputBodyCWProxy get copyWith =>
      _$ProofUploadIntentOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProofUploadIntentOutputBody _$ProofUploadIntentOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ProofUploadIntentOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = ProofUploadIntentOutputBody(
    data: $checkedConvert(
      'data',
      (v) => ProofUploadIntentData.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$ProofUploadIntentOutputBodyToJson(
  ProofUploadIntentOutputBody instance,
) => <String, dynamic>{'data': instance.data.toJson()};
