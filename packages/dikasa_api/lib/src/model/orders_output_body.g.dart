// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrdersOutputBodyCWProxy {
  OrdersOutputBody data(List<OrderData>? data);

  OrdersOutputBody meta(PaginationMeta meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrdersOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrdersOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  OrdersOutputBody call({List<OrderData>? data, PaginationMeta meta});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrdersOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrdersOutputBody.copyWith.fieldName(...)`
class _$OrdersOutputBodyCWProxyImpl implements _$OrdersOutputBodyCWProxy {
  const _$OrdersOutputBodyCWProxyImpl(this._value);

  final OrdersOutputBody _value;

  @override
  OrdersOutputBody data(List<OrderData>? data) => this(data: data);

  @override
  OrdersOutputBody meta(PaginationMeta meta) => this(meta: meta);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrdersOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrdersOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  OrdersOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return OrdersOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<OrderData>?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as PaginationMeta,
    );
  }
}

extension $OrdersOutputBodyCopyWith on OrdersOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfOrdersOutputBody.copyWith(...)` or like so:`instanceOfOrdersOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrdersOutputBodyCWProxy get copyWith => _$OrdersOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersOutputBody _$OrdersOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrdersOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data', 'meta']);
      final val = OrdersOutputBody(
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>?)
              ?.map((e) => OrderData.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        meta: $checkedConvert(
          'meta',
          (v) => PaginationMeta.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OrdersOutputBodyToJson(OrdersOutputBody instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };
