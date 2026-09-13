// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_pin_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChangePINRequestCWProxy {
  ChangePINRequest currentPin(String? currentPin);

  ChangePINRequest newPin(String newPin);

  ChangePINRequest newPinConfirmation(String newPinConfirmation);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChangePINRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChangePINRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ChangePINRequest call({
    String? currentPin,
    String newPin,
    String newPinConfirmation,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfChangePINRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfChangePINRequest.copyWith.fieldName(...)`
class _$ChangePINRequestCWProxyImpl implements _$ChangePINRequestCWProxy {
  const _$ChangePINRequestCWProxyImpl(this._value);

  final ChangePINRequest _value;

  @override
  ChangePINRequest currentPin(String? currentPin) =>
      this(currentPin: currentPin);

  @override
  ChangePINRequest newPin(String newPin) => this(newPin: newPin);

  @override
  ChangePINRequest newPinConfirmation(String newPinConfirmation) =>
      this(newPinConfirmation: newPinConfirmation);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChangePINRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChangePINRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ChangePINRequest call({
    Object? currentPin = const $CopyWithPlaceholder(),
    Object? newPin = const $CopyWithPlaceholder(),
    Object? newPinConfirmation = const $CopyWithPlaceholder(),
  }) {
    return ChangePINRequest(
      currentPin: currentPin == const $CopyWithPlaceholder()
          ? _value.currentPin
          // ignore: cast_nullable_to_non_nullable
          : currentPin as String?,
      newPin: newPin == const $CopyWithPlaceholder()
          ? _value.newPin
          // ignore: cast_nullable_to_non_nullable
          : newPin as String,
      newPinConfirmation: newPinConfirmation == const $CopyWithPlaceholder()
          ? _value.newPinConfirmation
          // ignore: cast_nullable_to_non_nullable
          : newPinConfirmation as String,
    );
  }
}

extension $ChangePINRequestCopyWith on ChangePINRequest {
  /// Returns a callable class that can be used as follows: `instanceOfChangePINRequest.copyWith(...)` or like so:`instanceOfChangePINRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChangePINRequestCWProxy get copyWith => _$ChangePINRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePINRequest _$ChangePINRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ChangePINRequest',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['new_pin', 'new_pin_confirmation'],
        );
        final val = ChangePINRequest(
          currentPin: $checkedConvert('current_pin', (v) => v as String?),
          newPin: $checkedConvert('new_pin', (v) => v as String),
          newPinConfirmation: $checkedConvert(
            'new_pin_confirmation',
            (v) => v as String,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'currentPin': 'current_pin',
        'newPin': 'new_pin',
        'newPinConfirmation': 'new_pin_confirmation',
      },
    );

Map<String, dynamic> _$ChangePINRequestToJson(ChangePINRequest instance) =>
    <String, dynamic>{
      'current_pin': ?instance.currentPin,
      'new_pin': instance.newPin,
      'new_pin_confirmation': instance.newPinConfirmation,
    };
