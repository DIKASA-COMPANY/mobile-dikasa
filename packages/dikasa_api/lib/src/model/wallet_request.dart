//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WalletRequest {
  /// Returns a new [WalletRequest] instance.
  WalletRequest({
    required this.code,

    this.iconKey,

    this.isActive = true,

    required this.name,

    required this.sortOrder,
  });

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'icon_key', required: false, includeIfNull: false)
  final String? iconKey;

  @JsonKey(
    defaultValue: true,
    name: r'is_active',
    required: true,
    includeIfNull: false,
  )
  final bool isActive;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'sort_order', required: true, includeIfNull: false)
  final int sortOrder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletRequest &&
          other.code == code &&
          other.iconKey == iconKey &&
          other.isActive == isActive &&
          other.name == name &&
          other.sortOrder == sortOrder;

  @override
  int get hashCode =>
      code.hashCode +
      iconKey.hashCode +
      isActive.hashCode +
      name.hashCode +
      sortOrder.hashCode;

  factory WalletRequest.fromJson(Map<String, dynamic> json) =>
      _$WalletRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WalletRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
