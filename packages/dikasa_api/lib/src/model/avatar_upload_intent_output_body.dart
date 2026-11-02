//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/avatar_upload_intent_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'avatar_upload_intent_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AvatarUploadIntentOutputBody {
  /// Returns a new [AvatarUploadIntentOutputBody] instance.
  AvatarUploadIntentOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final AvatarUploadIntentData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvatarUploadIntentOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory AvatarUploadIntentOutputBody.fromJson(Map<String, dynamic> json) =>
      _$AvatarUploadIntentOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarUploadIntentOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
