//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/receipt_snapshot.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_output_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DetailOutputBody {
  /// Returns a new [DetailOutputBody] instance.
  DetailOutputBody({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final ReceiptSnapshot data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DetailOutputBody && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory DetailOutputBody.fromJson(Map<String, dynamic> json) =>
      _$DetailOutputBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DetailOutputBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
