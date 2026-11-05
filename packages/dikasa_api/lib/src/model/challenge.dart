//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'challenge.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Challenge {
  /// Returns a new [Challenge] instance.
  Challenge({required this.expiresAt, required this.id, required this.payload});

  @JsonKey(name: r'expires_at', required: true, includeIfNull: false)
  final DateTime expiresAt;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'payload', required: true, includeIfNull: false)
  final String payload;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Challenge &&
          other.expiresAt == expiresAt &&
          other.id == id &&
          other.payload == payload;

  @override
  int get hashCode => expiresAt.hashCode + id.hashCode + payload.hashCode;

  factory Challenge.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
