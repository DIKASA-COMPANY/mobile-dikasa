// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_error.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StatusErrorCWProxy {
  StatusError error(Body error);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StatusError(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StatusError(...).copyWith(id: 12, name: "My name")
  /// ````
  StatusError call({Body error});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStatusError.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStatusError.copyWith.fieldName(...)`
class _$StatusErrorCWProxyImpl implements _$StatusErrorCWProxy {
  const _$StatusErrorCWProxyImpl(this._value);

  final StatusError _value;

  @override
  StatusError error(Body error) => this(error: error);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StatusError(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StatusError(...).copyWith(id: 12, name: "My name")
  /// ````
  StatusError call({Object? error = const $CopyWithPlaceholder()}) {
    return StatusError(
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as Body,
    );
  }
}

extension $StatusErrorCopyWith on StatusError {
  /// Returns a callable class that can be used as follows: `instanceOfStatusError.copyWith(...)` or like so:`instanceOfStatusError.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StatusErrorCWProxy get copyWith => _$StatusErrorCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusError _$StatusErrorFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StatusError', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['error']);
      final val = StatusError(
        error: $checkedConvert(
          'error',
          (v) => Body.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$StatusErrorToJson(StatusError instance) =>
    <String, dynamic>{'error': instance.error.toJson()};
