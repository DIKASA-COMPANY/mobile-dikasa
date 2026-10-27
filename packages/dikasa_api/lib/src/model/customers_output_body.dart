//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/customer_data.dart';
import 'package:dikasa_api/src/model/pagination_meta.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customers_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CustomersOutputBody {
  /// Returns a new [CustomersOutputBody] instance.
  CustomersOutputBody({required this.data, required this.meta});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<CustomerData>? data;

  @JsonKey(name: r'meta', required: true, includeIfNull: false)
  final PaginationMeta meta;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomersOutputBody && other.data == data && other.meta == meta;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode) + meta.hashCode;

  factory CustomersOutputBody.fromJson(Map<String, dynamic> json) =>
      _$CustomersOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CustomersOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
