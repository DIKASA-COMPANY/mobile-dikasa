// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TypesOutputBodyCWProxy {
  TypesOutputBody data(List<TypeData>? data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TypesOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TypesOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  TypesOutputBody call({List<TypeData>? data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTypesOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTypesOutputBody.copyWith.fieldName(...)`
class _$TypesOutputBodyCWProxyImpl implements _$TypesOutputBodyCWProxy {
  const _$TypesOutputBodyCWProxyImpl(this._value);

  final TypesOutputBody _value;

  @override
  TypesOutputBody data(List<TypeData>? data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TypesOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TypesOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  TypesOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return TypesOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<TypeData>?,
    );
  }
}

extension $TypesOutputBodyCopyWith on TypesOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfTypesOutputBody.copyWith(...)` or like so:`instanceOfTypesOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TypesOutputBodyCWProxy get copyWith => _$TypesOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypesOutputBody _$TypesOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TypesOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = TypesOutputBody(
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>?)
              ?.map((e) => TypeData.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TypesOutputBodyToJson(TypesOutputBody instance) =>
    <String, dynamic>{'data': instance.data?.map((e) => e.toJson()).toList()};
