//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'open_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OpenRequest {
  /// Returns a new [OpenRequest] instance.
  OpenRequest({required this.openingCash});

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'opening_cash', required: true, includeIfNull: false)
  final int openingCash;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OpenRequest && other.openingCash == openingCash;

  @override
  int get hashCode => openingCash.hashCode;

  factory OpenRequest.fromJson(Map<String, dynamic> json) =>
      _$OpenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OpenRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
