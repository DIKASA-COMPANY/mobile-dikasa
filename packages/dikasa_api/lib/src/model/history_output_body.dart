//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/meta_struct.dart';
import 'package:dikasa_api/src/model/refund.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class HistoryOutputBody {
  /// Returns a new [HistoryOutputBody] instance.
  HistoryOutputBody({required this.data, required this.meta});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<Refund>? data;

  @JsonKey(name: r'meta', required: true, includeIfNull: false)
  final MetaStruct meta;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryOutputBody && other.data == data && other.meta == meta;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode) + meta.hashCode;

  factory HistoryOutputBody.fromJson(Map<String, dynamic> json) =>
      _$HistoryOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
