//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RegisterRequest {
  /// Returns a new [RegisterRequest] instance.
  RegisterRequest({
    required this.businessAddress,

    this.businessEmail,

    required this.businessName,

    required this.businessPhone,

    required this.ownerDateOfBirth,

    required this.ownerEmail,

    required this.ownerName,

    required this.ownerPhone,

    required this.password,

    required this.passwordConfirmation,

    required this.username,

    required this.verificationEmail,
  });

  @JsonKey(name: r'business_address', required: true, includeIfNull: false)
  final String businessAddress;

  @JsonKey(name: r'business_email', required: false, includeIfNull: false)
  final String? businessEmail;

  @JsonKey(name: r'business_name', required: true, includeIfNull: false)
  final String businessName;

  @JsonKey(name: r'business_phone', required: true, includeIfNull: false)
  final String businessPhone;

  @JsonKey(name: r'owner_date_of_birth', required: true, includeIfNull: false)
  final DateTime ownerDateOfBirth;

  @JsonKey(name: r'owner_email', required: true, includeIfNull: false)
  final String ownerEmail;

  @JsonKey(name: r'owner_name', required: true, includeIfNull: false)
  final String ownerName;

  @JsonKey(name: r'owner_phone', required: true, includeIfNull: false)
  final String ownerPhone;

  @JsonKey(name: r'password', required: true, includeIfNull: false)
  final String password;

  @JsonKey(name: r'password_confirmation', required: true, includeIfNull: false)
  final String passwordConfirmation;

  @JsonKey(name: r'username', required: true, includeIfNull: false)
  final String username;

  @JsonKey(name: r'verification_email', required: true, includeIfNull: false)
  final String verificationEmail;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterRequest &&
          other.businessAddress == businessAddress &&
          other.businessEmail == businessEmail &&
          other.businessName == businessName &&
          other.businessPhone == businessPhone &&
          other.ownerDateOfBirth == ownerDateOfBirth &&
          other.ownerEmail == ownerEmail &&
          other.ownerName == ownerName &&
          other.ownerPhone == ownerPhone &&
          other.password == password &&
          other.passwordConfirmation == passwordConfirmation &&
          other.username == username &&
          other.verificationEmail == verificationEmail;

  @override
  int get hashCode =>
      businessAddress.hashCode +
      businessEmail.hashCode +
      businessName.hashCode +
      businessPhone.hashCode +
      ownerDateOfBirth.hashCode +
      ownerEmail.hashCode +
      ownerName.hashCode +
      ownerPhone.hashCode +
      password.hashCode +
      passwordConfirmation.hashCode +
      username.hashCode +
      verificationEmail.hashCode;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
