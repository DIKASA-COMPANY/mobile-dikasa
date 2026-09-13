//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_otp_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConfirmOTPResponseData {
  /// Returns a new [ConfirmOTPResponseData] instance.
  ConfirmOTPResponseData({required this.verified});

  @JsonKey(name: r'verified', required: true, includeIfNull: false)
  final bool verified;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfirmOTPResponseData && other.verified == verified;

  @override
  int get hashCode => verified.hashCode;

  factory ConfirmOTPResponseData.fromJson(Map<String, dynamic> json) =>
      _$ConfirmOTPResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmOTPResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
