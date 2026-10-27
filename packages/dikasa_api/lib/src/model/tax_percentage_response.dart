//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tax_percentage_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TaxPercentageResponse {
  /// Returns a new [TaxPercentageResponse] instance.
  TaxPercentageResponse({required this.taxPercentage});

  // minimum: 0
  // maximum: 100
  @JsonKey(name: r'tax_percentage', required: true, includeIfNull: false)
  final double taxPercentage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaxPercentageResponse && other.taxPercentage == taxPercentage;

  @override
  int get hashCode => taxPercentage.hashCode;

  factory TaxPercentageResponse.fromJson(Map<String, dynamic> json) =>
      _$TaxPercentageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaxPercentageResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
