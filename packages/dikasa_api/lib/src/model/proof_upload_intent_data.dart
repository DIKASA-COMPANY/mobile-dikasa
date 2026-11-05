//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'proof_upload_intent_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProofUploadIntentData {
  /// Returns a new [ProofUploadIntentData] instance.
  ProofUploadIntentData({
    required this.expiresIn,

    required this.objectName,

    required this.uploadUrl,
  });

  // minimum: 1
  @JsonKey(name: r'expires_in', required: true, includeIfNull: false)
  final int expiresIn;

  @JsonKey(name: r'object_name', required: true, includeIfNull: false)
  final String objectName;

  @JsonKey(name: r'upload_url', required: true, includeIfNull: false)
  final String uploadUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProofUploadIntentData &&
          other.expiresIn == expiresIn &&
          other.objectName == objectName &&
          other.uploadUrl == uploadUrl;

  @override
  int get hashCode =>
      expiresIn.hashCode + objectName.hashCode + uploadUrl.hashCode;

  factory ProofUploadIntentData.fromJson(Map<String, dynamic> json) =>
      _$ProofUploadIntentDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProofUploadIntentDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
