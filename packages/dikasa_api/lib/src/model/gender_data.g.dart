// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GenderDataCWProxy {
  GenderData id(String id);

  GenderData name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GenderData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GenderData(...).copyWith(id: 12, name: "My name")
  /// ````
  GenderData call({String id, String name});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfGenderData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfGenderData.copyWith.fieldName(...)`
class _$GenderDataCWProxyImpl implements _$GenderDataCWProxy {
  const _$GenderDataCWProxyImpl(this._value);

  final GenderData _value;

  @override
  GenderData id(String id) => this(id: id);

  @override
  GenderData name(String name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GenderData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GenderData(...).copyWith(id: 12, name: "My name")
  /// ````
  GenderData call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return GenderData(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $GenderDataCopyWith on GenderData {
  /// Returns a callable class that can be used as follows: `instanceOfGenderData.copyWith(...)` or like so:`instanceOfGenderData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GenderDataCWProxy get copyWith => _$GenderDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenderData _$GenderDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GenderData', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'name']);
      final val = GenderData(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$GenderDataToJson(GenderData instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
