//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/table_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tables_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TablesOutputBody {
  /// Returns a new [TablesOutputBody] instance.
  TablesOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<TableData>? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TablesOutputBody && other.data == data;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode);

  factory TablesOutputBody.fromJson(Map<String, dynamic> json) =>
      _$TablesOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TablesOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
