//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_type_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProductTypeData {
  /// Returns a new [ProductTypeData] instance.
  ProductTypeData({
    required this.code,

    required this.id,

    required this.name,

    required this.sortOrder,
  });

  @JsonKey(
    name: r'code',
    required: true,
    includeIfNull: false,
    unknownEnumValue: ProductTypeDataCodeEnum.unknownDefaultOpenApi,
  )
  final ProductTypeDataCodeEnum code;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'sort_order', required: true, includeIfNull: false)
  final int sortOrder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductTypeData &&
          other.code == code &&
          other.id == id &&
          other.name == name &&
          other.sortOrder == sortOrder;

  @override
  int get hashCode =>
      code.hashCode + id.hashCode + name.hashCode + sortOrder.hashCode;

  factory ProductTypeData.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTypeDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ProductTypeDataCodeEnum {
  @JsonValue(r'food')
  food(r'food'),
  @JsonValue(r'drink')
  drink(r'drink'),
  @JsonValue(r'additional')
  additional(r'additional'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const ProductTypeDataCodeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
