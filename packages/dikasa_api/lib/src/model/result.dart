//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/meta.dart';
import 'package:dikasa_api/src/model/report.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Result {
  /// Returns a new [Result] instance.
  Result({required this.data, required this.meta});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final Report data;

  @JsonKey(name: r'meta', required: true, includeIfNull: false)
  final Meta meta;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Result && other.data == data && other.meta == meta;

  @override
  int get hashCode => data.hashCode + meta.hashCode;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
