// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_point.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DailyPointCWProxy {
  DailyPoint chargedSales(int chargedSales);

  DailyPoint date(String date);

  DailyPoint netSales(int netSales);

  DailyPoint refundAmount(int refundAmount);

  DailyPoint saleCount(int saleCount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DailyPoint(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DailyPoint(...).copyWith(id: 12, name: "My name")
  /// ````
  DailyPoint call({
    int chargedSales,
    String date,
    int netSales,
    int refundAmount,
    int saleCount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDailyPoint.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDailyPoint.copyWith.fieldName(...)`
class _$DailyPointCWProxyImpl implements _$DailyPointCWProxy {
  const _$DailyPointCWProxyImpl(this._value);

  final DailyPoint _value;

  @override
  DailyPoint chargedSales(int chargedSales) => this(chargedSales: chargedSales);

  @override
  DailyPoint date(String date) => this(date: date);

  @override
  DailyPoint netSales(int netSales) => this(netSales: netSales);

  @override
  DailyPoint refundAmount(int refundAmount) => this(refundAmount: refundAmount);

  @override
  DailyPoint saleCount(int saleCount) => this(saleCount: saleCount);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DailyPoint(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DailyPoint(...).copyWith(id: 12, name: "My name")
  /// ````
  DailyPoint call({
    Object? chargedSales = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? netSales = const $CopyWithPlaceholder(),
    Object? refundAmount = const $CopyWithPlaceholder(),
    Object? saleCount = const $CopyWithPlaceholder(),
  }) {
    return DailyPoint(
      chargedSales: chargedSales == const $CopyWithPlaceholder()
          ? _value.chargedSales
          // ignore: cast_nullable_to_non_nullable
          : chargedSales as int,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      netSales: netSales == const $CopyWithPlaceholder()
          ? _value.netSales
          // ignore: cast_nullable_to_non_nullable
          : netSales as int,
      refundAmount: refundAmount == const $CopyWithPlaceholder()
          ? _value.refundAmount
          // ignore: cast_nullable_to_non_nullable
          : refundAmount as int,
      saleCount: saleCount == const $CopyWithPlaceholder()
          ? _value.saleCount
          // ignore: cast_nullable_to_non_nullable
          : saleCount as int,
    );
  }
}

extension $DailyPointCopyWith on DailyPoint {
  /// Returns a callable class that can be used as follows: `instanceOfDailyPoint.copyWith(...)` or like so:`instanceOfDailyPoint.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DailyPointCWProxy get copyWith => _$DailyPointCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyPoint _$DailyPointFromJson(Map<String, dynamic> json) => $checkedCreate(
  'DailyPoint',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'charged_sales',
        'date',
        'net_sales',
        'refund_amount',
        'sale_count',
      ],
    );
    final val = DailyPoint(
      chargedSales: $checkedConvert('charged_sales', (v) => (v as num).toInt()),
      date: $checkedConvert('date', (v) => v as String),
      netSales: $checkedConvert('net_sales', (v) => (v as num).toInt()),
      refundAmount: $checkedConvert('refund_amount', (v) => (v as num).toInt()),
      saleCount: $checkedConvert('sale_count', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'chargedSales': 'charged_sales',
    'netSales': 'net_sales',
    'refundAmount': 'refund_amount',
    'saleCount': 'sale_count',
  },
);

Map<String, dynamic> _$DailyPointToJson(DailyPoint instance) =>
    <String, dynamic>{
      'charged_sales': instance.chargedSales,
      'date': instance.date,
      'net_sales': instance.netSales,
      'refund_amount': instance.refundAmount,
      'sale_count': instance.saleCount,
    };
