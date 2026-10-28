// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OpenRequestCWProxy {
  OpenRequest openingCash(int openingCash);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OpenRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OpenRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  OpenRequest call({int openingCash});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOpenRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOpenRequest.copyWith.fieldName(...)`
class _$OpenRequestCWProxyImpl implements _$OpenRequestCWProxy {
  const _$OpenRequestCWProxyImpl(this._value);

  final OpenRequest _value;

  @override
  OpenRequest openingCash(int openingCash) => this(openingCash: openingCash);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OpenRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OpenRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  OpenRequest call({Object? openingCash = const $CopyWithPlaceholder()}) {
    return OpenRequest(
      openingCash: openingCash == const $CopyWithPlaceholder()
          ? _value.openingCash
          // ignore: cast_nullable_to_non_nullable
          : openingCash as int,
    );
  }
}

extension $OpenRequestCopyWith on OpenRequest {
  /// Returns a callable class that can be used as follows: `instanceOfOpenRequest.copyWith(...)` or like so:`instanceOfOpenRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OpenRequestCWProxy get copyWith => _$OpenRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenRequest _$OpenRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OpenRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['opening_cash']);
      final val = OpenRequest(
        openingCash: $checkedConvert('opening_cash', (v) => (v as num).toInt()),
      );
      return val;
    }, fieldKeyMap: const {'openingCash': 'opening_cash'});

Map<String, dynamic> _$OpenRequestToJson(OpenRequest instance) =>
    <String, dynamic>{'opening_cash': instance.openingCash};
