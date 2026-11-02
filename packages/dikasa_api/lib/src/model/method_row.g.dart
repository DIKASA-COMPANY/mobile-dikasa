// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'method_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MethodRowCWProxy {
  MethodRow method(String method);

  MethodRow netAmount(int netAmount);

  MethodRow refundAmount(int refundAmount);

  MethodRow refundCount(int refundCount);

  MethodRow saleCount(int saleCount);

  MethodRow salesAmount(int salesAmount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MethodRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MethodRow(...).copyWith(id: 12, name: "My name")
  /// ````
  MethodRow call({
    String method,
    int netAmount,
    int refundAmount,
    int refundCount,
    int saleCount,
    int salesAmount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMethodRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMethodRow.copyWith.fieldName(...)`
class _$MethodRowCWProxyImpl implements _$MethodRowCWProxy {
  const _$MethodRowCWProxyImpl(this._value);

  final MethodRow _value;

  @override
  MethodRow method(String method) => this(method: method);

  @override
  MethodRow netAmount(int netAmount) => this(netAmount: netAmount);

  @override
  MethodRow refundAmount(int refundAmount) => this(refundAmount: refundAmount);

  @override
  MethodRow refundCount(int refundCount) => this(refundCount: refundCount);

  @override
  MethodRow saleCount(int saleCount) => this(saleCount: saleCount);

  @override
  MethodRow salesAmount(int salesAmount) => this(salesAmount: salesAmount);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MethodRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MethodRow(...).copyWith(id: 12, name: "My name")
  /// ````
  MethodRow call({
    Object? method = const $CopyWithPlaceholder(),
    Object? netAmount = const $CopyWithPlaceholder(),
    Object? refundAmount = const $CopyWithPlaceholder(),
    Object? refundCount = const $CopyWithPlaceholder(),
    Object? saleCount = const $CopyWithPlaceholder(),
    Object? salesAmount = const $CopyWithPlaceholder(),
  }) {
    return MethodRow(
      method: method == const $CopyWithPlaceholder()
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as String,
      netAmount: netAmount == const $CopyWithPlaceholder()
          ? _value.netAmount
          // ignore: cast_nullable_to_non_nullable
          : netAmount as int,
      refundAmount: refundAmount == const $CopyWithPlaceholder()
          ? _value.refundAmount
          // ignore: cast_nullable_to_non_nullable
          : refundAmount as int,
      refundCount: refundCount == const $CopyWithPlaceholder()
          ? _value.refundCount
          // ignore: cast_nullable_to_non_nullable
          : refundCount as int,
      saleCount: saleCount == const $CopyWithPlaceholder()
          ? _value.saleCount
          // ignore: cast_nullable_to_non_nullable
          : saleCount as int,
      salesAmount: salesAmount == const $CopyWithPlaceholder()
          ? _value.salesAmount
          // ignore: cast_nullable_to_non_nullable
          : salesAmount as int,
    );
  }
}

extension $MethodRowCopyWith on MethodRow {
  /// Returns a callable class that can be used as follows: `instanceOfMethodRow.copyWith(...)` or like so:`instanceOfMethodRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MethodRowCWProxy get copyWith => _$MethodRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MethodRow _$MethodRowFromJson(Map<String, dynamic> json) => $checkedCreate(
  'MethodRow',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'method',
        'net_amount',
        'refund_amount',
        'refund_count',
        'sale_count',
        'sales_amount',
      ],
    );
    final val = MethodRow(
      method: $checkedConvert('method', (v) => v as String),
      netAmount: $checkedConvert('net_amount', (v) => (v as num).toInt()),
      refundAmount: $checkedConvert('refund_amount', (v) => (v as num).toInt()),
      refundCount: $checkedConvert('refund_count', (v) => (v as num).toInt()),
      saleCount: $checkedConvert('sale_count', (v) => (v as num).toInt()),
      salesAmount: $checkedConvert('sales_amount', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'netAmount': 'net_amount',
    'refundAmount': 'refund_amount',
    'refundCount': 'refund_count',
    'saleCount': 'sale_count',
    'salesAmount': 'sales_amount',
  },
);

Map<String, dynamic> _$MethodRowToJson(MethodRow instance) => <String, dynamic>{
  'method': instance.method,
  'net_amount': instance.netAmount,
  'refund_amount': instance.refundAmount,
  'refund_count': instance.refundCount,
  'sale_count': instance.saleCount,
  'sales_amount': instance.salesAmount,
};
