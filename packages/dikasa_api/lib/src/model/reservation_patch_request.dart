//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation_patch_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReservationPatchRequest {
  /// Returns a new [ReservationPatchRequest] instance.
  ReservationPatchRequest({
    this.customerContact,

    this.customerName,

    this.notes,

    this.printReservation,

    this.reservationTypeId,

    this.reservedAt,

    this.restaurantTableId,

    this.sendReservation,

    this.status,
  });

  @JsonKey(name: r'customer_contact', required: false, includeIfNull: false)
  final String? customerContact;

  @JsonKey(name: r'customer_name', required: false, includeIfNull: false)
  final String? customerName;

  @JsonKey(name: r'notes', required: false, includeIfNull: false)
  final String? notes;

  @JsonKey(name: r'print_reservation', required: false, includeIfNull: false)
  final bool? printReservation;

  @JsonKey(name: r'reservation_type_id', required: false, includeIfNull: false)
  final String? reservationTypeId;

  @JsonKey(name: r'reserved_at', required: false, includeIfNull: false)
  final DateTime? reservedAt;

  @JsonKey(name: r'restaurant_table_id', required: false, includeIfNull: false)
  final String? restaurantTableId;

  @JsonKey(name: r'send_reservation', required: false, includeIfNull: false)
  final bool? sendReservation;

  @JsonKey(
    name: r'status',
    required: false,
    includeIfNull: false,
    unknownEnumValue: ReservationPatchRequestStatusEnum.unknownDefaultOpenApi,
  )
  final ReservationPatchRequestStatusEnum? status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReservationPatchRequest &&
          other.customerContact == customerContact &&
          other.customerName == customerName &&
          other.notes == notes &&
          other.printReservation == printReservation &&
          other.reservationTypeId == reservationTypeId &&
          other.reservedAt == reservedAt &&
          other.restaurantTableId == restaurantTableId &&
          other.sendReservation == sendReservation &&
          other.status == status;

  @override
  int get hashCode =>
      customerContact.hashCode +
      customerName.hashCode +
      notes.hashCode +
      printReservation.hashCode +
      reservationTypeId.hashCode +
      reservedAt.hashCode +
      restaurantTableId.hashCode +
      sendReservation.hashCode +
      status.hashCode;

  factory ReservationPatchRequest.fromJson(Map<String, dynamic> json) =>
      _$ReservationPatchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationPatchRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ReservationPatchRequestStatusEnum {
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

  const ReservationPatchRequestStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
