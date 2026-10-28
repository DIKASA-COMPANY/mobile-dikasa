//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Profile {
  /// Returns a new [Profile] instance.
  Profile({
    this.avatarUrl,

    required this.canChangePassword,

    required this.dateOfBirth,

    this.email,

    required this.firstName,

    this.genderId,

    required this.genderName,

    required this.hasPin,

    required this.id,

    required this.isActive,

    required this.lastName,

    this.outletId,

    required this.outletName,

    required this.personalAddress,

    required this.phoneNumber,

    required this.role,

    required this.roleId,

    required this.username,
  });

  /// Firebase Storage download URL for direct client rendering
  @JsonKey(name: r'avatar_url', required: false, includeIfNull: false)
  final String? avatarUrl;

  @JsonKey(name: r'can_change_password', required: true, includeIfNull: false)
  final bool canChangePassword;

  @JsonKey(name: r'date_of_birth', required: true, includeIfNull: true)
  final String? dateOfBirth;

  @JsonKey(name: r'email', required: false, includeIfNull: false)
  final String? email;

  @JsonKey(name: r'first_name', required: true, includeIfNull: false)
  final String firstName;

  @JsonKey(name: r'gender_id', required: false, includeIfNull: false)
  final String? genderId;

  @JsonKey(name: r'gender_name', required: true, includeIfNull: true)
  final String? genderName;

  @JsonKey(name: r'has_pin', required: true, includeIfNull: false)
  final bool hasPin;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'is_active', required: true, includeIfNull: false)
  final bool isActive;

  @JsonKey(name: r'last_name', required: true, includeIfNull: false)
  final String lastName;

  @JsonKey(name: r'outlet_id', required: false, includeIfNull: false)
  final String? outletId;

  @JsonKey(name: r'outlet_name', required: true, includeIfNull: false)
  final String outletName;

  @JsonKey(name: r'personal_address', required: true, includeIfNull: true)
  final String? personalAddress;

  @JsonKey(name: r'phone_number', required: true, includeIfNull: false)
  final String phoneNumber;

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final String role;

  @JsonKey(name: r'role_id', required: true, includeIfNull: false)
  final String roleId;

  @JsonKey(name: r'username', required: true, includeIfNull: false)
  final String username;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Profile &&
          other.avatarUrl == avatarUrl &&
          other.canChangePassword == canChangePassword &&
          other.dateOfBirth == dateOfBirth &&
          other.email == email &&
          other.firstName == firstName &&
          other.genderId == genderId &&
          other.genderName == genderName &&
          other.hasPin == hasPin &&
          other.id == id &&
          other.isActive == isActive &&
          other.lastName == lastName &&
          other.outletId == outletId &&
          other.outletName == outletName &&
          other.personalAddress == personalAddress &&
          other.phoneNumber == phoneNumber &&
          other.role == role &&
          other.roleId == roleId &&
          other.username == username;

  @override
  int get hashCode =>
      avatarUrl.hashCode +
      canChangePassword.hashCode +
      (dateOfBirth == null ? 0 : dateOfBirth.hashCode) +
      email.hashCode +
      firstName.hashCode +
      genderId.hashCode +
      (genderName == null ? 0 : genderName.hashCode) +
      hasPin.hashCode +
      id.hashCode +
      isActive.hashCode +
      lastName.hashCode +
      outletId.hashCode +
      outletName.hashCode +
      (personalAddress == null ? 0 : personalAddress.hashCode) +
      phoneNumber.hashCode +
      role.hashCode +
      roleId.hashCode +
      username.hashCode;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
