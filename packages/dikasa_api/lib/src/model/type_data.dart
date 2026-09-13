//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'type_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TypeData {
  /// Returns a new [TypeData] instance.
  TypeData({
    required this.code,

    required this.id,

    required this.name,

    required this.sortOrder,
  });

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'sort_order', required: true, includeIfNull: false)
  final int sortOrder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeData &&
          other.code == code &&
          other.id == id &&
          other.name == name &&
          other.sortOrder == sortOrder;

  @override
  int get hashCode =>
      code.hashCode + id.hashCode + name.hashCode + sortOrder.hashCode;

  factory TypeData.fromJson(Map<String, dynamic> json) =>
      _$TypeDataFromJson(json);

  Map<String, dynamic> toJson() => _$TypeDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
