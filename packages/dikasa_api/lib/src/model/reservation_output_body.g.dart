// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReservationOutputBodyCWProxy {
  ReservationOutputBody data(ReservationData data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationOutputBody call({ReservationData data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReservationOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReservationOutputBody.copyWith.fieldName(...)`
class _$ReservationOutputBodyCWProxyImpl
    implements _$ReservationOutputBodyCWProxy {
  const _$ReservationOutputBodyCWProxyImpl(this._value);

  final ReservationOutputBody _value;

  @override
  ReservationOutputBody data(ReservationData data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return ReservationOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ReservationData,
    );
  }
}

extension $ReservationOutputBodyCopyWith on ReservationOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfReservationOutputBody.copyWith(...)` or like so:`instanceOfReservationOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReservationOutputBodyCWProxy get copyWith =>
      _$ReservationOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationOutputBody _$ReservationOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ReservationOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = ReservationOutputBody(
    data: $checkedConvert(
      'data',
      (v) => ReservationData.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$ReservationOutputBodyToJson(
  ReservationOutputBody instance,
) => <String, dynamic>{'data': instance.data.toJson()};
