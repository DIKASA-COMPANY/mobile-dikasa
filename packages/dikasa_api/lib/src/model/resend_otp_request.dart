//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resend_otp_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ResendOTPRequest {
  /// Returns a new [ResendOTPRequest] instance.
  ResendOTPRequest({required this.email});

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResendOTPRequest && other.email == email;

  @override
  int get hashCode => email.hashCode;

  factory ResendOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendOTPRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResendOTPRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
