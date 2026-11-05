//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'proof_upload_intent_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProofUploadIntentRequest {
  /// Returns a new [ProofUploadIntentRequest] instance.
  ProofUploadIntentRequest({
    required this.contentType,

    required this.requestId,

    required this.size,
  });

  @JsonKey(
    name: r'content_type',
    required: true,
    includeIfNull: false,
    unknownEnumValue:
        ProofUploadIntentRequestContentTypeEnum.unknownDefaultOpenApi,
  )
  final ProofUploadIntentRequestContentTypeEnum contentType;

  @JsonKey(name: r'request_id', required: true, includeIfNull: false)
  final String requestId;

  /// Declared byte size; values above 3145728 return 413.
  // minimum: 1
  @JsonKey(name: r'size', required: true, includeIfNull: false)
  final int size;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProofUploadIntentRequest &&
          other.contentType == contentType &&
          other.requestId == requestId &&
          other.size == size;

  @override
  int get hashCode => contentType.hashCode + requestId.hashCode + size.hashCode;

  factory ProofUploadIntentRequest.fromJson(Map<String, dynamic> json) =>
      _$ProofUploadIntentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProofUploadIntentRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ProofUploadIntentRequestContentTypeEnum {
  @JsonValue(r'image/png')
  imageSlashPng(r'image/png'),
  @JsonValue(r'image/jpeg')
  imageSlashJpeg(r'image/jpeg'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const ProofUploadIntentRequestContentTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
