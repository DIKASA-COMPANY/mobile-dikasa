//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/product_type_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_types_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProductTypesOutputBody {
  /// Returns a new [ProductTypesOutputBody] instance.
  ProductTypesOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<ProductTypeData>? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductTypesOutputBody && other.data == data;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode);

  factory ProductTypesOutputBody.fromJson(Map<String, dynamic> json) =>
      _$ProductTypesOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTypesOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
