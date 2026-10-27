//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/wallet_data.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_list_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WalletListResponse {
  /// Returns a new [WalletListResponse] instance.
  WalletListResponse({required this.data});

  @JsonKey(name: r'data', required: true, includeIfNull: true)
  final List<WalletData>? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletListResponse && other.data == data;

  @override
  int get hashCode => (data == null ? 0 : data.hashCode);

  factory WalletListResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletListResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
