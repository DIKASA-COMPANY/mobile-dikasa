// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_page.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ActivityPageCWProxy {
  ActivityPage data(ActivityData data);

  ActivityPage meta(ActivityMeta meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ActivityPage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ActivityPage(...).copyWith(id: 12, name: "My name")
  /// ````
  ActivityPage call({ActivityData data, ActivityMeta meta});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfActivityPage.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfActivityPage.copyWith.fieldName(...)`
class _$ActivityPageCWProxyImpl implements _$ActivityPageCWProxy {
  const _$ActivityPageCWProxyImpl(this._value);

  final ActivityPage _value;

  @override
  ActivityPage data(ActivityData data) => this(data: data);

  @override
  ActivityPage meta(ActivityMeta meta) => this(meta: meta);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ActivityPage(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ActivityPage(...).copyWith(id: 12, name: "My name")
  /// ````
  ActivityPage call({
    Object? data = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return ActivityPage(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ActivityData,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as ActivityMeta,
    );
  }
}

extension $ActivityPageCopyWith on ActivityPage {
  /// Returns a callable class that can be used as follows: `instanceOfActivityPage.copyWith(...)` or like so:`instanceOfActivityPage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ActivityPageCWProxy get copyWith => _$ActivityPageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityPage _$ActivityPageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ActivityPage', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data', 'meta']);
      final val = ActivityPage(
        data: $checkedConvert(
          'data',
          (v) => ActivityData.fromJson(v as Map<String, dynamic>),
        ),
        meta: $checkedConvert(
          'meta',
          (v) => ActivityMeta.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ActivityPageToJson(ActivityPage instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
      'meta': instance.meta.toJson(),
    };
