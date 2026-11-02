//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reversal_command.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReversalCommand {
  /// Returns a new [ReversalCommand] instance.
  ReversalCommand({required this.reason, required this.requestId});

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'request_id', required: true, includeIfNull: false)
  final String requestId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReversalCommand &&
          other.reason == reason &&
          other.requestId == requestId;

  @override
  int get hashCode => reason.hashCode + requestId.hashCode;

  factory ReversalCommand.fromJson(Map<String, dynamic> json) =>
      _$ReversalCommandFromJson(json);

  Map<String, dynamic> toJson() => _$ReversalCommandToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
