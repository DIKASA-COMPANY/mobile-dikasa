//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/reservation_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReservationOutputBody {
  /// Returns a new [ReservationOutputBody] instance.
  ReservationOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final ReservationData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReservationOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory ReservationOutputBody.fromJson(Map<String, dynamic> json) =>
      _$ReservationOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
