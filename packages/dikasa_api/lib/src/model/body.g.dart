// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BodyCWProxy {
  Body code(String code);

  Body details(Map<String, String>? details);

  Body message(String message);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Body(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Body(...).copyWith(id: 12, name: "My name")
  /// ````
  Body call({String code, Map<String, String>? details, String message});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBody.copyWith.fieldName(...)`
class _$BodyCWProxyImpl implements _$BodyCWProxy {
  const _$BodyCWProxyImpl(this._value);

  final Body _value;

  @override
  Body code(String code) => this(code: code);

  @override
  Body details(Map<String, String>? details) => this(details: details);

  @override
  Body message(String message) => this(message: message);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Body(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Body(...).copyWith(id: 12, name: "My name")
  /// ````
  Body call({
    Object? code = const $CopyWithPlaceholder(),
    Object? details = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return Body(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      details: details == const $CopyWithPlaceholder()
          ? _value.details
          // ignore: cast_nullable_to_non_nullable
          : details as Map<String, String>?,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
    );
  }
}

extension $BodyCopyWith on Body {
  /// Returns a callable class that can be used as follows: `instanceOfBody.copyWith(...)` or like so:`instanceOfBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BodyCWProxy get copyWith => _$BodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Body _$BodyFromJson(Map<String, dynamic> json) => $checkedCreate('Body', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['code', 'message']);
  final val = Body(
    code: $checkedConvert('code', (v) => v as String),
    details: $checkedConvert(
      'details',
      (v) =>
          (v as Map<String, dynamic>?)?.map((k, e) => MapEntry(k, e as String)),
    ),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
  'code': instance.code,
  'details': ?instance.details,
  'message': instance.message,
};
