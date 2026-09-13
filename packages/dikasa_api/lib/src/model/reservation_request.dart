//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReservationRequest {
  /// Returns a new [ReservationRequest] instance.
  ReservationRequest({
    required this.customerContact,

    required this.customerName,

    required this.notes,

    required this.printReservation,

    required this.reservationTypeId,

    required this.reservedAt,

    required this.restaurantTableId,

    required this.sendReservation,
  });

  @JsonKey(name: r'customer_contact', required: true, includeIfNull: false)
  final String customerContact;

  @JsonKey(name: r'customer_name', required: true, includeIfNull: false)
  final String customerName;

  @JsonKey(name: r'notes', required: true, includeIfNull: false)
  final String notes;

  @JsonKey(name: r'print_reservation', required: true, includeIfNull: false)
  final bool printReservation;

  @JsonKey(name: r'reservation_type_id', required: true, includeIfNull: false)
  final String reservationTypeId;

  @JsonKey(name: r'reserved_at', required: true, includeIfNull: false)
  final DateTime reservedAt;

  @JsonKey(name: r'restaurant_table_id', required: true, includeIfNull: false)
  final String restaurantTableId;

  @JsonKey(name: r'send_reservation', required: true, includeIfNull: false)
  final bool sendReservation;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReservationRequest &&
          other.customerContact == customerContact &&
          other.customerName == customerName &&
          other.notes == notes &&
          other.printReservation == printReservation &&
          other.reservationTypeId == reservationTypeId &&
          other.reservedAt == reservedAt &&
          other.restaurantTableId == restaurantTableId &&
          other.sendReservation == sendReservation;

  @override
  int get hashCode =>
      customerContact.hashCode +
      customerName.hashCode +
      notes.hashCode +
      printReservation.hashCode +
      reservationTypeId.hashCode +
      reservedAt.hashCode +
      restaurantTableId.hashCode +
      sendReservation.hashCode;

  factory ReservationRequest.fromJson(Map<String, dynamic> json) =>
      _$ReservationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
