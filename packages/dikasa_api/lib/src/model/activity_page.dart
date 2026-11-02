//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/activity_data.dart';
import 'package:dikasa_api/src/model/activity_meta.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_page.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ActivityPage {
  /// Returns a new [ActivityPage] instance.
  ActivityPage({required this.data, required this.meta});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final ActivityData data;

  @JsonKey(name: r'meta', required: true, includeIfNull: false)
  final ActivityMeta meta;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityPage && other.data == data && other.meta == meta;

  @override
  int get hashCode => data.hashCode + meta.hashCode;

  factory ActivityPage.fromJson(Map<String, dynamic> json) =>
      _$ActivityPageFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityPageToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
