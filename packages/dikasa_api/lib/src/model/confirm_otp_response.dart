//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/confirm_otp_response_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_otp_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConfirmOTPResponse {
  /// Returns a new [ConfirmOTPResponse] instance.
  ConfirmOTPResponse({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final ConfirmOTPResponseData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfirmOTPResponse && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory ConfirmOTPResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmOTPResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmOTPResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
