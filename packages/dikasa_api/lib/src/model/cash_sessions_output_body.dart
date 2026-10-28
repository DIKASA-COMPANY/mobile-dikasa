//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/meta_struct.dart';
import 'package:dikasa_api/src/model/session_record.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_sessions_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CashSessionsOutputBody {
  /// Returns a new [CashSessionsOutputBody] instance.
  CashSessionsOutputBody({required this.data, required this.meta});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<SessionRecord>? data;

  @JsonKey(name: r'meta', required: true, includeIfNull: false)
  final MetaStruct meta;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CashSessionsOutputBody &&
          other.data == data &&
          other.meta == meta;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode) + meta.hashCode;

  factory CashSessionsOutputBody.fromJson(Map<String, dynamic> json) =>
      _$CashSessionsOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CashSessionsOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
