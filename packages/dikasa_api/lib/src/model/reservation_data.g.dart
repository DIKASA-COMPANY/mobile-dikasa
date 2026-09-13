// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReservationDataCWProxy {
  ReservationData createdAt(DateTime createdAt);

  ReservationData createdBy(String createdBy);

  ReservationData customerContact(String customerContact);

  ReservationData customerName(String customerName);

  ReservationData id(String id);

  ReservationData notes(String notes);

  ReservationData printReservation(bool printReservation);

  ReservationData reservationType(TypeData reservationType);

  ReservationData reservedAt(DateTime reservedAt);

  ReservationData restaurantTable(TableData restaurantTable);

  ReservationData sendReservation(bool sendReservation);

  ReservationData status(ReservationDataStatusEnum status);

  ReservationData updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationData(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationData call({
    DateTime createdAt,
    String createdBy,
    String customerContact,
    String customerName,
    String id,
    String notes,
    bool printReservation,
    TypeData reservationType,
    DateTime reservedAt,
    TableData restaurantTable,
    bool sendReservation,
    ReservationDataStatusEnum status,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReservationData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReservationData.copyWith.fieldName(...)`
class _$ReservationDataCWProxyImpl implements _$ReservationDataCWProxy {
  const _$ReservationDataCWProxyImpl(this._value);

  final ReservationData _value;

  @override
  ReservationData createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  ReservationData createdBy(String createdBy) => this(createdBy: createdBy);

  @override
  ReservationData customerContact(String customerContact) =>
      this(customerContact: customerContact);

  @override
  ReservationData customerName(String customerName) =>
      this(customerName: customerName);

  @override
  ReservationData id(String id) => this(id: id);

  @override
  ReservationData notes(String notes) => this(notes: notes);

  @override
  ReservationData printReservation(bool printReservation) =>
      this(printReservation: printReservation);

  @override
  ReservationData reservationType(TypeData reservationType) =>
      this(reservationType: reservationType);

  @override
  ReservationData reservedAt(DateTime reservedAt) =>
      this(reservedAt: reservedAt);

  @override
  ReservationData restaurantTable(TableData restaurantTable) =>
      this(restaurantTable: restaurantTable);

  @override
  ReservationData sendReservation(bool sendReservation) =>
      this(sendReservation: sendReservation);

  @override
  ReservationData status(ReservationDataStatusEnum status) =>
      this(status: status);

  @override
  ReservationData updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReservationData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReservationData(...).copyWith(id: 12, name: "My name")
  /// ````
  ReservationData call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? createdBy = const $CopyWithPlaceholder(),
    Object? customerContact = const $CopyWithPlaceholder(),
    Object? customerName = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? printReservation = const $CopyWithPlaceholder(),
    Object? reservationType = const $CopyWithPlaceholder(),
    Object? reservedAt = const $CopyWithPlaceholder(),
    Object? restaurantTable = const $CopyWithPlaceholder(),
    Object? sendReservation = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return ReservationData(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      createdBy: createdBy == const $CopyWithPlaceholder()
          ? _value.createdBy
          // ignore: cast_nullable_to_non_nullable
          : createdBy as String,
      customerContact: customerContact == const $CopyWithPlaceholder()
          ? _value.customerContact
          // ignore: cast_nullable_to_non_nullable
          : customerContact as String,
      customerName: customerName == const $CopyWithPlaceholder()
          ? _value.customerName
          // ignore: cast_nullable_to_non_nullable
          : customerName as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String,
      printReservation: printReservation == const $CopyWithPlaceholder()
          ? _value.printReservation
          // ignore: cast_nullable_to_non_nullable
          : printReservation as bool,
      reservationType: reservationType == const $CopyWithPlaceholder()
          ? _value.reservationType
          // ignore: cast_nullable_to_non_nullable
          : reservationType as TypeData,
      reservedAt: reservedAt == const $CopyWithPlaceholder()
          ? _value.reservedAt
          // ignore: cast_nullable_to_non_nullable
          : reservedAt as DateTime,
      restaurantTable: restaurantTable == const $CopyWithPlaceholder()
          ? _value.restaurantTable
          // ignore: cast_nullable_to_non_nullable
          : restaurantTable as TableData,
      sendReservation: sendReservation == const $CopyWithPlaceholder()
          ? _value.sendReservation
          // ignore: cast_nullable_to_non_nullable
          : sendReservation as bool,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as ReservationDataStatusEnum,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $ReservationDataCopyWith on ReservationData {
  /// Returns a callable class that can be used as follows: `instanceOfReservationData.copyWith(...)` or like so:`instanceOfReservationData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReservationDataCWProxy get copyWith => _$ReservationDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationData _$ReservationDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ReservationData',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'created_at',
        'created_by',
        'customer_contact',
        'customer_name',
        'id',
        'notes',
        'print_reservation',
        'reservation_type',
        'reserved_at',
        'restaurant_table',
        'send_reservation',
        'status',
        'updated_at',
      ],
    );
    final val = ReservationData(
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      createdBy: $checkedConvert('created_by', (v) => v as String),
      customerContact: $checkedConvert('customer_contact', (v) => v as String),
      customerName: $checkedConvert('customer_name', (v) => v as String),
      id: $checkedConvert('id', (v) => v as String),
      notes: $checkedConvert('notes', (v) => v as String),
      printReservation: $checkedConvert('print_reservation', (v) => v as bool),
      reservationType: $checkedConvert(
        'reservation_type',
        (v) => TypeData.fromJson(v as Map<String, dynamic>),
      ),
      reservedAt: $checkedConvert(
        'reserved_at',
        (v) => DateTime.parse(v as String),
      ),
      restaurantTable: $checkedConvert(
        'restaurant_table',
        (v) => TableData.fromJson(v as Map<String, dynamic>),
      ),
      sendReservation: $checkedConvert('send_reservation', (v) => v as bool),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(
          _$ReservationDataStatusEnumEnumMap,
          v,
          unknownValue: ReservationDataStatusEnum.unknownDefaultOpenApi,
        ),
      ),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'createdAt': 'created_at',
    'createdBy': 'created_by',
    'customerContact': 'customer_contact',
    'customerName': 'customer_name',
    'printReservation': 'print_reservation',
    'reservationType': 'reservation_type',
    'reservedAt': 'reserved_at',
    'restaurantTable': 'restaurant_table',
    'sendReservation': 'send_reservation',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$ReservationDataToJson(ReservationData instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'customer_contact': instance.customerContact,
      'customer_name': instance.customerName,
      'id': instance.id,
      'notes': instance.notes,
      'print_reservation': instance.printReservation,
      'reservation_type': instance.reservationType.toJson(),
      'reserved_at': instance.reservedAt.toIso8601String(),
      'restaurant_table': instance.restaurantTable.toJson(),
      'send_reservation': instance.sendReservation,
      'status': _$ReservationDataStatusEnumEnumMap[instance.status]!,
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$ReservationDataStatusEnumEnumMap = {
  ReservationDataStatusEnum.booked: 'booked',
  ReservationDataStatusEnum.confirmed: 'confirmed',
  ReservationDataStatusEnum.seated: 'seated',
  ReservationDataStatusEnum.completed: 'completed',
  ReservationDataStatusEnum.cancelled: 'cancelled',
  ReservationDataStatusEnum.unknownDefaultOpenApi: 'unknown_default_open_api',
};
