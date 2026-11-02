//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/stock_movement.dart';
import 'package:dikasa_api/src/model/meta_struct.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_history_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StockHistoryOutputBody {
  /// Returns a new [StockHistoryOutputBody] instance.
  StockHistoryOutputBody({required this.data, required this.meta});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<StockMovement>? data;

  @JsonKey(name: r'meta', required: true, includeIfNull: false)
  final MetaStruct meta;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockHistoryOutputBody &&
          other.data == data &&
          other.meta == meta;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode) + meta.hashCode;

  factory StockHistoryOutputBody.fromJson(Map<String, dynamic> json) =>
      _$StockHistoryOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$StockHistoryOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
