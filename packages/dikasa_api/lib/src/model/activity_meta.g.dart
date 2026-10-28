// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_meta.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ActivityMetaCWProxy {
  ActivityMeta page(int page);

  ActivityMeta pageSize(int pageSize);

  ActivityMeta total(int total);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ActivityMeta(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ActivityMeta(...).copyWith(id: 12, name: "My name")
  /// ````
  ActivityMeta call({int page, int pageSize, int total});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfActivityMeta.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfActivityMeta.copyWith.fieldName(...)`
class _$ActivityMetaCWProxyImpl implements _$ActivityMetaCWProxy {
  const _$ActivityMetaCWProxyImpl(this._value);

  final ActivityMeta _value;

  @override
  ActivityMeta page(int page) => this(page: page);

  @override
  ActivityMeta pageSize(int pageSize) => this(pageSize: pageSize);

  @override
  ActivityMeta total(int total) => this(total: total);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ActivityMeta(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ActivityMeta(...).copyWith(id: 12, name: "My name")
  /// ````
  ActivityMeta call({
    Object? page = const $CopyWithPlaceholder(),
    Object? pageSize = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
  }) {
    return ActivityMeta(
      page: page == const $CopyWithPlaceholder()
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      pageSize: pageSize == const $CopyWithPlaceholder()
          ? _value.pageSize
          // ignore: cast_nullable_to_non_nullable
          : pageSize as int,
      total: total == const $CopyWithPlaceholder()
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as int,
    );
  }
}

extension $ActivityMetaCopyWith on ActivityMeta {
  /// Returns a callable class that can be used as follows: `instanceOfActivityMeta.copyWith(...)` or like so:`instanceOfActivityMeta.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ActivityMetaCWProxy get copyWith => _$ActivityMetaCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityMeta _$ActivityMetaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ActivityMeta', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['page', 'page_size', 'total']);
      final val = ActivityMeta(
        page: $checkedConvert('page', (v) => (v as num).toInt()),
        pageSize: $checkedConvert('page_size', (v) => (v as num).toInt()),
        total: $checkedConvert('total', (v) => (v as num).toInt()),
      );
      return val;
    }, fieldKeyMap: const {'pageSize': 'page_size'});

Map<String, dynamic> _$ActivityMetaToJson(ActivityMeta instance) =>
    <String, dynamic>{
      'page': instance.page,
      'page_size': instance.pageSize,
      'total': instance.total,
    };
