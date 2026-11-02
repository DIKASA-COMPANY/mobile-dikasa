// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RefundOutputBodyCWProxy {
  RefundOutputBody data(Refund data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RefundOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RefundOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RefundOutputBody call({Refund data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRefundOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRefundOutputBody.copyWith.fieldName(...)`
class _$RefundOutputBodyCWProxyImpl implements _$RefundOutputBodyCWProxy {
  const _$RefundOutputBodyCWProxyImpl(this._value);

  final RefundOutputBody _value;

  @override
  RefundOutputBody data(Refund data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RefundOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RefundOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RefundOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return RefundOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Refund,
    );
  }
}

extension $RefundOutputBodyCopyWith on RefundOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfRefundOutputBody.copyWith(...)` or like so:`instanceOfRefundOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RefundOutputBodyCWProxy get copyWith => _$RefundOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundOutputBody _$RefundOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RefundOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = RefundOutputBody(
        data: $checkedConvert(
          'data',
          (v) => Refund.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RefundOutputBodyToJson(RefundOutputBody instance) =>
    <String, dynamic>{'data': instance.data.toJson()};
