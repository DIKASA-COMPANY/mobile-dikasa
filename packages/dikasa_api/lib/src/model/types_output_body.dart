//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/type_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'types_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TypesOutputBody {
  /// Returns a new [TypesOutputBody] instance.
  TypesOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<TypeData>? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TypesOutputBody && other.data == data;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode);

  factory TypesOutputBody.fromJson(Map<String, dynamic> json) =>
      _$TypesOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TypesOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
