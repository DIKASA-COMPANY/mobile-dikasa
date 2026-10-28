// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement_detail_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MovementDetailOutputBodyCWProxy {
  MovementDetailOutputBody data(MovementDetail data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MovementDetailOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MovementDetailOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  MovementDetailOutputBody call({MovementDetail data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMovementDetailOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMovementDetailOutputBody.copyWith.fieldName(...)`
class _$MovementDetailOutputBodyCWProxyImpl
    implements _$MovementDetailOutputBodyCWProxy {
  const _$MovementDetailOutputBodyCWProxyImpl(this._value);

  final MovementDetailOutputBody _value;

  @override
  MovementDetailOutputBody data(MovementDetail data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MovementDetailOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MovementDetailOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  MovementDetailOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return MovementDetailOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as MovementDetail,
    );
  }
}

extension $MovementDetailOutputBodyCopyWith on MovementDetailOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfMovementDetailOutputBody.copyWith(...)` or like so:`instanceOfMovementDetailOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MovementDetailOutputBodyCWProxy get copyWith =>
      _$MovementDetailOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovementDetailOutputBody _$MovementDetailOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MovementDetailOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = MovementDetailOutputBody(
    data: $checkedConvert(
      'data',
      (v) => MovementDetail.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$MovementDetailOutputBodyToJson(
  MovementDetailOutputBody instance,
) => <String, dynamic>{'data': instance.data.toJson()};
