// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_patch_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReservationPatchRequestCWProxy {
  ReservationPatchRequest customerContact(String? customerContact);

  ReservationPatchRequest customerName(String? customerName);

  ReservationPatchRequest notes(String? notes);

  ReservationPatchRequest printReservation(bool? printReservation);

  ReservationPatchRequest reservationTypeId(String? reservationTypeId);

  ReservationPatchRequest reservedAt(DateTime? reservedAt);

  ReservationPatchRequest restaurantTableId(String? restaurantTableId);

  ReservationPatchRequest sendReservation(bool? sendReservation);

  ReservationPatchRequest status(ReservationPatchRequestStatusEnum? status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationPatchRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationPatchRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationPatchRequest call({
    String? customerContact,
    String? customerName,
    String? notes,
    bool? printReservation,
    String? reservationTypeId,
    DateTime? reservedAt,
    String? restaurantTableId,
    bool? sendReservation,
    ReservationPatchRequestStatusEnum? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReservationPatchRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReservationPatchRequest.copyWith.fieldName(...)`
class _$ReservationPatchRequestCWProxyImpl
    implements _$ReservationPatchRequestCWProxy {
  const _$ReservationPatchRequestCWProxyImpl(this._value);

  final ReservationPatchRequest _value;

  @override
  ReservationPatchRequest customerContact(String? customerContact) =>
      this(customerContact: customerContact);

  @override
  ReservationPatchRequest customerName(String? customerName) =>
      this(customerName: customerName);

  @override
  ReservationPatchRequest notes(String? notes) => this(notes: notes);

  @override
  ReservationPatchRequest printReservation(bool? printReservation) =>
      this(printReservation: printReservation);

  @override
  ReservationPatchRequest reservationTypeId(String? reservationTypeId) =>
      this(reservationTypeId: reservationTypeId);

  @override
  ReservationPatchRequest reservedAt(DateTime? reservedAt) =>
      this(reservedAt: reservedAt);

  @override
  ReservationPatchRequest restaurantTableId(String? restaurantTableId) =>
      this(restaurantTableId: restaurantTableId);

  @override
  ReservationPatchRequest sendReservation(bool? sendReservation) =>
      this(sendReservation: sendReservation);

  @override
  ReservationPatchRequest status(ReservationPatchRequestStatusEnum? status) =>
      this(status: status);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationPatchRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationPatchRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationPatchRequest call({
    Object? customerContact = const $CopyWithPlaceholder(),
    Object? customerName = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? printReservation = const $CopyWithPlaceholder(),
    Object? reservationTypeId = const $CopyWithPlaceholder(),
    Object? reservedAt = const $CopyWithPlaceholder(),
    Object? restaurantTableId = const $CopyWithPlaceholder(),
    Object? sendReservation = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return ReservationPatchRequest(
      customerContact: customerContact == const $CopyWithPlaceholder()
          ? _value.customerContact
          // ignore: cast_nullable_to_non_nullable
          : customerContact as String?,
      customerName: customerName == const $CopyWithPlaceholder()
          ? _value.customerName
          // ignore: cast_nullable_to_non_nullable
          : customerName as String?,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
      printReservation: printReservation == const $CopyWithPlaceholder()
          ? _value.printReservation
          // ignore: cast_nullable_to_non_nullable
          : printReservation as bool?,
      reservationTypeId: reservationTypeId == const $CopyWithPlaceholder()
          ? _value.reservationTypeId
          // ignore: cast_nullable_to_non_nullable
          : reservationTypeId as String?,
      reservedAt: reservedAt == const $CopyWithPlaceholder()
          ? _value.reservedAt
          // ignore: cast_nullable_to_non_nullable
          : reservedAt as DateTime?,
      restaurantTableId: restaurantTableId == const $CopyWithPlaceholder()
          ? _value.restaurantTableId
          // ignore: cast_nullable_to_non_nullable
          : restaurantTableId as String?,
      sendReservation: sendReservation == const $CopyWithPlaceholder()
          ? _value.sendReservation
          // ignore: cast_nullable_to_non_nullable
          : sendReservation as bool?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as ReservationPatchRequestStatusEnum?,
    );
  }
}

extension $ReservationPatchRequestCopyWith on ReservationPatchRequest {
  /// Returns a callable class that can be used as follows: `instanceOfReservationPatchRequest.copyWith(...)` or like so:`instanceOfReservationPatchRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReservationPatchRequestCWProxy get copyWith =>
      _$ReservationPatchRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationPatchRequest _$ReservationPatchRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ReservationPatchRequest',
  json,
  ($checkedConvert) {
    final val = ReservationPatchRequest(
      customerContact: $checkedConvert('customer_contact', (v) => v as String?),
      customerName: $checkedConvert('customer_name', (v) => v as String?),
      notes: $checkedConvert('notes', (v) => v as String?),
      printReservation: $checkedConvert('print_reservation', (v) => v as bool?),
      reservationTypeId: $checkedConvert(
        'reservation_type_id',
        (v) => v as String?,
      ),
      reservedAt: $checkedConvert(
        'reserved_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      restaurantTableId: $checkedConvert(
        'restaurant_table_id',
        (v) => v as String?,
      ),
      sendReservation: $checkedConvert('send_reservation', (v) => v as bool?),
      status: $checkedConvert(
        'status',
        (v) => $enumDecodeNullable(
          _$ReservationPatchRequestStatusEnumEnumMap,
          v,
          unknownValue: ReservationPatchRequestStatusEnum.unknownDefaultOpenApi,
        ),
      ),
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

Map<String, dynamic> _$ReservationPatchRequestToJson(
  ReservationPatchRequest instance,
) => <String, dynamic>{
  'customer_contact': ?instance.customerContact,
  'customer_name': ?instance.customerName,
  'notes': ?instance.notes,
  'print_reservation': ?instance.printReservation,
  'reservation_type_id': ?instance.reservationTypeId,
  'reserved_at': ?instance.reservedAt?.toIso8601String(),
  'restaurant_table_id': ?instance.restaurantTableId,
  'send_reservation': ?instance.sendReservation,
  'status': ?_$ReservationPatchRequestStatusEnumEnumMap[instance.status],
};

const _$ReservationPatchRequestStatusEnumEnumMap = {
  ReservationPatchRequestStatusEnum.booked: 'booked',
  ReservationPatchRequestStatusEnum.confirmed: 'confirmed',
  ReservationPatchRequestStatusEnum.seated: 'seated',
  ReservationPatchRequestStatusEnum.completed: 'completed',
  ReservationPatchRequestStatusEnum.cancelled: 'cancelled',
  ReservationPatchRequestStatusEnum.unknownDefaultOpenApi:
      'unknown_default_open_api',
};
