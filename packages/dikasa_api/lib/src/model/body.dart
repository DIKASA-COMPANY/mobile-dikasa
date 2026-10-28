//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Body {
  /// Returns a new [Body] instance.
  Body({required this.code, this.details, required this.message});

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'details', required: false, includeIfNull: false)
  final Map<String, String>? details;

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Body &&
          other.code == code &&
          other.details == details &&
          other.message == message;

  @override
  int get hashCode => code.hashCode + details.hashCode + message.hashCode;

  factory Body.fromJson(Map<String, dynamic> json) => _$BodyFromJson(json);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
