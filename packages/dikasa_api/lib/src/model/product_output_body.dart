//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/product_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProductOutputBody {
  /// Returns a new [ProductOutputBody] instance.
  ProductOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final ProductData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory ProductOutputBody.fromJson(Map<String, dynamic> json) =>
      _$ProductOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
