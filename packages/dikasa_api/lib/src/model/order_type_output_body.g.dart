// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_type_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderTypeOutputBodyCWProxy {
  OrderTypeOutputBody data(OrderTypeData data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderTypeOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderTypeOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderTypeOutputBody call({OrderTypeData data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderTypeOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderTypeOutputBody.copyWith.fieldName(...)`
class _$OrderTypeOutputBodyCWProxyImpl implements _$OrderTypeOutputBodyCWProxy {
  const _$OrderTypeOutputBodyCWProxyImpl(this._value);

  final OrderTypeOutputBody _value;

  @override
  OrderTypeOutputBody data(OrderTypeData data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderTypeOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderTypeOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderTypeOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return OrderTypeOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as OrderTypeData,
    );
  }
}

extension $OrderTypeOutputBodyCopyWith on OrderTypeOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfOrderTypeOutputBody.copyWith(...)` or like so:`instanceOfOrderTypeOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderTypeOutputBodyCWProxy get copyWith =>
      _$OrderTypeOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTypeOutputBody _$OrderTypeOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderTypeOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = OrderTypeOutputBody(
        data: $checkedConvert(
          'data',
          (v) => OrderTypeData.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OrderTypeOutputBodyToJson(
  OrderTypeOutputBody instance,
) => <String, dynamic>{'data': instance.data.toJson()};
