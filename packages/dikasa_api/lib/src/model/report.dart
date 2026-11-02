//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/method_row.dart';
import 'package:dikasa_api/src/model/daily_point.dart';
import 'package:dikasa_api/src/model/totals.dart';
import 'package:dikasa_api/src/model/group_row.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Report {
  /// Returns a new [Report] instance.
  Report({
    required this.daily,

    required this.kind,

    required this.methods,

    required this.rows,

    required this.totals,
  });

  @JsonKey(name: r'daily', required: true, includeIfNull: true)
  final List<DailyPoint>? daily;

  @JsonKey(name: r'kind', required: true, includeIfNull: false)
  final String kind;

  @JsonKey(name: r'methods', required: true, includeIfNull: true)
  final List<MethodRow>? methods;

  @JsonKey(name: r'rows', required: true, includeIfNull: true)
  final List<GroupRow>? rows;

  @JsonKey(name: r'totals', required: true, includeIfNull: false)
  final Totals totals;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Report &&
          other.daily == daily &&
          other.kind == kind &&
          other.methods == methods &&
          other.rows == rows &&
          other.totals == totals;

  @override
  int get hashCode =>
      (daily == null ? 0 : daily.hashCode) +
      kind.hashCode +
      (methods == null ? 0 : methods.hashCode) +
      (rows == null ? 0 : rows.hashCode) +
      totals.hashCode;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
