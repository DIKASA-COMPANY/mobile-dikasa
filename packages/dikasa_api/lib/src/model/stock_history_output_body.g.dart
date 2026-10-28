// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_history_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StockHistoryOutputBodyCWProxy {
  StockHistoryOutputBody data(List<StockMovement>? data);

  StockHistoryOutputBody meta(MetaStruct meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StockHistoryOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StockHistoryOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  StockHistoryOutputBody call({List<StockMovement>? data, MetaStruct meta});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStockHistoryOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStockHistoryOutputBody.copyWith.fieldName(...)`
class _$StockHistoryOutputBodyCWProxyImpl
    implements _$StockHistoryOutputBodyCWProxy {
  const _$StockHistoryOutputBodyCWProxyImpl(this._value);

  final StockHistoryOutputBody _value;

  @override
  StockHistoryOutputBody data(List<StockMovement>? data) => this(data: data);

  @override
  StockHistoryOutputBody meta(MetaStruct meta) => this(meta: meta);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StockHistoryOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StockHistoryOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  StockHistoryOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return StockHistoryOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<StockMovement>?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as MetaStruct,
    );
  }
}

extension $StockHistoryOutputBodyCopyWith on StockHistoryOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfStockHistoryOutputBody.copyWith(...)` or like so:`instanceOfStockHistoryOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StockHistoryOutputBodyCWProxy get copyWith =>
      _$StockHistoryOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockHistoryOutputBody _$StockHistoryOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('StockHistoryOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data', 'meta']);
  final val = StockHistoryOutputBody(
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>?)
          ?.map((e) => StockMovement.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    meta: $checkedConvert(
      'meta',
      (v) => MetaStruct.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$StockHistoryOutputBodyToJson(
  StockHistoryOutputBody instance,
) => <String, dynamic>{
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'meta': instance.meta.toJson(),
};
