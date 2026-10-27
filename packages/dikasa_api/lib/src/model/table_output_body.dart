//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/table_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'table_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TableOutputBody {
  /// Returns a new [TableOutputBody] instance.
  TableOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final TableData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TableOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory TableOutputBody.fromJson(Map<String, dynamic> json) =>
      _$TableOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TableOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
