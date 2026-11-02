// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_output_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PreviewOutputBodyCWProxy {
  PreviewOutputBody data(Preview data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PreviewOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PreviewOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PreviewOutputBody call({Preview data});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPreviewOutputBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPreviewOutputBody.copyWith.fieldName(...)`
class _$PreviewOutputBodyCWProxyImpl implements _$PreviewOutputBodyCWProxy {
  const _$PreviewOutputBodyCWProxyImpl(this._value);

  final PreviewOutputBody _value;

  @override
  PreviewOutputBody data(Preview data) => this(data: data);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PreviewOutputBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PreviewOutputBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PreviewOutputBody call({Object? data = const $CopyWithPlaceholder()}) {
    return PreviewOutputBody(
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Preview,
    );
  }
}

extension $PreviewOutputBodyCopyWith on PreviewOutputBody {
  /// Returns a callable class that can be used as follows: `instanceOfPreviewOutputBody.copyWith(...)` or like so:`instanceOfPreviewOutputBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PreviewOutputBodyCWProxy get copyWith =>
      _$PreviewOutputBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviewOutputBody _$PreviewOutputBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PreviewOutputBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['data']);
      final val = PreviewOutputBody(
        data: $checkedConvert(
          'data',
          (v) => Preview.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PreviewOutputBodyToJson(PreviewOutputBody instance) =>
    <String, dynamic>{'data': instance.data.toJson()};
