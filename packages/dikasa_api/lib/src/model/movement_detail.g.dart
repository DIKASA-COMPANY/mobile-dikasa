// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement_detail.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MovementDetailCWProxy {
  MovementDetail canReverse(bool canReverse);

  MovementDetail movement(MovementRecord movement);

  MovementDetail reversedById(String? reversedById);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MovementDetail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MovementDetail(...).copyWith(id: 12, name: "My name")
  /// ````
  MovementDetail call({
    bool canReverse,
    MovementRecord movement,
    String? reversedById,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMovementDetail.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMovementDetail.copyWith.fieldName(...)`
class _$MovementDetailCWProxyImpl implements _$MovementDetailCWProxy {
  const _$MovementDetailCWProxyImpl(this._value);

  final MovementDetail _value;

  @override
  MovementDetail canReverse(bool canReverse) => this(canReverse: canReverse);

  @override
  MovementDetail movement(MovementRecord movement) => this(movement: movement);

  @override
  MovementDetail reversedById(String? reversedById) =>
      this(reversedById: reversedById);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MovementDetail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MovementDetail(...).copyWith(id: 12, name: "My name")
  /// ````
  MovementDetail call({
    Object? canReverse = const $CopyWithPlaceholder(),
    Object? movement = const $CopyWithPlaceholder(),
    Object? reversedById = const $CopyWithPlaceholder(),
  }) {
    return MovementDetail(
      canReverse: canReverse == const $CopyWithPlaceholder()
          ? _value.canReverse
          // ignore: cast_nullable_to_non_nullable
          : canReverse as bool,
      movement: movement == const $CopyWithPlaceholder()
          ? _value.movement
          // ignore: cast_nullable_to_non_nullable
          : movement as MovementRecord,
      reversedById: reversedById == const $CopyWithPlaceholder()
          ? _value.reversedById
          // ignore: cast_nullable_to_non_nullable
          : reversedById as String?,
    );
  }
}

extension $MovementDetailCopyWith on MovementDetail {
  /// Returns a callable class that can be used as follows: `instanceOfMovementDetail.copyWith(...)` or like so:`instanceOfMovementDetail.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MovementDetailCWProxy get copyWith => _$MovementDetailCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovementDetail _$MovementDetailFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'MovementDetail',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['can_reverse', 'movement', 'reversed_by_id'],
        );
        final val = MovementDetail(
          canReverse: $checkedConvert('can_reverse', (v) => v as bool),
          movement: $checkedConvert(
            'movement',
            (v) => MovementRecord.fromJson(v as Map<String, dynamic>),
          ),
          reversedById: $checkedConvert('reversed_by_id', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'canReverse': 'can_reverse',
        'reversedById': 'reversed_by_id',
      },
    );

Map<String, dynamic> _$MovementDetailToJson(MovementDetail instance) =>
    <String, dynamic>{
      'can_reverse': instance.canReverse,
      'movement': instance.movement.toJson(),
      'reversed_by_id': instance.reversedById,
    };
