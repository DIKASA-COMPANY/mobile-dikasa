// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_close_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CashCloseOutputBodyCWProxy {
  CashCloseOutputBody data(ClosedReconciliation data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashCloseOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashCloseOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CashCloseOutputBody call({ClosedReconciliation data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCashCloseOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCashCloseOutputBody.copyWith.fieldName(...)`
class _$CashCloseOutputBodyCWProxyImpl implements _$CashCloseOutputBodyCWProxy {
  const _$CashCloseOutputBodyCWProxyImpl(this._value);

  final CashCloseOutputBody _value;

  @override
  CashCloseOutputBody data(ClosedReconciliation data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashCloseOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashCloseOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CashCloseOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return CashCloseOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ClosedReconciliation,
    );
  }
}

extension $CashCloseOutputBodyCopyWith on CashCloseOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfCashCloseOutputBody.copyWith(...)` or like so:`instanceOfCashCloseOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CashCloseOutputBodyCWProxy get copyWith =>
      _$CashCloseOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashCloseOutputBody _$CashCloseOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CashCloseOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = CashCloseOutputBody(
        data: $checkedConvert(
          'data',
          (v) => ClosedReconciliation.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CashCloseOutputBodyToJson(
  CashCloseOutputBody instance,
) => <String, dynamic>{'data': instance.data.toJson()};
