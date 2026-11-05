//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_enrollment_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceEnrollmentRequest {
  /// Returns a new [AttendanceEnrollmentRequest] instance.
  AttendanceEnrollmentRequest({required this.pin, required this.publicKey});

  @JsonKey(name: r'pin', required: true, includeIfNull: false)
  final String pin;

  @JsonKey(name: r'public_key', required: true, includeIfNull: false)
  final String publicKey;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceEnrollmentRequest &&
          other.pin == pin &&
          other.publicKey == publicKey;

  @override
  int get hashCode => pin.hashCode + publicKey.hashCode;

  factory AttendanceEnrollmentRequest.fromJson(Map<String, dynamic> json) =>
      _$AttendanceEnrollmentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceEnrollmentRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
