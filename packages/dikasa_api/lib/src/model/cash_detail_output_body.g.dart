// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_detail_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CashDetailOutputBodyCWProxy {
  CashDetailOutputBody data(SessionRecord data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashDetailOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashDetailOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CashDetailOutputBody call({SessionRecord data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCashDetailOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCashDetailOutputBody.copyWith.fieldName(...)`
class _$CashDetailOutputBodyCWProxyImpl
    implements _$CashDetailOutputBodyCWProxy {
  const _$CashDetailOutputBodyCWProxyImpl(this._value);

  final CashDetailOutputBody _value;

  @override
  CashDetailOutputBody data(SessionRecord data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashDetailOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashDetailOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CashDetailOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return CashDetailOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as SessionRecord,
    );
  }
}

extension $CashDetailOutputBodyCopyWith on CashDetailOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfCashDetailOutputBody.copyWith(...)` or like so:`instanceOfCashDetailOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CashDetailOutputBodyCWProxy get copyWith =>
      _$CashDetailOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashDetailOutputBody _$CashDetailOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CashDetailOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = CashDetailOutputBody(
    data: $checkedConvert(
      'data',
      (v) => SessionRecord.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$CashDetailOutputBodyToJson(
  CashDetailOutputBody instance,
) => <String, dynamic>{'data': instance.data.toJson()};
