// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_upload_intent_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AvatarUploadIntentOutputBodyCWProxy {
  AvatarUploadIntentOutputBody data(AvatarUploadIntentData data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AvatarUploadIntentOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AvatarUploadIntentOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AvatarUploadIntentOutputBody call({AvatarUploadIntentData data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAvatarUploadIntentOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAvatarUploadIntentOutputBody.copyWith.fieldName(...)`
class _$AvatarUploadIntentOutputBodyCWProxyImpl
    implements _$AvatarUploadIntentOutputBodyCWProxy {
  const _$AvatarUploadIntentOutputBodyCWProxyImpl(this._value);

  final AvatarUploadIntentOutputBody _value;

  @override
  AvatarUploadIntentOutputBody data(AvatarUploadIntentData data) =>
      this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AvatarUploadIntentOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AvatarUploadIntentOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  AvatarUploadIntentOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return AvatarUploadIntentOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as AvatarUploadIntentData,
    );
  }
}

extension $AvatarUploadIntentOutputBodyCopyWith
    on AvatarUploadIntentOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfAvatarUploadIntentOutputBody.copyWith(...)` or like so:`instanceOfAvatarUploadIntentOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AvatarUploadIntentOutputBodyCWProxy get copyWith =>
      _$AvatarUploadIntentOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarUploadIntentOutputBody _$AvatarUploadIntentOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AvatarUploadIntentOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = AvatarUploadIntentOutputBody(
    data: $checkedConvert(
      'data',
      (v) => AvatarUploadIntentData.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AvatarUploadIntentOutputBodyToJson(
  AvatarUploadIntentOutputBody instance,
) => <String, dynamic>{'data': instance.data.toJson()};
