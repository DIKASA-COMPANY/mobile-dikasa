//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/category_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categories_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CategoriesOutputBody {
  /// Returns a new [CategoriesOutputBody] instance.
  CategoriesOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<CategoryData>? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesOutputBody && other.data == data;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode);

  factory CategoriesOutputBody.fromJson(Map<String, dynamic> json) =>
      _$CategoriesOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
