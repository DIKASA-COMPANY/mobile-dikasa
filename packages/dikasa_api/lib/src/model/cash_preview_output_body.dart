//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/close_preview.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_preview_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CashPreviewOutputBody {
  /// Returns a new [CashPreviewOutputBody] instance.
  CashPreviewOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final ClosePreview data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CashPreviewOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory CashPreviewOutputBody.fromJson(Map<String, dynamic> json) =>
      _$CashPreviewOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CashPreviewOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
