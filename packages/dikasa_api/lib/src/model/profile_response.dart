//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/profile.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProfileResponse {
  /// Returns a new [ProfileResponse] instance.
  ProfileResponse({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final Profile data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ProfileResponse && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
