//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mutation.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Mutation {
  /// Returns a new [Mutation] instance.
  Mutation({
    this.expectedRevision,

    required this.items,

    required this.label,

    required this.orderTypeId,

    required this.requestId,
  });

  // minimum: 0
  @JsonKey(name: r'expected_revision', required: false, includeIfNull: false)
  final int? expectedRevision;

  @JsonKey(name: r'items', required: true, includeIfNull: true)
  final List<Item>? items;

  @JsonKey(name: r'label', required: true, includeIfNull: false)
  final String label;

  @JsonKey(name: r'order_type_id', required: true, includeIfNull: false)
  final String orderTypeId;

  @JsonKey(name: r'request_id', required: true, includeIfNull: false)
  final String requestId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mutation &&
          other.expectedRevision == expectedRevision &&
          other.items == items &&
          other.label == label &&
          other.orderTypeId == orderTypeId &&
          other.requestId == requestId;

  @override
  int get hashCode =>
      expectedRevision.hashCode +
      (items == null ? 0 : items.hashCode) +
      label.hashCode +
      orderTypeId.hashCode +
      requestId.hashCode;

  factory Mutation.fromJson(Map<String, dynamic> json) =>
      _$MutationFromJson(json);

  Map<String, dynamic> toJson() => _$MutationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
