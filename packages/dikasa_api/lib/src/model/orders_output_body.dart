//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/pagination_meta.dart';
import 'package:dikasa_api/src/model/order_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrdersOutputBody {
  /// Returns a new [OrdersOutputBody] instance.
  OrdersOutputBody({required this.data, required this.meta});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<OrderData>? data;

  @JsonKey(name: r'meta', required: true, includeIfNull: false)
  final PaginationMeta meta;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrdersOutputBody && other.data == data && other.meta == meta;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode) + meta.hashCode;

  factory OrdersOutputBody.fromJson(Map<String, dynamic> json) =>
      _$OrdersOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
