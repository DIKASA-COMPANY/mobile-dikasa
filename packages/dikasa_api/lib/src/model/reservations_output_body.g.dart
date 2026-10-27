// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservations_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReservationsOutputBodyCWProxy {
  ReservationsOutputBody data(List<ReservationData>? data);

  ReservationsOutputBody meta(MetaStruct meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationsOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationsOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationsOutputBody call({List<ReservationData>? data, MetaStruct meta});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReservationsOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReservationsOutputBody.copyWith.fieldName(...)`
class _$ReservationsOutputBodyCWProxyImpl
    implements _$ReservationsOutputBodyCWProxy {
  const _$ReservationsOutputBodyCWProxyImpl(this._value);

  final ReservationsOutputBody _value;

  @override
  ReservationsOutputBody data(List<ReservationData>? data) => this(data: data);

  @override
  ReservationsOutputBody meta(MetaStruct meta) => this(meta: meta);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationsOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationsOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationsOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return ReservationsOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<ReservationData>?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as MetaStruct,
    );
  }
}

extension $ReservationsOutputBodyCopyWith on ReservationsOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfReservationsOutputBody.copyWith(...)` or like so:`instanceOfReservationsOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReservationsOutputBodyCWProxy get copyWith =>
      _$ReservationsOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationsOutputBody _$ReservationsOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ReservationsOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data', 'meta']);
  final val = ReservationsOutputBody(
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>?)
          ?.map((e) => ReservationData.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    meta: $checkedConvert(
      'meta',
      (v) => MetaStruct.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$ReservationsOutputBodyToJson(
  ReservationsOutputBody instance,
) => <String, dynamic>{
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'meta': instance.meta.toJson(),
};
