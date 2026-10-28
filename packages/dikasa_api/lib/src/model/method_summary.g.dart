// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'method_summary.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MethodSummaryCWProxy {
  MethodSummary method(String method);

  MethodSummary refundCount(int refundCount);

  MethodSummary refundsAmount(int refundsAmount);

  MethodSummary saleCount(int saleCount);

  MethodSummary salesAmount(int salesAmount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MethodSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MethodSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  MethodSummary call({
    String method,
    int refundCount,
    int refundsAmount,
    int saleCount,
    int salesAmount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMethodSummary.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMethodSummary.copyWith.fieldName(...)`
class _$MethodSummaryCWProxyImpl implements _$MethodSummaryCWProxy {
  const _$MethodSummaryCWProxyImpl(this._value);

  final MethodSummary _value;

  @override
  MethodSummary method(String method) => this(method: method);

  @override
  MethodSummary refundCount(int refundCount) => this(refundCount: refundCount);

  @override
  MethodSummary refundsAmount(int refundsAmount) =>
      this(refundsAmount: refundsAmount);

  @override
  MethodSummary saleCount(int saleCount) => this(saleCount: saleCount);

  @override
  MethodSummary salesAmount(int salesAmount) => this(salesAmount: salesAmount);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MethodSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MethodSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  MethodSummary call({
    Object? method = const $CopyWithPlaceholder(),
    Object? refundCount = const $CopyWithPlaceholder(),
    Object? refundsAmount = const $CopyWithPlaceholder(),
    Object? saleCount = const $CopyWithPlaceholder(),
    Object? salesAmount = const $CopyWithPlaceholder(),
  }) {
    return MethodSummary(
      method: method == const $CopyWithPlaceholder()
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as String,
      refundCount: refundCount == const $CopyWithPlaceholder()
          ? _value.refundCount
          // ignore: cast_nullable_to_non_nullable
          : refundCount as int,
      refundsAmount: refundsAmount == const $CopyWithPlaceholder()
          ? _value.refundsAmount
          // ignore: cast_nullable_to_non_nullable
          : refundsAmount as int,
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

extension $MethodSummaryCopyWith on MethodSummary {
  /// Returns a callable class that can be used as follows: `instanceOfMethodSummary.copyWith(...)` or like so:`instanceOfMethodSummary.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MethodSummaryCWProxy get copyWith => _$MethodSummaryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MethodSummary _$MethodSummaryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'MethodSummary',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'method',
        'refund_count',
        'refunds_amount',
        'sale_count',
        'sales_amount',
      ],
    );
    final val = MethodSummary(
      method: $checkedConvert('method', (v) => v as String),
      refundCount: $checkedConvert('refund_count', (v) => (v as num).toInt()),
      refundsAmount: $checkedConvert(
        'refunds_amount',
        (v) => (v as num).toInt(),
      ),
      saleCount: $checkedConvert('sale_count', (v) => (v as num).toInt()),
      salesAmount: $checkedConvert('sales_amount', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'refundCount': 'refund_count',
    'refundsAmount': 'refunds_amount',
    'saleCount': 'sale_count',
    'salesAmount': 'sales_amount',
  },
);

Map<String, dynamic> _$MethodSummaryToJson(MethodSummary instance) =>
    <String, dynamic>{
      'method': instance.method,
      'refund_count': instance.refundCount,
      'refunds_amount': instance.refundsAmount,
      'sale_count': instance.saleCount,
      'sales_amount': instance.salesAmount,
    };
