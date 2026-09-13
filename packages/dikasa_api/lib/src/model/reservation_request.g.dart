// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReservationRequestCWProxy {
  ReservationRequest customerContact(String customerContact);

  ReservationRequest customerName(String customerName);

  ReservationRequest notes(String notes);

  ReservationRequest printReservation(bool printReservation);

  ReservationRequest reservationTypeId(String reservationTypeId);

  ReservationRequest reservedAt(DateTime reservedAt);

  ReservationRequest restaurantTableId(String restaurantTableId);

  ReservationRequest sendReservation(bool sendReservation);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationRequest call({
    String customerContact,
    String customerName,
    String notes,
    bool printReservation,
    String reservationTypeId,
    DateTime reservedAt,
    String restaurantTableId,
    bool sendReservation,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReservationRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReservationRequest.copyWith.fieldName(...)`
class _$ReservationRequestCWProxyImpl implements _$ReservationRequestCWProxy {
  const _$ReservationRequestCWProxyImpl(this._value);

  final ReservationRequest _value;

  @override
  ReservationRequest customerContact(String customerContact) =>
      this(customerContact: customerContact);

  @override
  ReservationRequest customerName(String customerName) =>
      this(customerName: customerName);

  @override
  ReservationRequest notes(String notes) => this(notes: notes);

  @override
  ReservationRequest printReservation(bool printReservation) =>
      this(printReservation: printReservation);

  @override
  ReservationRequest reservationTypeId(String reservationTypeId) =>
      this(reservationTypeId: reservationTypeId);

  @override
  ReservationRequest reservedAt(DateTime reservedAt) =>
      this(reservedAt: reservedAt);

  @override
  ReservationRequest restaurantTableId(String restaurantTableId) =>
      this(restaurantTableId: restaurantTableId);

  @override
  ReservationRequest sendReservation(bool sendReservation) =>
      this(sendReservation: sendReservation);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationRequest call({
    Object? customerContact = const $CopyWithPlaceholder(),
    Object? customerName = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? printReservation = const $CopyWithPlaceholder(),
    Object? reservationTypeId = const $CopyWithPlaceholder(),
    Object? reservedAt = const $CopyWithPlaceholder(),
    Object? restaurantTableId = const $CopyWithPlaceholder(),
    Object? sendReservation = const $CopyWithPlaceholder(),
  }) {
    return ReservationRequest(
      customerContact: customerContact == const $CopyWithPlaceholder()
          ? _value.customerContact
          // ignore: cast_nullable_to_non_nullable
          : customerContact as String,
      customerName: customerName == const $CopyWithPlaceholder()
          ? _value.customerName
          // ignore: cast_nullable_to_non_nullable
          : customerName as String,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String,
      printReservation: printReservation == const $CopyWithPlaceholder()
          ? _value.printReservation
          // ignore: cast_nullable_to_non_nullable
          : printReservation as bool,
      reservationTypeId: reservationTypeId == const $CopyWithPlaceholder()
          ? _value.reservationTypeId
          // ignore: cast_nullable_to_non_nullable
          : reservationTypeId as String,
      reservedAt: reservedAt == const $CopyWithPlaceholder()
          ? _value.reservedAt
          // ignore: cast_nullable_to_non_nullable
          : reservedAt as DateTime,
      restaurantTableId: restaurantTableId == const $CopyWithPlaceholder()
          ? _value.restaurantTableId
          // ignore: cast_nullable_to_non_nullable
          : restaurantTableId as String,
      sendReservation: sendReservation == const $CopyWithPlaceholder()
          ? _value.sendReservation
          // ignore: cast_nullable_to_non_nullable
          : sendReservation as bool,
    );
  }
}

extension $ReservationRequestCopyWith on ReservationRequest {
  /// Returns a callable class that can be used as follows: `instanceOfReservationRequest.copyWith(...)` or like so:`instanceOfReservationRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReservationRequestCWProxy get copyWith =>
      _$ReservationRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationRequest _$ReservationRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ReservationRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'customer_contact',
        'customer_name',
        'notes',
        'print_reservation',
        'reservation_type_id',
        'reserved_at',
        'restaurant_table_id',
        'send_reservation',
      ],
    );
    final val = ReservationRequest(
      customerContact: $checkedConvert('customer_contact', (v) => v as String),
      customerName: $checkedConvert('customer_name', (v) => v as String),
      notes: $checkedConvert('notes', (v) => v as String),
      printReservation: $checkedConvert('print_reservation', (v) => v as bool),
      reservationTypeId: $checkedConvert(
        'reservation_type_id',
        (v) => v as String,
      ),
      reservedAt: $checkedConvert(
        'reserved_at',
        (v) => DateTime.parse(v as String),
      ),
      restaurantTableId: $checkedConvert(
        'restaurant_table_id',
        (v) => v as String,
      ),
      sendReservation: $checkedConvert('send_reservation', (v) => v as bool),
    );
    return val;
  },
  fieldKeyMap: const {
    'customerContact': 'customer_contact',
    'customerName': 'customer_name',
    'printReservation': 'print_reservation',
    'reservationTypeId': 'reservation_type_id',
    'reservedAt': 'reserved_at',
    'restaurantTableId': 'restaurant_table_id',
    'sendReservation': 'send_reservation',
  },
);

Map<String, dynamic> _$ReservationRequestToJson(ReservationRequest instance) =>
    <String, dynamic>{
      'customer_contact': instance.customerContact,
      'customer_name': instance.customerName,
      'notes': instance.notes,
      'print_reservation': instance.printReservation,
      'reservation_type_id': instance.reservationTypeId,
      'reserved_at': instance.reservedAt.toIso8601String(),
      'restaurant_table_id': instance.restaurantTableId,
      'send_reservation': instance.sendReservation,
    };
