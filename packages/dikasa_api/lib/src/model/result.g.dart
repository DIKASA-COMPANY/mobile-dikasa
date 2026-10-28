// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ResultCWProxy {
  Result data(Report data);

  Result meta(Meta meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Result(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Result(...).copyWith(id: 12, name: "My name")
  /// ````
  Result call({Report data, Meta meta});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResult.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfResult.copyWith.fieldName(...)`
class _$ResultCWProxyImpl implements _$ResultCWProxy {
  const _$ResultCWProxyImpl(this._value);

  final Result _value;

  @override
  Result data(Report data) => this(data: data);

  @override
  Result meta(Meta meta) => this(meta: meta);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Result(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Result(...).copyWith(id: 12, name: "My name")
  /// ````
  Result call({
    Object? data = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return Result(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Report,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as Meta,
    );
  }
}

extension $ResultCopyWith on Result {
  /// Returns a callable class that can be used as follows: `instanceOfResult.copyWith(...)` or like so:`instanceOfResult.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResultCWProxy get copyWith => _$ResultCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Result', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data', 'meta']);
      final val = Result(
        data: $checkedConvert(
          'data',
          (v) => Report.fromJson(v as Map<String, dynamic>),
        ),
        meta: $checkedConvert(
          'meta',
          (v) => Meta.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
  'data': instance.data.toJson(),
  'meta': instance.meta.toJson(),
};
