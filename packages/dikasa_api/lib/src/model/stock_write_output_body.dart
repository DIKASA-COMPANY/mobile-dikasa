//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/stock_movement.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_write_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StockWriteOutputBody {
  /// Returns a new [StockWriteOutputBody] instance.
  StockWriteOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final StockMovement data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockWriteOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory StockWriteOutputBody.fromJson(Map<String, dynamic> json) =>
      _$StockWriteOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$StockWriteOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
