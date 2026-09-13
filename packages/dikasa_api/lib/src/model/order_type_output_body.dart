//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/order_type_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_type_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderTypeOutputBody {
  /// Returns a new [OrderTypeOutputBody] instance.
  OrderTypeOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final OrderTypeData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderTypeOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory OrderTypeOutputBody.fromJson(Map<String, dynamic> json) =>
      _$OrderTypeOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTypeOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
