// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender_choice.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GenderChoiceCWProxy {
  GenderChoice id(String id);

  GenderChoice name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GenderChoice(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GenderChoice(...).copyWith(id: 12, name: "My name")
  /// ````
  GenderChoice call({String id, String name});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfGenderChoice.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfGenderChoice.copyWith.fieldName(...)`
class _$GenderChoiceCWProxyImpl implements _$GenderChoiceCWProxy {
  const _$GenderChoiceCWProxyImpl(this._value);

  final GenderChoice _value;

  @override
  GenderChoice id(String id) => this(id: id);

  @override
  GenderChoice name(String name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GenderChoice(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GenderChoice(...).copyWith(id: 12, name: "My name")
  /// ````
  GenderChoice call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return GenderChoice(
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

extension $GenderChoiceCopyWith on GenderChoice {
  /// Returns a callable class that can be used as follows: `instanceOfGenderChoice.copyWith(...)` or like so:`instanceOfGenderChoice.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GenderChoiceCWProxy get copyWith => _$GenderChoiceCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenderChoice _$GenderChoiceFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GenderChoice', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'name']);
      final val = GenderChoice(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$GenderChoiceToJson(GenderChoice instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
