//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/otp_response_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OTPResponse {
  /// Returns a new [OTPResponse] instance.
  OTPResponse({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final OTPResponseData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OTPResponse && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory OTPResponse.fromJson(Map<String, dynamic> json) =>
      _$OTPResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OTPResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
