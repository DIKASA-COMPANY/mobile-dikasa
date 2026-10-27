//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'health_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class HealthOutputBody {
  /// Returns a new [HealthOutputBody] instance.
  HealthOutputBody({required this.service, required this.status});

  @JsonKey(name: r'service', required: true, includeIfNull: false)
  final String service;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final String status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthOutputBody &&
          other.service == service &&
          other.status == status;

  @override
  int get hashCode => service.hashCode + status.hashCode;

  factory HealthOutputBody.fromJson(Map<String, dynamic> json) =>
      _$HealthOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$HealthOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
