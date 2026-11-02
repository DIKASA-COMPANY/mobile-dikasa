// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_write_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StockWriteOutputBodyCWProxy {
  StockWriteOutputBody data(StockMovement data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StockWriteOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StockWriteOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  StockWriteOutputBody call({StockMovement data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStockWriteOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStockWriteOutputBody.copyWith.fieldName(...)`
class _$StockWriteOutputBodyCWProxyImpl
    implements _$StockWriteOutputBodyCWProxy {
  const _$StockWriteOutputBodyCWProxyImpl(this._value);

  final StockWriteOutputBody _value;

  @override
  StockWriteOutputBody data(StockMovement data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StockWriteOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StockWriteOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  StockWriteOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return StockWriteOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as StockMovement,
    );
  }
}

extension $StockWriteOutputBodyCopyWith on StockWriteOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfStockWriteOutputBody.copyWith(...)` or like so:`instanceOfStockWriteOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StockWriteOutputBodyCWProxy get copyWith =>
      _$StockWriteOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockWriteOutputBody _$StockWriteOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('StockWriteOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = StockWriteOutputBody(
    data: $checkedConvert(
      'data',
      (v) => StockMovement.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$StockWriteOutputBodyToJson(
  StockWriteOutputBody instance,
) => <String, dynamic>{'data': instance.data.toJson()};
