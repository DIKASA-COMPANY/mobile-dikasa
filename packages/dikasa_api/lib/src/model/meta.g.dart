// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MetaCWProxy {
  Meta endDate(String endDate);

  Meta generatedAt(DateTime generatedAt);

  Meta page(int page);

  Meta pageSize(int pageSize);

  Meta query(String query);

  Meta sort(String sort);

  Meta startDate(String startDate);

  Meta timezone(String timezone);

  Meta total(int total);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Meta(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Meta(...).copyWith(id: 12, name: "My name")
  /// ````
  Meta call({
    String endDate,
    DateTime generatedAt,
    int page,
    int pageSize,
    String query,
    String sort,
    String startDate,
    String timezone,
    int total,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMeta.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMeta.copyWith.fieldName(...)`
class _$MetaCWProxyImpl implements _$MetaCWProxy {
  const _$MetaCWProxyImpl(this._value);

  final Meta _value;

  @override
  Meta endDate(String endDate) => this(endDate: endDate);

  @override
  Meta generatedAt(DateTime generatedAt) => this(generatedAt: generatedAt);

  @override
  Meta page(int page) => this(page: page);

  @override
  Meta pageSize(int pageSize) => this(pageSize: pageSize);

  @override
  Meta query(String query) => this(query: query);

  @override
  Meta sort(String sort) => this(sort: sort);

  @override
  Meta startDate(String startDate) => this(startDate: startDate);

  @override
  Meta timezone(String timezone) => this(timezone: timezone);

  @override
  Meta total(int total) => this(total: total);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Meta(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Meta(...).copyWith(id: 12, name: "My name")
  /// ````
  Meta call({
    Object? endDate = const $CopyWithPlaceholder(),
    Object? generatedAt = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? pageSize = const $CopyWithPlaceholder(),
    Object? query = const $CopyWithPlaceholder(),
    Object? sort = const $CopyWithPlaceholder(),
    Object? startDate = const $CopyWithPlaceholder(),
    Object? timezone = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
  }) {
    return Meta(
      endDate: endDate == const $CopyWithPlaceholder()
          ? _value.endDate
          // ignore: cast_nullable_to_non_nullable
          : endDate as String,
      generatedAt: generatedAt == const $CopyWithPlaceholder()
          ? _value.generatedAt
          // ignore: cast_nullable_to_non_nullable
          : generatedAt as DateTime,
      page: page == const $CopyWithPlaceholder()
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      pageSize: pageSize == const $CopyWithPlaceholder()
          ? _value.pageSize
          // ignore: cast_nullable_to_non_nullable
          : pageSize as int,
      query: query == const $CopyWithPlaceholder()
          ? _value.query
          // ignore: cast_nullable_to_non_nullable
          : query as String,
      sort: sort == const $CopyWithPlaceholder()
          ? _value.sort
          // ignore: cast_nullable_to_non_nullable
          : sort as String,
      startDate: startDate == const $CopyWithPlaceholder()
          ? _value.startDate
          // ignore: cast_nullable_to_non_nullable
          : startDate as String,
      timezone: timezone == const $CopyWithPlaceholder()
          ? _value.timezone
          // ignore: cast_nullable_to_non_nullable
          : timezone as String,
      total: total == const $CopyWithPlaceholder()
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as int,
    );
  }
}

extension $MetaCopyWith on Meta {
  /// Returns a callable class that can be used as follows: `instanceOfMeta.copyWith(...)` or like so:`instanceOfMeta.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MetaCWProxy get copyWith => _$MetaCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Meta',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'end_date',
        'generated_at',
        'page',
        'page_size',
        'query',
        'sort',
        'start_date',
        'timezone',
        'total',
      ],
    );
    final val = Meta(
      endDate: $checkedConvert('end_date', (v) => v as String),
      generatedAt: $checkedConvert(
        'generated_at',
        (v) => DateTime.parse(v as String),
      ),
      page: $checkedConvert('page', (v) => (v as num).toInt()),
      pageSize: $checkedConvert('page_size', (v) => (v as num).toInt()),
      query: $checkedConvert('query', (v) => v as String),
      sort: $checkedConvert('sort', (v) => v as String),
      startDate: $checkedConvert('start_date', (v) => v as String),
      timezone: $checkedConvert('timezone', (v) => v as String),
      total: $checkedConvert('total', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'endDate': 'end_date',
    'generatedAt': 'generated_at',
    'pageSize': 'page_size',
    'startDate': 'start_date',
  },
);

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
  'end_date': instance.endDate,
  'generated_at': instance.generatedAt.toIso8601String(),
  'page': instance.page,
  'page_size': instance.pageSize,
  'query': instance.query,
  'sort': instance.sort,
  'start_date': instance.startDate,
  'timezone': instance.timezone,
  'total': instance.total,
};
