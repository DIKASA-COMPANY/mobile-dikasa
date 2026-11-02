//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/selected_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'command.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Command {
  /// Returns a new [Command] instance.
  Command({
    required this.expectedRefundRevision,

    required this.items,

    required this.method,

    required this.mode,

    required this.previewHash,

    required this.reason,

    required this.requestId,
  });

  // minimum: 0
  @JsonKey(
    name: r'expected_refund_revision',
    required: true,
    includeIfNull: false,
  )
  final int expectedRefundRevision;

  @JsonKey(name: r'items', required: true, includeIfNull: true)
  final List<SelectedItem>? items;

  @JsonKey(
    name: r'method',
    required: true,
    includeIfNull: false,
    unknownEnumValue: CommandMethodEnum.unknownDefaultOpenApi,
  )
  final CommandMethodEnum method;

  @JsonKey(
    name: r'mode',
    required: true,
    includeIfNull: false,
    unknownEnumValue: CommandModeEnum.unknownDefaultOpenApi,
  )
  final CommandModeEnum mode;

  @JsonKey(name: r'preview_hash', required: true, includeIfNull: false)
  final String previewHash;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'request_id', required: true, includeIfNull: false)
  final String requestId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Command &&
          other.expectedRefundRevision == expectedRefundRevision &&
          other.items == items &&
          other.method == method &&
          other.mode == mode &&
          other.previewHash == previewHash &&
          other.reason == reason &&
          other.requestId == requestId;

  @override
  int get hashCode =>
      expectedRefundRevision.hashCode +
      (items == null ? 0 : items.hashCode) +
      method.hashCode +
      mode.hashCode +
      previewHash.hashCode +
      reason.hashCode +
      requestId.hashCode;

  factory Command.fromJson(Map<String, dynamic> json) =>
      _$CommandFromJson(json);

  Map<String, dynamic> toJson() => _$CommandToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum CommandMethodEnum {
  @JsonValue(r'cash')
  cash(r'cash'),
  @JsonValue(r'wallet')
  wallet(r'wallet'),
  @JsonValue(r'debit_card')
  debitCard(r'debit_card'),
  @JsonValue(r'qris')
  qris(r'qris'),
  @JsonValue(r'transfer')
  transfer(r'transfer'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const CommandMethodEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum CommandModeEnum {
  @JsonValue(r'full')
  full(r'full'),
  @JsonValue(r'items')
  items(r'items'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const CommandModeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
