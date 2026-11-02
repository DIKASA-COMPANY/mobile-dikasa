//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/refund.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refund_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RefundOutputBody {
  /// Returns a new [RefundOutputBody] instance.
  RefundOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final Refund data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is RefundOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory RefundOutputBody.fromJson(Map<String, dynamic> json) =>
      _$RefundOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RefundOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
