//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movement_capabilities.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MovementCapabilities {
  /// Returns a new [MovementCapabilities] instance.
  MovementCapabilities({required this.canCreate, required this.canUploadProof});

  @JsonKey(name: r'can_create', required: true, includeIfNull: false)
  final bool canCreate;

  @JsonKey(name: r'can_upload_proof', required: true, includeIfNull: false)
  final bool canUploadProof;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovementCapabilities &&
          other.canCreate == canCreate &&
          other.canUploadProof == canUploadProof;

  @override
  int get hashCode => canCreate.hashCode + canUploadProof.hashCode;

  factory MovementCapabilities.fromJson(Map<String, dynamic> json) =>
      _$MovementCapabilitiesFromJson(json);

  Map<String, dynamic> toJson() => _$MovementCapabilitiesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
