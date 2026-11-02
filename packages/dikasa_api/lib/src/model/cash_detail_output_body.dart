//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/session_record.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_detail_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CashDetailOutputBody {
  /// Returns a new [CashDetailOutputBody] instance.
  CashDetailOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final SessionRecord data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CashDetailOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory CashDetailOutputBody.fromJson(Map<String, dynamic> json) =>
      _$CashDetailOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CashDetailOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
