// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement_capabilities.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MovementCapabilitiesCWProxy {
  MovementCapabilities canCreate(bool canCreate);

  MovementCapabilities canUploadProof(bool canUploadProof);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MovementCapabilities(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MovementCapabilities(...).copyWith(id: 12, name: "My name")
  /// ````
  MovementCapabilities call({bool canCreate, bool canUploadProof});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMovementCapabilities.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMovementCapabilities.copyWith.fieldName(...)`
class _$MovementCapabilitiesCWProxyImpl
    implements _$MovementCapabilitiesCWProxy {
  const _$MovementCapabilitiesCWProxyImpl(this._value);

  final MovementCapabilities _value;

  @override
  MovementCapabilities canCreate(bool canCreate) => this(canCreate: canCreate);

  @override
  MovementCapabilities canUploadProof(bool canUploadProof) =>
      this(canUploadProof: canUploadProof);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MovementCapabilities(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MovementCapabilities(...).copyWith(id: 12, name: "My name")
  /// ````
  MovementCapabilities call({
    Object? canCreate = const $CopyWithPlaceholder(),
    Object? canUploadProof = const $CopyWithPlaceholder(),
  }) {
    return MovementCapabilities(
      canCreate: canCreate == const $CopyWithPlaceholder()
          ? _value.canCreate
          // ignore: cast_nullable_to_non_nullable
          : canCreate as bool,
      canUploadProof: canUploadProof == const $CopyWithPlaceholder()
          ? _value.canUploadProof
          // ignore: cast_nullable_to_non_nullable
          : canUploadProof as bool,
    );
  }
}

extension $MovementCapabilitiesCopyWith on MovementCapabilities {
  /// Returns a callable class that can be used as follows: `instanceOfMovementCapabilities.copyWith(...)` or like so:`instanceOfMovementCapabilities.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MovementCapabilitiesCWProxy get copyWith =>
      _$MovementCapabilitiesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovementCapabilities _$MovementCapabilitiesFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'MovementCapabilities',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['can_create', 'can_upload_proof']);
    final val = MovementCapabilities(
      canCreate: $checkedConvert('can_create', (v) => v as bool),
      canUploadProof: $checkedConvert('can_upload_proof', (v) => v as bool),
    );
    return val;
  },
  fieldKeyMap: const {
    'canCreate': 'can_create',
    'canUploadProof': 'can_upload_proof',
  },
);

Map<String, dynamic> _$MovementCapabilitiesToJson(
  MovementCapabilities instance,
) => <String, dynamic>{
  'can_create': instance.canCreate,
  'can_upload_proof': instance.canUploadProof,
};
