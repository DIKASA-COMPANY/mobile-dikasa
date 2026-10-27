//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/login_response_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LoginResponse {
  /// Returns a new [LoginResponse] instance.
  LoginResponse({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final LoginResponseData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is LoginResponse && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
