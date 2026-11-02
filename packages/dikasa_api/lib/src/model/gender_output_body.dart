//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/gender_choice.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gender_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GenderOutputBody {
  /// Returns a new [GenderOutputBody] instance.
  GenderOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<GenderChoice>? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is GenderOutputBody && other.data == data;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode);

  factory GenderOutputBody.fromJson(Map<String, dynamic> json) =>
      _$GenderOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$GenderOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
