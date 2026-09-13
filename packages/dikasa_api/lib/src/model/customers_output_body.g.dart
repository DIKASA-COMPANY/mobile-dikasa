// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CustomersOutputBodyCWProxy {
  CustomersOutputBody data(List<CustomerData>? data);

  CustomersOutputBody meta(PaginationMeta meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CustomersOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CustomersOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CustomersOutputBody call({List<CustomerData>? data, PaginationMeta meta});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCustomersOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCustomersOutputBody.copyWith.fieldName(...)`
class _$CustomersOutputBodyCWProxyImpl implements _$CustomersOutputBodyCWProxy {
  const _$CustomersOutputBodyCWProxyImpl(this._value);

  final CustomersOutputBody _value;

  @override
  CustomersOutputBody data(List<CustomerData>? data) => this(data: data);

  @override
  CustomersOutputBody meta(PaginationMeta meta) => this(meta: meta);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CustomersOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CustomersOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CustomersOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return CustomersOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<CustomerData>?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as PaginationMeta,
    );
  }
}

extension $CustomersOutputBodyCopyWith on CustomersOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfCustomersOutputBody.copyWith(...)` or like so:`instanceOfCustomersOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CustomersOutputBodyCWProxy get copyWith =>
      _$CustomersOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomersOutputBody _$CustomersOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CustomersOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data', 'meta']);
      final val = CustomersOutputBody(
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>?)
              ?.map((e) => CustomerData.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        meta: $checkedConvert(
          'meta',
          (v) => PaginationMeta.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CustomersOutputBodyToJson(
  CustomersOutputBody instance,
) => <String, dynamic>{
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'meta': instance.meta.toJson(),
};
