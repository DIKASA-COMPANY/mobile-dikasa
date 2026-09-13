//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/gender_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CustomerData {
  /// Returns a new [CustomerData] instance.
  CustomerData({
    required this.address,

    required this.createdAt,

    this.email,

    this.gender,

    required this.id,

    required this.name,

    required this.phoneNumber,

    required this.points,

    required this.updatedAt,
  });

  @JsonKey(name: r'address', required: true, includeIfNull: false)
  final String address;

  @JsonKey(name: r'created_at', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'email', required: false, includeIfNull: false)
  final String? email;

  @JsonKey(name: r'gender', required: false, includeIfNull: false)
  final GenderData? gender;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'phone_number', required: true, includeIfNull: false)
  final String phoneNumber;

  // minimum: 0
  @JsonKey(name: r'points', required: true, includeIfNull: false)
  final int points;

  @JsonKey(name: r'updated_at', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerData &&
          other.address == address &&
          other.createdAt == createdAt &&
          other.email == email &&
          other.gender == gender &&
          other.id == id &&
          other.name == name &&
          other.phoneNumber == phoneNumber &&
          other.points == points &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      address.hashCode +
      createdAt.hashCode +
      email.hashCode +
      gender.hashCode +
      id.hashCode +
      name.hashCode +
      phoneNumber.hashCode +
      points.hashCode +
      updatedAt.hashCode;

  factory CustomerData.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
