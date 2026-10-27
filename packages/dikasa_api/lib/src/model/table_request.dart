//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'table_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TableRequest {
  /// Returns a new [TableRequest] instance.
  TableRequest({
    required this.capacity,

    required this.isActive,

    required this.name,

    required this.sortOrder,
  });

  @JsonKey(name: r'capacity', required: true, includeIfNull: false)
  final int capacity;

  @JsonKey(name: r'is_active', required: true, includeIfNull: false)
  final bool isActive;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'sort_order', required: true, includeIfNull: false)
  final int sortOrder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableRequest &&
          other.capacity == capacity &&
          other.isActive == isActive &&
          other.name == name &&
          other.sortOrder == sortOrder;

  @override
  int get hashCode =>
      capacity.hashCode +
      isActive.hashCode +
      name.hashCode +
      sortOrder.hashCode;

  factory TableRequest.fromJson(Map<String, dynamic> json) =>
      _$TableRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TableRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
