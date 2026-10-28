// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OutputBodyCWProxy {
  OutputBody data(Order data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  OutputBody call({Order data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOutputBody.copyWith.fieldName(...)`
class _$OutputBodyCWProxyImpl implements _$OutputBodyCWProxy {
  const _$OutputBodyCWProxyImpl(this._value);

  final OutputBody _value;

  @override
  OutputBody data(Order data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  OutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return OutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Order,
    );
  }
}

extension $OutputBodyCopyWith on OutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfOutputBody.copyWith(...)` or like so:`instanceOfOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OutputBodyCWProxy get copyWith => _$OutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutputBody _$OutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = OutputBody(
        data: $checkedConvert(
          'data',
          (v) => Order.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OutputBodyToJson(OutputBody instance) =>
    <String, dynamic>{'data': instance.data.toJson()};
