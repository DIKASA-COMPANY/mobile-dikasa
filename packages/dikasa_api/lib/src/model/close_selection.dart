//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'close_selection.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CloseSelection {
  /// Returns a new [CloseSelection] instance.
  CloseSelection({required this.countedCash, required this.reason});

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'counted_cash', required: true, includeIfNull: false)
  final int countedCash;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CloseSelection &&
          other.countedCash == countedCash &&
          other.reason == reason;

  @override
  int get hashCode => countedCash.hashCode + reason.hashCode;

  factory CloseSelection.fromJson(Map<String, dynamic> json) =>
      _$CloseSelectionFromJson(json);

  Map<String, dynamic> toJson() => _$CloseSelectionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
