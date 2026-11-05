//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/proof_upload_intent_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'proof_upload_intent_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProofUploadIntentOutputBody {
  /// Returns a new [ProofUploadIntentOutputBody] instance.
  ProofUploadIntentOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final ProofUploadIntentData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProofUploadIntentOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory ProofUploadIntentOutputBody.fromJson(Map<String, dynamic> json) =>
      _$ProofUploadIntentOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ProofUploadIntentOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
