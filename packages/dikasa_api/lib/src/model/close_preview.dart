//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/reconciliation_summary.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'close_preview.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ClosePreview {
  /// Returns a new [ClosePreview] instance.
  ClosePreview({
    required this.countedCash,

    required this.difference,

    required this.previewHash,

    required this.reason,

    required this.summary,
  });

  @JsonKey(name: r'counted_cash', required: true, includeIfNull: false)
  final int countedCash;

  @JsonKey(name: r'difference', required: true, includeIfNull: false)
  final int difference;

  @JsonKey(name: r'preview_hash', required: true, includeIfNull: false)
  final String previewHash;

  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @JsonKey(name: r'summary', required: true, includeIfNull: false)
  final ReconciliationSummary summary;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClosePreview &&
          other.countedCash == countedCash &&
          other.difference == difference &&
          other.previewHash == previewHash &&
          other.reason == reason &&
          other.summary == summary;

  @override
  int get hashCode =>
      countedCash.hashCode +
      difference.hashCode +
      previewHash.hashCode +
      reason.hashCode +
      summary.hashCode;

  factory ClosePreview.fromJson(Map<String, dynamic> json) =>
      _$ClosePreviewFromJson(json);

  Map<String, dynamic> toJson() => _$ClosePreviewToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
