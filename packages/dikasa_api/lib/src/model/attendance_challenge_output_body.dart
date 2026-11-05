//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/challenge.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_challenge_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceChallengeOutputBody {
  /// Returns a new [AttendanceChallengeOutputBody] instance.
  AttendanceChallengeOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final Challenge data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceChallengeOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory AttendanceChallengeOutputBody.fromJson(Map<String, dynamic> json) =>
      _$AttendanceChallengeOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceChallengeOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
