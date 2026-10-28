//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'proof_link.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProofLink {
  /// Returns a new [ProofLink] instance.
  ProofLink({required this.url});

  /// Firebase Storage download URL for direct client rendering
  @JsonKey(name: r'url', required: true, includeIfNull: false)
  final String url;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ProofLink && other.url == url;

  @override
  int get hashCode => url.hashCode;

  factory ProofLink.fromJson(Map<String, dynamic> json) =>
      _$ProofLinkFromJson(json);

  Map<String, dynamic> toJson() => _$ProofLinkToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
