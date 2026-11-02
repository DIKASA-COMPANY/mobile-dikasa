//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'close_command.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CloseCommand {
  /// Returns a new [CloseCommand] instance.
  CloseCommand({
    required this.countedCash,

    required this.previewHash,

    required this.reason,

    required this.requestId,
  });

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'counted_cash', required: true, includeIfNull: false)
  final int countedCash;

  @JsonKey(name: r'preview_hash', required: true, includeIfNull: false)
  final String previewHash;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'request_id', required: true, includeIfNull: false)
  final String requestId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CloseCommand &&
          other.countedCash == countedCash &&
          other.previewHash == previewHash &&
          other.reason == reason &&
          other.requestId == requestId;

  @override
  int get hashCode =>
      countedCash.hashCode +
      previewHash.hashCode +
      reason.hashCode +
      requestId.hashCode;

  factory CloseCommand.fromJson(Map<String, dynamic> json) =>
      _$CloseCommandFromJson(json);

  Map<String, dynamic> toJson() => _$CloseCommandToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
