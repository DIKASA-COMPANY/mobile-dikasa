// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_meta.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaginationMetaCWProxy {
  PaginationMeta page(int page);

  PaginationMeta pageSize(int pageSize);

  PaginationMeta total(int total);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginationMeta(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginationMeta(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginationMeta call({int page, int pageSize, int total});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaginationMeta.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaginationMeta.copyWith.fieldName(...)`
class _$PaginationMetaCWProxyImpl implements _$PaginationMetaCWProxy {
  const _$PaginationMetaCWProxyImpl(this._value);

  final PaginationMeta _value;

  @override
  PaginationMeta page(int page) => this(page: page);

  @override
  PaginationMeta pageSize(int pageSize) => this(pageSize: pageSize);

  @override
  PaginationMeta total(int total) => this(total: total);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaginationMeta(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaginationMeta(...).copyWith(id: 12, name: "My name")
  /// ````
  PaginationMeta call({
    Object? page = const $CopyWithPlaceholder(),
    Object? pageSize = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
  }) {
    return PaginationMeta(
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

extension $PaginationMetaCopyWith on PaginationMeta {
  /// Returns a callable class that can be used as follows: `instanceOfPaginationMeta.copyWith(...)` or like so:`instanceOfPaginationMeta.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaginationMetaCWProxy get copyWith => _$PaginationMetaCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationMeta _$PaginationMetaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PaginationMeta', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['page', 'page_size', 'total']);
      final val = PaginationMeta(
        page: $checkedConvert('page', (v) => (v as num).toInt()),
        pageSize: $checkedConvert('page_size', (v) => (v as num).toInt()),
        total: $checkedConvert('total', (v) => (v as num).toInt()),
      );
      return val;
    }, fieldKeyMap: const {'pageSize': 'page_size'});

Map<String, dynamic> _$PaginationMetaToJson(PaginationMeta instance) =>
    <String, dynamic>{
      'page': instance.page,
      'page_size': instance.pageSize,
      'total': instance.total,
    };
