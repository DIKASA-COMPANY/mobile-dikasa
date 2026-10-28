// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GenderOutputBodyCWProxy {
  GenderOutputBody data(List<GenderChoice>? data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GenderOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GenderOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  GenderOutputBody call({List<GenderChoice>? data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfGenderOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfGenderOutputBody.copyWith.fieldName(...)`
class _$GenderOutputBodyCWProxyImpl implements _$GenderOutputBodyCWProxy {
  const _$GenderOutputBodyCWProxyImpl(this._value);

  final GenderOutputBody _value;

  @override
  GenderOutputBody data(List<GenderChoice>? data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GenderOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GenderOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  GenderOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return GenderOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<GenderChoice>?,
    );
  }
}

extension $GenderOutputBodyCopyWith on GenderOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfGenderOutputBody.copyWith(...)` or like so:`instanceOfGenderOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GenderOutputBodyCWProxy get copyWith => _$GenderOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenderOutputBody _$GenderOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GenderOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = GenderOutputBody(
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>?)
              ?.map((e) => GenderChoice.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$GenderOutputBodyToJson(GenderOutputBody instance) =>
    <String, dynamic>{'data': instance.data?.map((e) => e.toJson()).toList()};
