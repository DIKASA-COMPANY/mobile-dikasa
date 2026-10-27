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

    this.email,

    required this.firstName,

    this.genderId,

    required this.id,

    required this.isActive,

    required this.lastName,

    this.outletId,

    required this.phoneNumber,

    required this.roleId,

    required this.username,
  });

  @JsonKey(name: r'avatar_url', required: false, includeIfNull: false)
  final String? avatarUrl;

  @JsonKey(name: r'email', required: false, includeIfNull: false)
  final String? email;

  @JsonKey(name: r'first_name', required: true, includeIfNull: false)
  final String firstName;

  @JsonKey(name: r'gender_id', required: false, includeIfNull: false)
  final String? genderId;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'is_active', required: true, includeIfNull: false)
  final bool isActive;

  @JsonKey(name: r'last_name', required: true, includeIfNull: false)
  final String lastName;

  @JsonKey(name: r'outlet_id', required: false, includeIfNull: false)
  final String? outletId;

  @JsonKey(name: r'phone_number', required: true, includeIfNull: false)
  final String phoneNumber;

  @JsonKey(name: r'role_id', required: true, includeIfNull: false)
  final String roleId;

  @JsonKey(name: r'username', required: true, includeIfNull: false)
  final String username;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Profile &&
          other.avatarUrl == avatarUrl &&
          other.email == email &&
          other.firstName == firstName &&
          other.genderId == genderId &&
          other.id == id &&
          other.isActive == isActive &&
          other.lastName == lastName &&
          other.outletId == outletId &&
          other.phoneNumber == phoneNumber &&
          other.roleId == roleId &&
          other.username == username;

  @override
  int get hashCode =>
      avatarUrl.hashCode +
      email.hashCode +
      firstName.hashCode +
      genderId.hashCode +
      id.hashCode +
      isActive.hashCode +
      lastName.hashCode +
      outletId.hashCode +
      phoneNumber.hashCode +
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
