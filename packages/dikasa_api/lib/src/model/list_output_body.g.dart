// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ListOutputBodyCWProxy {
  ListOutputBody data(List<Order>? data);

  ListOutputBody meta(MetaStruct meta);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ListOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ListOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ListOutputBody call({List<Order>? data, MetaStruct meta});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfListOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfListOutputBody.copyWith.fieldName(...)`
class _$ListOutputBodyCWProxyImpl implements _$ListOutputBodyCWProxy {
  const _$ListOutputBodyCWProxyImpl(this._value);

  final ListOutputBody _value;

  @override
  ListOutputBody data(List<Order>? data) => this(data: data);

  @override
  ListOutputBody meta(MetaStruct meta) => this(meta: meta);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ListOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ListOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ListOutputBody call({
    Object? data = const $CopyWithPlaceholder(),
    Object? meta = const $CopyWithPlaceholder(),
  }) {
    return ListOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Order>?,
      meta: meta == const $CopyWithPlaceholder()
          ? _value.meta
          // ignore: cast_nullable_to_non_nullable
          : meta as MetaStruct,
    );
  }
}

extension $ListOutputBodyCopyWith on ListOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfListOutputBody.copyWith(...)` or like so:`instanceOfListOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ListOutputBodyCWProxy get copyWith => _$ListOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListOutputBody _$ListOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ListOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data', 'meta']);
      final val = ListOutputBody(
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>?)
              ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        meta: $checkedConvert(
          'meta',
          (v) => MetaStruct.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ListOutputBodyToJson(ListOutputBody instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };
