//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/product_image_upload_intent_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_image_upload_intent_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProductImageUploadIntentOutputBody {
  /// Returns a new [ProductImageUploadIntentOutputBody] instance.
  ProductImageUploadIntentOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final ProductImageUploadIntentData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductImageUploadIntentOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory ProductImageUploadIntentOutputBody.fromJson(
    Map<String, dynamic> json,
  ) => _$ProductImageUploadIntentOutputBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ProductImageUploadIntentOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
