//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/body.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'status_error.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StatusError {
  /// Returns a new [StatusError] instance.
  StatusError({required this.error});

  @JsonKey(name: r'error', required: true, includeIfNull: false)
  final Body error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is StatusError && other.error == error;

  @override
  int get hashCode => error.hashCode;

  factory StatusError.fromJson(Map<String, dynamic> json) =>
      _$StatusErrorFromJson(json);

  Map<String, dynamic> toJson() => _$StatusErrorToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
