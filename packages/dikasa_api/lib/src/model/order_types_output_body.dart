//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/order_type_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_types_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderTypesOutputBody {
  /// Returns a new [OrderTypesOutputBody] instance.
  OrderTypesOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<OrderTypeData>? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderTypesOutputBody && other.data == data;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode);

  factory OrderTypesOutputBody.fromJson(Map<String, dynamic> json) =>
      _$OrderTypesOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTypesOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
