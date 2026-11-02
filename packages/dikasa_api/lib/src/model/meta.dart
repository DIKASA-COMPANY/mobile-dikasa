//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meta.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Meta {
  /// Returns a new [Meta] instance.
  Meta({
    required this.endDate,

    required this.generatedAt,

    required this.page,

    required this.pageSize,

    required this.query,

    required this.sort,

    required this.startDate,

    required this.timezone,

    required this.total,
  });

  @JsonKey(name: r'end_date', required: true, includeIfNull: false)
  final String endDate;

  @JsonKey(name: r'generated_at', required: true, includeIfNull: false)
  final DateTime generatedAt;

  @JsonKey(name: r'page', required: true, includeIfNull: false)
  final int page;

  @JsonKey(name: r'page_size', required: true, includeIfNull: false)
  final int pageSize;

  @JsonKey(name: r'query', required: true, includeIfNull: false)
  final String query;

  @JsonKey(name: r'sort', required: true, includeIfNull: false)
  final String sort;

  @JsonKey(name: r'start_date', required: true, includeIfNull: false)
  final String startDate;

  @JsonKey(name: r'timezone', required: true, includeIfNull: false)
  final String timezone;

  @JsonKey(name: r'total', required: true, includeIfNull: false)
  final int total;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Meta &&
          other.endDate == endDate &&
          other.generatedAt == generatedAt &&
          other.page == page &&
          other.pageSize == pageSize &&
          other.query == query &&
          other.sort == sort &&
          other.startDate == startDate &&
          other.timezone == timezone &&
          other.total == total;

  @override
  int get hashCode =>
      endDate.hashCode +
      generatedAt.hashCode +
      page.hashCode +
      pageSize.hashCode +
      query.hashCode +
      sort.hashCode +
      startDate.hashCode +
      timezone.hashCode +
      total.hashCode;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
