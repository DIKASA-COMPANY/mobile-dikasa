//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:dikasa_api/src/model/movement_record.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movement_detail.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MovementDetail {
  /// Returns a new [MovementDetail] instance.
  MovementDetail({
    required this.canReverse,

    required this.movement,

    required this.reversedById,
  });

  @JsonKey(name: r'can_reverse', required: true, includeIfNull: false)
  final bool canReverse;

  @JsonKey(name: r'movement', required: true, includeIfNull: false)
  final MovementRecord movement;

  @JsonKey(name: r'reversed_by_id', required: true, includeIfNull: true)
  final String? reversedById;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovementDetail &&
          other.canReverse == canReverse &&
          other.movement == movement &&
          other.reversedById == reversedById;

  @override
  int get hashCode =>
      canReverse.hashCode +
      movement.hashCode +
      (reversedById == null ? 0 : reversedById.hashCode);

  factory MovementDetail.fromJson(Map<String, dynamic> json) =>
      _$MovementDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MovementDetailToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
