//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/preview.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'preview_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PreviewOutputBody {
  /// Returns a new [PreviewOutputBody] instance.
  PreviewOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final Preview data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreviewOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory PreviewOutputBody.fromJson(Map<String, dynamic> json) =>
      _$PreviewOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
