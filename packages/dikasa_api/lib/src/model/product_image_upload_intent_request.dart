//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_image_upload_intent_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProductImageUploadIntentRequest {
  /// Returns a new [ProductImageUploadIntentRequest] instance.
  ProductImageUploadIntentRequest({
    required this.contentType,

    required this.size,
  });

  @JsonKey(
    name: r'content_type',
    required: true,
    includeIfNull: false,
    unknownEnumValue:
        ProductImageUploadIntentRequestContentTypeEnum.unknownDefaultOpenApi,
  )
  final ProductImageUploadIntentRequestContentTypeEnum contentType;

  /// Declared byte size; values above 3145728 return 413.
  // minimum: 1
  @JsonKey(name: r'size', required: true, includeIfNull: false)
  final int size;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductImageUploadIntentRequest &&
          other.contentType == contentType &&
          other.size == size;

  @override
  int get hashCode => contentType.hashCode + size.hashCode;

  factory ProductImageUploadIntentRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductImageUploadIntentRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ProductImageUploadIntentRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ProductImageUploadIntentRequestContentTypeEnum {
  @JsonValue(r'image/png')
  imageSlashPng(r'image/png'),
  @JsonValue(r'image/jpeg')
  imageSlashJpeg(r'image/jpeg'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const ProductImageUploadIntentRequestContentTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
