//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/proof_link.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movement_proof_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MovementProofOutputBody {
  /// Returns a new [MovementProofOutputBody] instance.
  MovementProofOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final ProofLink data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovementProofOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory MovementProofOutputBody.fromJson(Map<String, dynamic> json) =>
      _$MovementProofOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$MovementProofOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
