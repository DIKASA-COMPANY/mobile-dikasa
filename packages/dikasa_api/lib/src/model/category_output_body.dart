//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/category_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CategoryOutputBody {
  /// Returns a new [CategoryOutputBody] instance.
  CategoryOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final CategoryData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory CategoryOutputBody.fromJson(Map<String, dynamic> json) =>
      _$CategoryOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
