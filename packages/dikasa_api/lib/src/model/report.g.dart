// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportCWProxy {
  Report daily(List<DailyPoint>? daily);

  Report kind(String kind);

  Report methods(List<MethodRow>? methods);

  Report rows(List<GroupRow>? rows);

  Report totals(Totals totals);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Report(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Report(...).copyWith(id: 12, name: "My name")
  /// ````
  Report call({
    List<DailyPoint>? daily,
    String kind,
    List<MethodRow>? methods,
    List<GroupRow>? rows,
    Totals totals,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReport.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReport.copyWith.fieldName(...)`
class _$ReportCWProxyImpl implements _$ReportCWProxy {
  const _$ReportCWProxyImpl(this._value);

  final Report _value;

  @override
  Report daily(List<DailyPoint>? daily) => this(daily: daily);

  @override
  Report kind(String kind) => this(kind: kind);

  @override
  Report methods(List<MethodRow>? methods) => this(methods: methods);

  @override
  Report rows(List<GroupRow>? rows) => this(rows: rows);

  @override
  Report totals(Totals totals) => this(totals: totals);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Report(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Report(...).copyWith(id: 12, name: "My name")
  /// ````
  Report call({
    Object? daily = const $CopyWithPlaceholder(),
    Object? kind = const $CopyWithPlaceholder(),
    Object? methods = const $CopyWithPlaceholder(),
    Object? rows = const $CopyWithPlaceholder(),
    Object? totals = const $CopyWithPlaceholder(),
  }) {
    return Report(
      daily: daily == const $CopyWithPlaceholder()
          ? _value.daily
          // ignore: cast_nullable_to_non_nullable
          : daily as List<DailyPoint>?,
      kind: kind == const $CopyWithPlaceholder()
          ? _value.kind
          // ignore: cast_nullable_to_non_nullable
          : kind as String,
      methods: methods == const $CopyWithPlaceholder()
          ? _value.methods
          // ignore: cast_nullable_to_non_nullable
          : methods as List<MethodRow>?,
      rows: rows == const $CopyWithPlaceholder()
          ? _value.rows
          // ignore: cast_nullable_to_non_nullable
          : rows as List<GroupRow>?,
      totals: totals == const $CopyWithPlaceholder()
          ? _value.totals
          // ignore: cast_nullable_to_non_nullable
          : totals as Totals,
    );
  }
}

extension $ReportCopyWith on Report {
  /// Returns a callable class that can be used as follows: `instanceOfReport.copyWith(...)` or like so:`instanceOfReport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReportCWProxy get copyWith => _$ReportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Report', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['daily', 'kind', 'methods', 'rows', 'totals'],
      );
      final val = Report(
        daily: $checkedConvert(
          'daily',
          (v) => (v as List<dynamic>?)
              ?.map((e) => DailyPoint.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        kind: $checkedConvert('kind', (v) => v as String),
        methods: $checkedConvert(
          'methods',
          (v) => (v as List<dynamic>?)
              ?.map((e) => MethodRow.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        rows: $checkedConvert(
          'rows',
          (v) => (v as List<dynamic>?)
              ?.map((e) => GroupRow.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        totals: $checkedConvert(
          'totals',
          (v) => Totals.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
  'daily': instance.daily?.map((e) => e.toJson()).toList(),
  'kind': instance.kind,
  'methods': instance.methods?.map((e) => e.toJson()).toList(),
  'rows': instance.rows?.map((e) => e.toJson()).toList(),
  'totals': instance.totals.toJson(),
};
