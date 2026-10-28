// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MovementOutputBodyCWProxy {
  MovementOutputBody data(MovementRecord data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MovementOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MovementOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  MovementOutputBody call({MovementRecord data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMovementOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMovementOutputBody.copyWith.fieldName(...)`
class _$MovementOutputBodyCWProxyImpl implements _$MovementOutputBodyCWProxy {
  const _$MovementOutputBodyCWProxyImpl(this._value);

  final MovementOutputBody _value;

  @override
  MovementOutputBody data(MovementRecord data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MovementOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MovementOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  MovementOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return MovementOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as MovementRecord,
    );
  }
}

extension $MovementOutputBodyCopyWith on MovementOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfMovementOutputBody.copyWith(...)` or like so:`instanceOfMovementOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MovementOutputBodyCWProxy get copyWith =>
      _$MovementOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovementOutputBody _$MovementOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MovementOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = MovementOutputBody(
        data: $checkedConvert(
          'data',
          (v) => MovementRecord.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MovementOutputBodyToJson(MovementOutputBody instance) =>
    <String, dynamic>{'data': instance.data.toJson()};
