// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_sessions_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CashSessionsOutputBodyCWProxy {
  CashSessionsOutputBody data(List<SessionRecord>? data);

  CashSessionsOutputBody meta(MetaStruct meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashSessionsOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashSessionsOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CashSessionsOutputBody call({List<SessionRecord>? data, MetaStruct meta});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCashSessionsOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCashSessionsOutputBody.copyWith.fieldName(...)`
class _$CashSessionsOutputBodyCWProxyImpl
    implements _$CashSessionsOutputBodyCWProxy {
  const _$CashSessionsOutputBodyCWProxyImpl(this._value);

  final CashSessionsOutputBody _value;

  @override
  CashSessionsOutputBody data(List<SessionRecord>? data) => this(data: data);

  @override
  CashSessionsOutputBody meta(MetaStruct meta) => this(meta: meta);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashSessionsOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashSessionsOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CashSessionsOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return CashSessionsOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<SessionRecord>?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as MetaStruct,
    );
  }
}

extension $CashSessionsOutputBodyCopyWith on CashSessionsOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfCashSessionsOutputBody.copyWith(...)` or like so:`instanceOfCashSessionsOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CashSessionsOutputBodyCWProxy get copyWith =>
      _$CashSessionsOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashSessionsOutputBody _$CashSessionsOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CashSessionsOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data', 'meta']);
  final val = CashSessionsOutputBody(
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>?)
          ?.map((e) => SessionRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    meta: $checkedConvert(
      'meta',
      (v) => MetaStruct.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$CashSessionsOutputBodyToJson(
  CashSessionsOutputBody instance,
) => <String, dynamic>{
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'meta': instance.meta.toJson(),
};
