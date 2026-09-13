//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_type_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderTypeData {
  /// Returns a new [OrderTypeData] instance.
  OrderTypeData({
    required this.code,

    this.iconKey,

    required this.id,

    required this.isActive,

    required this.name,

    required this.sortOrder,
  });

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'icon_key', required: false, includeIfNull: false)
  final String? iconKey;

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
      other is OrderTypeData &&
          other.code == code &&
          other.iconKey == iconKey &&
          other.id == id &&
          other.isActive == isActive &&
          other.name == name &&
          other.sortOrder == sortOrder;

  @override
  int get hashCode =>
      code.hashCode +
      iconKey.hashCode +
      id.hashCode +
      isActive.hashCode +
      name.hashCode +
      sortOrder.hashCode;

  factory OrderTypeData.fromJson(Map<String, dynamic> json) =>
      _$OrderTypeDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTypeDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
