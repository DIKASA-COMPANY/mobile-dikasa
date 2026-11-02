//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Order {
  /// Returns a new [Order] instance.
  Order({
    required this.createdAt,

    required this.createdBy,

    required this.creatorName,

    required this.estimatedSubtotal,

    required this.id,

    required this.items,

    required this.label,

    required this.orderTypeId,

    required this.revision,

    required this.status,

    required this.totalQuantity,

    required this.transactionId,

    required this.updatedAt,
  });

  @JsonKey(name: r'created_at', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'created_by', required: true, includeIfNull: false)
  final String createdBy;

  @JsonKey(name: r'creator_name', required: true, includeIfNull: false)
  final String creatorName;

  @JsonKey(name: r'estimated_subtotal', required: true, includeIfNull: false)
  final int estimatedSubtotal;

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'items', required: true, includeIfNull: true)
  final List<Item>? items;

  @JsonKey(name: r'label', required: true, includeIfNull: false)
  final String label;

  @JsonKey(name: r'order_type_id', required: true, includeIfNull: false)
  final String orderTypeId;

  @JsonKey(name: r'revision', required: true, includeIfNull: false)
  final int revision;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final String status;

  @JsonKey(name: r'total_quantity', required: true, includeIfNull: false)
  final int totalQuantity;

  @JsonKey(name: r'transaction_id', required: true, includeIfNull: true)
  final String? transactionId;

  @JsonKey(name: r'updated_at', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          other.createdAt == createdAt &&
          other.createdBy == createdBy &&
          other.creatorName == creatorName &&
          other.estimatedSubtotal == estimatedSubtotal &&
          other.id == id &&
          other.items == items &&
          other.label == label &&
          other.orderTypeId == orderTypeId &&
          other.revision == revision &&
          other.status == status &&
          other.totalQuantity == totalQuantity &&
          other.transactionId == transactionId &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      createdAt.hashCode +
      createdBy.hashCode +
      creatorName.hashCode +
      estimatedSubtotal.hashCode +
      id.hashCode +
      (items == null ? 0 : items.hashCode) +
      label.hashCode +
      orderTypeId.hashCode +
      revision.hashCode +
      status.hashCode +
      totalQuantity.hashCode +
      (transactionId == null ? 0 : transactionId.hashCode) +
      updatedAt.hashCode;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
