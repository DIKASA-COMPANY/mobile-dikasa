// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HealthOutputBodyCWProxy {
  HealthOutputBody service(String service);

  HealthOutputBody status(String status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HealthOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HealthOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  HealthOutputBody call({String service, String status});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHealthOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHealthOutputBody.copyWith.fieldName(...)`
class _$HealthOutputBodyCWProxyImpl implements _$HealthOutputBodyCWProxy {
  const _$HealthOutputBodyCWProxyImpl(this._value);

  final HealthOutputBody _value;

  @override
  HealthOutputBody service(String service) => this(service: service);

  @override
  HealthOutputBody status(String status) => this(status: status);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HealthOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HealthOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  HealthOutputBody call({
    Object? service = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return HealthOutputBody(
      service: service == const $CopyWithPlaceholder()
          ? _value.service
          // ignore: cast_nullable_to_non_nullable
          : service as String,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String,
    );
  }
}

extension $HealthOutputBodyCopyWith on HealthOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfHealthOutputBody.copyWith(...)` or like so:`instanceOfHealthOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HealthOutputBodyCWProxy get copyWith => _$HealthOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthOutputBody _$HealthOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('HealthOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['service', 'status']);
      final val = HealthOutputBody(
        service: $checkedConvert('service', (v) => v as String),
        status: $checkedConvert('status', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$HealthOutputBodyToJson(HealthOutputBody instance) =>
    <String, dynamic>{'service': instance.service, 'status': instance.status};
