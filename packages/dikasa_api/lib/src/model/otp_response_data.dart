//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OTPResponseData {
  /// Returns a new [OTPResponseData] instance.
  OTPResponseData({
    required this.email,

    required this.otpExpiresIn,

    required this.resendAvailableIn,
  });

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @JsonKey(name: r'otp_expires_in', required: true, includeIfNull: false)
  final int otpExpiresIn;

  @JsonKey(name: r'resend_available_in', required: true, includeIfNull: false)
  final int resendAvailableIn;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OTPResponseData &&
          other.email == email &&
          other.otpExpiresIn == otpExpiresIn &&
          other.resendAvailableIn == resendAvailableIn;

  @override
  int get hashCode =>
      email.hashCode + otpExpiresIn.hashCode + resendAvailableIn.hashCode;

  factory OTPResponseData.fromJson(Map<String, dynamic> json) =>
      _$OTPResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$OTPResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
