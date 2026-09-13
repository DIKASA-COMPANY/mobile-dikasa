//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LoginResponseData {
  /// Returns a new [LoginResponseData] instance.
  LoginResponseData({
    required this.accessToken,

    required this.expiresIn,

    required this.firebaseUid,

    required this.refreshToken,

    required this.tokenType,
  });

  /// Firebase ID token untuk Authorization Bearer
  @JsonKey(name: r'access_token', required: true, includeIfNull: false)
  final String accessToken;

  @JsonKey(name: r'expires_in', required: true, includeIfNull: false)
  final int expiresIn;

  /// Sama dengan UUID user PostgreSQL
  @JsonKey(name: r'firebase_uid', required: true, includeIfNull: false)
  final String firebaseUid;

  /// Firebase refresh token untuk memperbarui sesi
  @JsonKey(name: r'refresh_token', required: true, includeIfNull: false)
  final String refreshToken;

  @JsonKey(
    name: r'token_type',
    required: true,
    includeIfNull: false,
    unknownEnumValue: LoginResponseDataTokenTypeEnum.unknownDefaultOpenApi,
  )
  final LoginResponseDataTokenTypeEnum tokenType;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginResponseData &&
          other.accessToken == accessToken &&
          other.expiresIn == expiresIn &&
          other.firebaseUid == firebaseUid &&
          other.refreshToken == refreshToken &&
          other.tokenType == tokenType;

  @override
  int get hashCode =>
      accessToken.hashCode +
      expiresIn.hashCode +
      firebaseUid.hashCode +
      refreshToken.hashCode +
      tokenType.hashCode;

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum LoginResponseDataTokenTypeEnum {
  @JsonValue(r'Bearer')
  bearer(r'Bearer'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const LoginResponseDataTokenTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
