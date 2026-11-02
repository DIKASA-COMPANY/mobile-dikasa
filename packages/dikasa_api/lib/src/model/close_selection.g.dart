// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_selection.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CloseSelectionCWProxy {
  CloseSelection countedCash(int countedCash);

  CloseSelection reason(String reason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CloseSelection(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CloseSelection(...).copyWith(id: 12, name: "My name")
  /// ````
  CloseSelection call({int countedCash, String reason});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCloseSelection.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCloseSelection.copyWith.fieldName(...)`
class _$CloseSelectionCWProxyImpl implements _$CloseSelectionCWProxy {
  const _$CloseSelectionCWProxyImpl(this._value);

  final CloseSelection _value;

  @override
  CloseSelection countedCash(int countedCash) => this(countedCash: countedCash);

  @override
  CloseSelection reason(String reason) => this(reason: reason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CloseSelection(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CloseSelection(...).copyWith(id: 12, name: "My name")
  /// ````
  CloseSelection call({
    Object? countedCash = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return CloseSelection(
      countedCash: countedCash == const $CopyWithPlaceholder()
          ? _value.countedCash
          // ignore: cast_nullable_to_non_nullable
          : countedCash as int,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $CloseSelectionCopyWith on CloseSelection {
  /// Returns a callable class that can be used as follows: `instanceOfCloseSelection.copyWith(...)` or like so:`instanceOfCloseSelection.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CloseSelectionCWProxy get copyWith => _$CloseSelectionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloseSelection _$CloseSelectionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CloseSelection', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['counted_cash', 'reason']);
      final val = CloseSelection(
        countedCash: $checkedConvert('counted_cash', (v) => (v as num).toInt()),
        reason: $checkedConvert('reason', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'countedCash': 'counted_cash'});

Map<String, dynamic> _$CloseSelectionToJson(CloseSelection instance) =>
    <String, dynamic>{
      'counted_cash': instance.countedCash,
      'reason': instance.reason,
    };
