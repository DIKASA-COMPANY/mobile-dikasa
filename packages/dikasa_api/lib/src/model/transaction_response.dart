//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/transaction_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TransactionResponse {
  /// Returns a new [TransactionResponse] instance.
  TransactionResponse({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final TransactionData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionResponse && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
