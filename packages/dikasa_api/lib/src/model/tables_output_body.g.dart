// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tables_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TablesOutputBodyCWProxy {
  TablesOutputBody data(List<TableData>? data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TablesOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TablesOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  TablesOutputBody call({List<TableData>? data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTablesOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTablesOutputBody.copyWith.fieldName(...)`
class _$TablesOutputBodyCWProxyImpl implements _$TablesOutputBodyCWProxy {
  const _$TablesOutputBodyCWProxyImpl(this._value);

  final TablesOutputBody _value;

  @override
  TablesOutputBody data(List<TableData>? data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TablesOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TablesOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  TablesOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return TablesOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<TableData>?,
    );
  }
}

extension $TablesOutputBodyCopyWith on TablesOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfTablesOutputBody.copyWith(...)` or like so:`instanceOfTablesOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TablesOutputBodyCWProxy get copyWith => _$TablesOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TablesOutputBody _$TablesOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TablesOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = TablesOutputBody(
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>?)
              ?.map((e) => TableData.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TablesOutputBodyToJson(TablesOutputBody instance) =>
    <String, dynamic>{'data': instance.data?.map((e) => e.toJson()).toList()};
