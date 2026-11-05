//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_biometric_input_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AttendanceBiometricInputBody {
  /// Returns a new [AttendanceBiometricInputBody] instance.
  AttendanceBiometricInputBody({
    required this.challengeId,

    required this.signature,
  });

  @JsonKey(name: r'challenge_id', required: true, includeIfNull: false)
  final String challengeId;

  @JsonKey(name: r'signature', required: true, includeIfNull: false)
  final String signature;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceBiometricInputBody &&
          other.challengeId == challengeId &&
          other.signature == signature;

  @override
  int get hashCode => challengeId.hashCode + signature.hashCode;

  factory AttendanceBiometricInputBody.fromJson(Map<String, dynamic> json) =>
      _$AttendanceBiometricInputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceBiometricInputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
