//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_list_type_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderListTypeData {
  /// Returns a new [OrderListTypeData] instance.
  OrderListTypeData({required this.code, required this.id, required this.name});

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderListTypeData &&
          other.code == code &&
          other.id == id &&
          other.name == name;

  @override
  int get hashCode => code.hashCode + id.hashCode + name.hashCode;

  factory OrderListTypeData.fromJson(Map<String, dynamic> json) =>
      _$OrderListTypeDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderListTypeDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
