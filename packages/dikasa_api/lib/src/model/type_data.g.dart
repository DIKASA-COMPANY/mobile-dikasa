// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TypeDataCWProxy {
  TypeData code(String code);

  TypeData id(String id);

  TypeData name(String name);

  TypeData sortOrder(int sortOrder);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TypeData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TypeData(...).copyWith(id: 12, name: "My name")
  /// ````
  TypeData call({String code, String id, String name, int sortOrder});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTypeData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTypeData.copyWith.fieldName(...)`
class _$TypeDataCWProxyImpl implements _$TypeDataCWProxy {
  const _$TypeDataCWProxyImpl(this._value);

  final TypeData _value;

  @override
  TypeData code(String code) => this(code: code);

  @override
  TypeData id(String id) => this(id: id);

  @override
  TypeData name(String name) => this(name: name);

  @override
  TypeData sortOrder(int sortOrder) => this(sortOrder: sortOrder);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TypeData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TypeData(...).copyWith(id: 12, name: "My name")
  /// ````
  TypeData call({
    Object? code = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
  }) {
    return TypeData(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      sortOrder: sortOrder == const $CopyWithPlaceholder()
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as int,
    );
  }
}

extension $TypeDataCopyWith on TypeData {
  /// Returns a callable class that can be used as follows: `instanceOfTypeData.copyWith(...)` or like so:`instanceOfTypeData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TypeDataCWProxy get copyWith => _$TypeDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeData _$TypeDataFromJson(Map<String, dynamic> json) => $checkedCreate(
  'TypeData',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['code', 'id', 'name', 'sort_order']);
    final val = TypeData(
      code: $checkedConvert('code', (v) => v as String),
      id: $checkedConvert('id', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      sortOrder: $checkedConvert('sort_order', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {'sortOrder': 'sort_order'},
);

Map<String, dynamic> _$TypeDataToJson(TypeData instance) => <String, dynamic>{
  'code': instance.code,
  'id': instance.id,
  'name': instance.name,
  'sort_order': instance.sortOrder,
};
