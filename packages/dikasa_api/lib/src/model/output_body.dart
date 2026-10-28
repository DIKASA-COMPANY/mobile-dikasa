//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/order.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OutputBody {
  /// Returns a new [OutputBody] instance.
  OutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final Order data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory OutputBody.fromJson(Map<String, dynamic> json) =>
      _$OutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
