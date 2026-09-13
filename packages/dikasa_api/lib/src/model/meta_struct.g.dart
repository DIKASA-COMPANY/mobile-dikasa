// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_struct.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MetaStructCWProxy {
  MetaStruct page(int page);

  MetaStruct pageSize(int pageSize);

  MetaStruct total(int total);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MetaStruct(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MetaStruct(...).copyWith(id: 12, name: "My name")
  /// ````
  MetaStruct call({int page, int pageSize, int total});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMetaStruct.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMetaStruct.copyWith.fieldName(...)`
class _$MetaStructCWProxyImpl implements _$MetaStructCWProxy {
  const _$MetaStructCWProxyImpl(this._value);

  final MetaStruct _value;

  @override
  MetaStruct page(int page) => this(page: page);

  @override
  MetaStruct pageSize(int pageSize) => this(pageSize: pageSize);

  @override
  MetaStruct total(int total) => this(total: total);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MetaStruct(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MetaStruct(...).copyWith(id: 12, name: "My name")
  /// ````
  MetaStruct call({
    Object? page = const $CopyWithPlaceholder(),
    Object? pageSize = const $CopyWithPlaceholder(),
    Object? total = const $CopyWithPlaceholder(),
  }) {
    return MetaStruct(
      page: page == const $CopyWithPlaceholder()
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int,
      pageSize: pageSize == const $CopyWithPlaceholder()
          ? _value.pageSize
          // ignore: cast_nullable_to_non_nullable
          : pageSize as int,
      total: total == const $CopyWithPlaceholder()
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as int,
    );
  }
}

extension $MetaStructCopyWith on MetaStruct {
  /// Returns a callable class that can be used as follows: `instanceOfMetaStruct.copyWith(...)` or like so:`instanceOfMetaStruct.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MetaStructCWProxy get copyWith => _$MetaStructCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaStruct _$MetaStructFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MetaStruct', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['page', 'page_size', 'total']);
      final val = MetaStruct(
        page: $checkedConvert('page', (v) => (v as num).toInt()),
        pageSize: $checkedConvert('page_size', (v) => (v as num).toInt()),
        total: $checkedConvert('total', (v) => (v as num).toInt()),
      );
      return val;
    }, fieldKeyMap: const {'pageSize': 'page_size'});

Map<String, dynamic> _$MetaStructToJson(MetaStruct instance) =>
    <String, dynamic>{
      'page': instance.page,
      'page_size': instance.pageSize,
      'total': instance.total,
    };
