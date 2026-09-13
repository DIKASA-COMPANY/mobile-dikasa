//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_otp_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConfirmOTPRequest {
  /// Returns a new [ConfirmOTPRequest] instance.
  ConfirmOTPRequest({required this.email, required this.otp});

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @JsonKey(name: r'otp', required: true, includeIfNull: false)
  final String otp;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfirmOTPRequest && other.email == email && other.otp == otp;

  @override
  int get hashCode => email.hashCode + otp.hashCode;

  factory ConfirmOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmOTPRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmOTPRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
