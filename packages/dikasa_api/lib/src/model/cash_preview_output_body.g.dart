// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_preview_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CashPreviewOutputBodyCWProxy {
  CashPreviewOutputBody data(ClosePreview data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashPreviewOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashPreviewOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CashPreviewOutputBody call({ClosePreview data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCashPreviewOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCashPreviewOutputBody.copyWith.fieldName(...)`
class _$CashPreviewOutputBodyCWProxyImpl
    implements _$CashPreviewOutputBodyCWProxy {
  const _$CashPreviewOutputBodyCWProxyImpl(this._value);

  final CashPreviewOutputBody _value;

  @override
  CashPreviewOutputBody data(ClosePreview data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashPreviewOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashPreviewOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CashPreviewOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return CashPreviewOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ClosePreview,
    );
  }
}

extension $CashPreviewOutputBodyCopyWith on CashPreviewOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfCashPreviewOutputBody.copyWith(...)` or like so:`instanceOfCashPreviewOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CashPreviewOutputBodyCWProxy get copyWith =>
      _$CashPreviewOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashPreviewOutputBody _$CashPreviewOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CashPreviewOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = CashPreviewOutputBody(
    data: $checkedConvert(
      'data',
      (v) => ClosePreview.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$CashPreviewOutputBodyToJson(
  CashPreviewOutputBody instance,
) => <String, dynamic>{'data': instance.data.toJson()};
