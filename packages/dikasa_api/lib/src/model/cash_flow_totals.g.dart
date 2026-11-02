// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_flow_totals.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CashFlowTotalsCWProxy {
  CashFlowTotals cashIn(int cashIn);

  CashFlowTotals cashOut(int cashOut);

  CashFlowTotals cashRefunds(int cashRefunds);

  CashFlowTotals cashSales(int cashSales);

  CashFlowTotals expectedCash(int expectedCash);

  CashFlowTotals movementCount(int movementCount);

  CashFlowTotals opening(int opening);

  CashFlowTotals totalIn(int totalIn);

  CashFlowTotals totalOut(int totalOut);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashFlowTotals(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashFlowTotals(...).copyWith(id: 12, name: "My name")
  /// ````
  CashFlowTotals call({
    int cashIn,
    int cashOut,
    int cashRefunds,
    int cashSales,
    int expectedCash,
    int movementCount,
    int opening,
    int totalIn,
    int totalOut,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCashFlowTotals.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCashFlowTotals.copyWith.fieldName(...)`
class _$CashFlowTotalsCWProxyImpl implements _$CashFlowTotalsCWProxy {
  const _$CashFlowTotalsCWProxyImpl(this._value);

  final CashFlowTotals _value;

  @override
  CashFlowTotals cashIn(int cashIn) => this(cashIn: cashIn);

  @override
  CashFlowTotals cashOut(int cashOut) => this(cashOut: cashOut);

  @override
  CashFlowTotals cashRefunds(int cashRefunds) => this(cashRefunds: cashRefunds);

  @override
  CashFlowTotals cashSales(int cashSales) => this(cashSales: cashSales);

  @override
  CashFlowTotals expectedCash(int expectedCash) =>
      this(expectedCash: expectedCash);

  @override
  CashFlowTotals movementCount(int movementCount) =>
      this(movementCount: movementCount);

  @override
  CashFlowTotals opening(int opening) => this(opening: opening);

  @override
  CashFlowTotals totalIn(int totalIn) => this(totalIn: totalIn);

  @override
  CashFlowTotals totalOut(int totalOut) => this(totalOut: totalOut);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashFlowTotals(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashFlowTotals(...).copyWith(id: 12, name: "My name")
  /// ````
  CashFlowTotals call({
    Object? cashIn = const $CopyWithPlaceholder(),
    Object? cashOut = const $CopyWithPlaceholder(),
    Object? cashRefunds = const $CopyWithPlaceholder(),
    Object? cashSales = const $CopyWithPlaceholder(),
    Object? expectedCash = const $CopyWithPlaceholder(),
    Object? movementCount = const $CopyWithPlaceholder(),
    Object? opening = const $CopyWithPlaceholder(),
    Object? totalIn = const $CopyWithPlaceholder(),
    Object? totalOut = const $CopyWithPlaceholder(),
  }) {
    return CashFlowTotals(
      cashIn: cashIn == const $CopyWithPlaceholder()
          ? _value.cashIn
          // ignore: cast_nullable_to_non_nullable
          : cashIn as int,
      cashOut: cashOut == const $CopyWithPlaceholder()
          ? _value.cashOut
          // ignore: cast_nullable_to_non_nullable
          : cashOut as int,
      cashRefunds: cashRefunds == const $CopyWithPlaceholder()
          ? _value.cashRefunds
          // ignore: cast_nullable_to_non_nullable
          : cashRefunds as int,
      cashSales: cashSales == const $CopyWithPlaceholder()
          ? _value.cashSales
          // ignore: cast_nullable_to_non_nullable
          : cashSales as int,
      expectedCash: expectedCash == const $CopyWithPlaceholder()
          ? _value.expectedCash
          // ignore: cast_nullable_to_non_nullable
          : expectedCash as int,
      movementCount: movementCount == const $CopyWithPlaceholder()
          ? _value.movementCount
          // ignore: cast_nullable_to_non_nullable
          : movementCount as int,
      opening: opening == const $CopyWithPlaceholder()
          ? _value.opening
          // ignore: cast_nullable_to_non_nullable
          : opening as int,
      totalIn: totalIn == const $CopyWithPlaceholder()
          ? _value.totalIn
          // ignore: cast_nullable_to_non_nullable
          : totalIn as int,
      totalOut: totalOut == const $CopyWithPlaceholder()
          ? _value.totalOut
          // ignore: cast_nullable_to_non_nullable
          : totalOut as int,
    );
  }
}

extension $CashFlowTotalsCopyWith on CashFlowTotals {
  /// Returns a callable class that can be used as follows: `instanceOfCashFlowTotals.copyWith(...)` or like so:`instanceOfCashFlowTotals.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CashFlowTotalsCWProxy get copyWith => _$CashFlowTotalsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashFlowTotals _$CashFlowTotalsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CashFlowTotals',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'cash_in',
        'cash_out',
        'cash_refunds',
        'cash_sales',
        'expected_cash',
        'movement_count',
        'opening',
        'total_in',
        'total_out',
      ],
    );
    final val = CashFlowTotals(
      cashIn: $checkedConvert('cash_in', (v) => (v as num).toInt()),
      cashOut: $checkedConvert('cash_out', (v) => (v as num).toInt()),
      cashRefunds: $checkedConvert('cash_refunds', (v) => (v as num).toInt()),
      cashSales: $checkedConvert('cash_sales', (v) => (v as num).toInt()),
      expectedCash: $checkedConvert('expected_cash', (v) => (v as num).toInt()),
      movementCount: $checkedConvert(
        'movement_count',
        (v) => (v as num).toInt(),
      ),
      opening: $checkedConvert('opening', (v) => (v as num).toInt()),
      totalIn: $checkedConvert('total_in', (v) => (v as num).toInt()),
      totalOut: $checkedConvert('total_out', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'cashIn': 'cash_in',
    'cashOut': 'cash_out',
    'cashRefunds': 'cash_refunds',
    'cashSales': 'cash_sales',
    'expectedCash': 'expected_cash',
    'movementCount': 'movement_count',
    'totalIn': 'total_in',
    'totalOut': 'total_out',
  },
);

Map<String, dynamic> _$CashFlowTotalsToJson(CashFlowTotals instance) =>
    <String, dynamic>{
      'cash_in': instance.cashIn,
      'cash_out': instance.cashOut,
      'cash_refunds': instance.cashRefunds,
      'cash_sales': instance.cashSales,
      'expected_cash': instance.expectedCash,
      'movement_count': instance.movementCount,
      'opening': instance.opening,
      'total_in': instance.totalIn,
      'total_out': instance.totalOut,
    };
