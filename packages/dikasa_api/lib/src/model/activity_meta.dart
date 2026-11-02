//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_meta.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ActivityMeta {
  /// Returns a new [ActivityMeta] instance.
  ActivityMeta({
    required this.page,

    required this.pageSize,

    required this.total,
  });

  @JsonKey(name: r'page', required: true, includeIfNull: false)
  final int page;

  @JsonKey(name: r'page_size', required: true, includeIfNull: false)
  final int pageSize;

  @JsonKey(name: r'total', required: true, includeIfNull: false)
  final int total;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityMeta &&
          other.page == page &&
          other.pageSize == pageSize &&
          other.total == total;

  @override
  int get hashCode => page.hashCode + pageSize.hashCode + total.hashCode;

  factory ActivityMeta.fromJson(Map<String, dynamic> json) =>
      _$ActivityMetaFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityMetaToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
