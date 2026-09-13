// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_types_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderTypesOutputBodyCWProxy {
  OrderTypesOutputBody data(List<OrderTypeData>? data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderTypesOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderTypesOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderTypesOutputBody call({List<OrderTypeData>? data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderTypesOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderTypesOutputBody.copyWith.fieldName(...)`
class _$OrderTypesOutputBodyCWProxyImpl
    implements _$OrderTypesOutputBodyCWProxy {
  const _$OrderTypesOutputBodyCWProxyImpl(this._value);

  final OrderTypesOutputBody _value;

  @override
  OrderTypesOutputBody data(List<OrderTypeData>? data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderTypesOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderTypesOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderTypesOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return OrderTypesOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<OrderTypeData>?,
    );
  }
}

extension $OrderTypesOutputBodyCopyWith on OrderTypesOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfOrderTypesOutputBody.copyWith(...)` or like so:`instanceOfOrderTypesOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderTypesOutputBodyCWProxy get copyWith =>
      _$OrderTypesOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTypesOutputBody _$OrderTypesOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderTypesOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = OrderTypesOutputBody(
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>?)
          ?.map((e) => OrderTypeData.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$OrderTypesOutputBodyToJson(
  OrderTypesOutputBody instance,
) => <String, dynamic>{'data': instance.data?.map((e) => e.toJson()).toList()};
