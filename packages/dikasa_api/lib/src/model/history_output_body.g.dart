// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HistoryOutputBodyCWProxy {
  HistoryOutputBody data(List<Refund>? data);

  HistoryOutputBody meta(MetaStruct meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HistoryOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HistoryOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  HistoryOutputBody call({List<Refund>? data, MetaStruct meta});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHistoryOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHistoryOutputBody.copyWith.fieldName(...)`
class _$HistoryOutputBodyCWProxyImpl implements _$HistoryOutputBodyCWProxy {
  const _$HistoryOutputBodyCWProxyImpl(this._value);

  final HistoryOutputBody _value;

  @override
  HistoryOutputBody data(List<Refund>? data) => this(data: data);

  @override
  HistoryOutputBody meta(MetaStruct meta) => this(meta: meta);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HistoryOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HistoryOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  HistoryOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return HistoryOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Refund>?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as MetaStruct,
    );
  }
}

extension $HistoryOutputBodyCopyWith on HistoryOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfHistoryOutputBody.copyWith(...)` or like so:`instanceOfHistoryOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HistoryOutputBodyCWProxy get copyWith =>
      _$HistoryOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryOutputBody _$HistoryOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('HistoryOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data', 'meta']);
      final val = HistoryOutputBody(
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>?)
              ?.map((e) => Refund.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        meta: $checkedConvert(
          'meta',
          (v) => MetaStruct.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$HistoryOutputBodyToJson(HistoryOutputBody instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };
