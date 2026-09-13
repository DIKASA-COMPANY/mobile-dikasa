//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/wallet_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WalletResponse {
  /// Returns a new [WalletResponse] instance.
  WalletResponse({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final WalletData data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is WalletResponse && other.data == data;

  @override
  int get hashCode => data.hashCode;

  factory WalletResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
