//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/selected_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'selection.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Selection {
  /// Returns a new [Selection] instance.
  Selection({
    required this.expectedRefundRevision,

    required this.items,

    required this.method,

    required this.mode,

    required this.reason,
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
    unknownEnumValue: SelectionMethodEnum.unknownDefaultOpenApi,
  )
  final SelectionMethodEnum method;

  @JsonKey(
    name: r'mode',
    required: true,
    includeIfNull: false,
    unknownEnumValue: SelectionModeEnum.unknownDefaultOpenApi,
  )
  final SelectionModeEnum mode;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Selection &&
          other.expectedRefundRevision == expectedRefundRevision &&
          other.items == items &&
          other.method == method &&
          other.mode == mode &&
          other.reason == reason;

  @override
  int get hashCode =>
      expectedRefundRevision.hashCode +
      (items == null ? 0 : items.hashCode) +
      method.hashCode +
      mode.hashCode +
      reason.hashCode;

  factory Selection.fromJson(Map<String, dynamic> json) =>
      _$SelectionFromJson(json);

  Map<String, dynamic> toJson() => _$SelectionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum SelectionMethodEnum {
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

  const SelectionMethodEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum SelectionModeEnum {
  @JsonValue(r'full')
  full(r'full'),
  @JsonValue(r'items')
  items(r'items'),
  @JsonValue(r'unknown_default_open_api')
  unknownDefaultOpenApi(r'unknown_default_open_api');

  const SelectionModeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
