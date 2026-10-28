// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SelectionCWProxy {
  Selection expectedRefundRevision(int expectedRefundRevision);

  Selection items(List<SelectedItem>? items);

  Selection method(SelectionMethodEnum method);

  Selection mode(SelectionModeEnum mode);

  Selection reason(String reason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Selection(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Selection(...).copyWith(id: 12, name: "My name")
  /// ````
  Selection call({
    int expectedRefundRevision,
    List<SelectedItem>? items,
    SelectionMethodEnum method,
    SelectionModeEnum mode,
    String reason,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSelection.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSelection.copyWith.fieldName(...)`
class _$SelectionCWProxyImpl implements _$SelectionCWProxy {
  const _$SelectionCWProxyImpl(this._value);

  final Selection _value;

  @override
  Selection expectedRefundRevision(int expectedRefundRevision) =>
      this(expectedRefundRevision: expectedRefundRevision);

  @override
  Selection items(List<SelectedItem>? items) => this(items: items);

  @override
  Selection method(SelectionMethodEnum method) => this(method: method);

  @override
  Selection mode(SelectionModeEnum mode) => this(mode: mode);

  @override
  Selection reason(String reason) => this(reason: reason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Selection(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Selection(...).copyWith(id: 12, name: "My name")
  /// ````
  Selection call({
    Object? expectedRefundRevision = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
    Object? mode = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return Selection(
      expectedRefundRevision:
          expectedRefundRevision == const $CopyWithPlaceholder()
          ? _value.expectedRefundRevision
          // ignore: cast_nullable_to_non_nullable
          : expectedRefundRevision as int,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<SelectedItem>?,
      method: method == const $CopyWithPlaceholder()
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as SelectionMethodEnum,
      mode: mode == const $CopyWithPlaceholder()
          ? _value.mode
          // ignore: cast_nullable_to_non_nullable
          : mode as SelectionModeEnum,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $SelectionCopyWith on Selection {
  /// Returns a callable class that can be used as follows: `instanceOfSelection.copyWith(...)` or like so:`instanceOfSelection.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SelectionCWProxy get copyWith => _$SelectionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Selection _$SelectionFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Selection',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'expected_refund_revision',
        'items',
        'method',
        'mode',
        'reason',
      ],
    );
    final val = Selection(
      expectedRefundRevision: $checkedConvert(
        'expected_refund_revision',
        (v) => (v as num).toInt(),
      ),
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>?)
            ?.map((e) => SelectedItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      method: $checkedConvert(
        'method',
        (v) => $enumDecode(
          _$SelectionMethodEnumEnumMap,
          v,
          unknownValue: SelectionMethodEnum.unknownDefaultOpenApi,
        ),
      ),
      mode: $checkedConvert(
        'mode',
        (v) => $enumDecode(
          _$SelectionModeEnumEnumMap,
          v,
          unknownValue: SelectionModeEnum.unknownDefaultOpenApi,
        ),
      ),
      reason: $checkedConvert('reason', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {'expectedRefundRevision': 'expected_refund_revision'},
);

Map<String, dynamic> _$SelectionToJson(Selection instance) => <String, dynamic>{
  'expected_refund_revision': instance.expectedRefundRevision,
  'items': instance.items?.map((e) => e.toJson()).toList(),
  'method': _$SelectionMethodEnumEnumMap[instance.method]!,
  'mode': _$SelectionModeEnumEnumMap[instance.mode]!,
  'reason': instance.reason,
};

const _$SelectionMethodEnumEnumMap = {
  SelectionMethodEnum.cash: 'cash',
  SelectionMethodEnum.wallet: 'wallet',
  SelectionMethodEnum.debitCard: 'debit_card',
  SelectionMethodEnum.qris: 'qris',
  SelectionMethodEnum.transfer: 'transfer',
  SelectionMethodEnum.unknownDefaultOpenApi: 'unknown_default_open_api',
};

const _$SelectionModeEnumEnumMap = {
  SelectionModeEnum.full: 'full',
  SelectionModeEnum.items: 'items',
  SelectionModeEnum.unknownDefaultOpenApi: 'unknown_default_open_api',
};
