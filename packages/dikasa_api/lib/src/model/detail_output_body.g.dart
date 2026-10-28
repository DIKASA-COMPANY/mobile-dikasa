// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DetailOutputBodyCWProxy {
  DetailOutputBody data(ReceiptSnapshot data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DetailOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DetailOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DetailOutputBody call({ReceiptSnapshot data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDetailOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDetailOutputBody.copyWith.fieldName(...)`
class _$DetailOutputBodyCWProxyImpl implements _$DetailOutputBodyCWProxy {
  const _$DetailOutputBodyCWProxyImpl(this._value);

  final DetailOutputBody _value;

  @override
  DetailOutputBody data(ReceiptSnapshot data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DetailOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DetailOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  DetailOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return DetailOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ReceiptSnapshot,
    );
  }
}

extension $DetailOutputBodyCopyWith on DetailOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfDetailOutputBody.copyWith(...)` or like so:`instanceOfDetailOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DetailOutputBodyCWProxy get copyWith => _$DetailOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailOutputBody _$DetailOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DetailOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = DetailOutputBody(
        data: $checkedConvert(
          'data',
          (v) => ReceiptSnapshot.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DetailOutputBodyToJson(DetailOutputBody instance) =>
    <String, dynamic>{'data': instance.data.toJson()};
