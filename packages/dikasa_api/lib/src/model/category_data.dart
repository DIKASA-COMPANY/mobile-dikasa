//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CategoryData {
  /// Returns a new [CategoryData] instance.
  CategoryData({
    required this.id,

    required this.isActive,

    required this.name,

    required this.sortOrder,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'is_active', required: true, includeIfNull: false)
  final bool isActive;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'sort_order', required: true, includeIfNull: false)
  final int sortOrder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryData &&
          other.id == id &&
          other.isActive == isActive &&
          other.name == name &&
          other.sortOrder == sortOrder;

  @override
  int get hashCode =>
      id.hashCode + isActive.hashCode + name.hashCode + sortOrder.hashCode;

  factory CategoryData.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
