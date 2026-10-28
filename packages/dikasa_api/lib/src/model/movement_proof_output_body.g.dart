// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement_proof_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MovementProofOutputBodyCWProxy {
  MovementProofOutputBody data(ProofLink data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MovementProofOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MovementProofOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  MovementProofOutputBody call({ProofLink data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMovementProofOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMovementProofOutputBody.copyWith.fieldName(...)`
class _$MovementProofOutputBodyCWProxyImpl
    implements _$MovementProofOutputBodyCWProxy {
  const _$MovementProofOutputBodyCWProxyImpl(this._value);

  final MovementProofOutputBody _value;

  @override
  MovementProofOutputBody data(ProofLink data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MovementProofOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MovementProofOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  MovementProofOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return MovementProofOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ProofLink,
    );
  }
}

extension $MovementProofOutputBodyCopyWith on MovementProofOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfMovementProofOutputBody.copyWith(...)` or like so:`instanceOfMovementProofOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MovementProofOutputBodyCWProxy get copyWith =>
      _$MovementProofOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovementProofOutputBody _$MovementProofOutputBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MovementProofOutputBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['data']);
  final val = MovementProofOutputBody(
    data: $checkedConvert(
      'data',
      (v) => ProofLink.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$MovementProofOutputBodyToJson(
  MovementProofOutputBody instance,
) => <String, dynamic>{'data': instance.data.toJson()};
