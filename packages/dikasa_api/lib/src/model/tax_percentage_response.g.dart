// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_percentage_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TaxPercentageResponseCWProxy {
  TaxPercentageResponse taxPercentage(double taxPercentage);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaxPercentageResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaxPercentageResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  TaxPercentageResponse call({double taxPercentage});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTaxPercentageResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTaxPercentageResponse.copyWith.fieldName(...)`
class _$TaxPercentageResponseCWProxyImpl
    implements _$TaxPercentageResponseCWProxy {
  const _$TaxPercentageResponseCWProxyImpl(this._value);

  final TaxPercentageResponse _value;

  @override
  TaxPercentageResponse taxPercentage(double taxPercentage) =>
      this(taxPercentage: taxPercentage);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaxPercentageResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaxPercentageResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  TaxPercentageResponse call({
    Object? taxPercentage = const $CopyWithPlaceholder(),
  }) {
    return TaxPercentageResponse(
      taxPercentage: taxPercentage == const $CopyWithPlaceholder()
          ? _value.taxPercentage
          // ignore: cast_nullable_to_non_nullable
          : taxPercentage as double,
    );
  }
}

extension $TaxPercentageResponseCopyWith on TaxPercentageResponse {
  /// Returns a callable class that can be used as follows: `instanceOfTaxPercentageResponse.copyWith(...)` or like so:`instanceOfTaxPercentageResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TaxPercentageResponseCWProxy get copyWith =>
      _$TaxPercentageResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaxPercentageResponse _$TaxPercentageResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'TaxPercentageResponse',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['tax_percentage']);
    final val = TaxPercentageResponse(
      taxPercentage: $checkedConvert(
        'tax_percentage',
        (v) => (v as num).toDouble(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'taxPercentage': 'tax_percentage'},
);

Map<String, dynamic> _$TaxPercentageResponseToJson(
  TaxPercentageResponse instance,
) => <String, dynamic>{'tax_percentage': instance.taxPercentage};
