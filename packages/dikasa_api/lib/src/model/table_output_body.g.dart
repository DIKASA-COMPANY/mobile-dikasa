// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TableOutputBodyCWProxy {
  TableOutputBody data(TableData data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TableOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TableOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  TableOutputBody call({TableData data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTableOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTableOutputBody.copyWith.fieldName(...)`
class _$TableOutputBodyCWProxyImpl implements _$TableOutputBodyCWProxy {
  const _$TableOutputBodyCWProxyImpl(this._value);

  final TableOutputBody _value;

  @override
  TableOutputBody data(TableData data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TableOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TableOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  TableOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return TableOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as TableData,
    );
  }
}

extension $TableOutputBodyCopyWith on TableOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfTableOutputBody.copyWith(...)` or like so:`instanceOfTableOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TableOutputBodyCWProxy get copyWith => _$TableOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableOutputBody _$TableOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TableOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = TableOutputBody(
        data: $checkedConvert(
          'data',
          (v) => TableData.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TableOutputBodyToJson(TableOutputBody instance) =>
    <String, dynamic>{'data': instance.data.toJson()};
