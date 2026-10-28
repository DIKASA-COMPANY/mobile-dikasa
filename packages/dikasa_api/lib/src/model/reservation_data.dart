//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/table_data.dart';
import 'package:dikasa_api/src/model/type_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReservationData {
  /// Returns a new [ReservationData] instance.
  ReservationData({
    required this.createdAt,

    required this.createdBy,

    required this.customerContact,

    required this.customerName,

    required this.id,

    required this.notes,

    required this.printReservation,

    required this.reservationType,

    required this.reservedAt,

    required this.restaurantTable,

    required this.sendReservation,

    required this.status,

    required this.updatedAt,
  });

  @JsonKey(name: r'created_at', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'created_by', required: true, includeIfNull: false)
  final String createdBy;

  @JsonKey(name: r'customer_contact', required: true, includeIfNull: false)
  final String customerContact;

  @JsonKey(name: r'customer_name', required: true, includeIfNull: false)
  final String customerName;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'notes', required: true, includeIfNull: false)
  final String notes;

  @JsonKey(name: r'print_reservation', required: true, includeIfNull: false)
  final bool printReservation;

  @JsonKey(name: r'reservation_type', required: true, includeIfNull: false)
  final TypeData reservationType;

  @JsonKey(name: r'reserved_at', required: true, includeIfNull: false)
  final DateTime reservedAt;

  @JsonKey(name: r'restaurant_table', required: true, includeIfNull: false)
  final TableData restaurantTable;

  @JsonKey(name: r'send_reservation', required: true, includeIfNull: false)
  final bool sendReservation;

  @JsonKey(
    name: r'status',
    required: true,
    includeIfNull: false,
    unknownEnumValue: ReservationDataStatusEnum.unknownDefaultOpenApi,
  )
  final ReservationDataStatusEnum status;

  @JsonKey(name: r'updated_at', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReservationData &&
          other.createdAt == createdAt &&
          other.createdBy == createdBy &&
          other.customerContact == customerContact &&
          other.customerName == customerName &&
          other.id == id &&
          other.notes == notes &&
          other.printReservation == printReservation &&
          other.reservationType == reservationType &&
          other.reservedAt == reservedAt &&
          other.restaurantTable == restaurantTable &&
          other.sendReservation == sendReservation &&
          other.status == status &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      createdAt.hashCode +
      createdBy.hashCode +
      customerContact.hashCode +
      customerName.hashCode +
      id.hashCode +
      notes.hashCode +
      printReservation.hashCode +
      reservationType.hashCode +
      reservedAt.hashCode +
      restaurantTable.hashCode +
      sendReservation.hashCode +
      status.hashCode +
      updatedAt.hashCode;

  factory ReservationData.fromJson(Map<String, dynamic> json) =>
      _$ReservationDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ReservationDataStatusEnum {
  @JsonValue(r'booked')
  booked(r'booked'),
  @JsonValue(r'confirmed')
  confirmed(r'confirmed'),
  @JsonValue(r'seated')
  seated(r'seated'),
  @JsonValue(r'completed')
  completed(r'completed'),
  @JsonValue(r'cancelled')
  cancelled(r'cancelled'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const ReservationDataStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
