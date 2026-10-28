// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommandCWProxy {
  Command expectedRefundRevision(int expectedRefundRevision);

  Command items(List<SelectedItem>? items);

  Command method(CommandMethodEnum method);

  Command mode(CommandModeEnum mode);

  Command previewHash(String previewHash);

  Command reason(String reason);

  Command requestId(String requestId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Command(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Command(...).copyWith(id: 12, name: "My name")
  /// ````
  Command call({
    int expectedRefundRevision,
    List<SelectedItem>? items,
    CommandMethodEnum method,
    CommandModeEnum mode,
    String previewHash,
    String reason,
    String requestId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCommand.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCommand.copyWith.fieldName(...)`
class _$CommandCWProxyImpl implements _$CommandCWProxy {
  const _$CommandCWProxyImpl(this._value);

  final Command _value;

  @override
  Command expectedRefundRevision(int expectedRefundRevision) =>
      this(expectedRefundRevision: expectedRefundRevision);

  @override
  Command items(List<SelectedItem>? items) => this(items: items);

  @override
  Command method(CommandMethodEnum method) => this(method: method);

  @override
  Command mode(CommandModeEnum mode) => this(mode: mode);

  @override
  Command previewHash(String previewHash) => this(previewHash: previewHash);

  @override
  Command reason(String reason) => this(reason: reason);

  @override
  Command requestId(String requestId) => this(requestId: requestId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Command(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Command(...).copyWith(id: 12, name: "My name")
  /// ````
  Command call({
    Object? expectedRefundRevision = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
    Object? mode = const $CopyWithPlaceholder(),
    Object? previewHash = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? requestId = const $CopyWithPlaceholder(),
  }) {
    return Command(
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
          : method as CommandMethodEnum,
      mode: mode == const $CopyWithPlaceholder()
          ? _value.mode
          // ignore: cast_nullable_to_non_nullable
          : mode as CommandModeEnum,
      previewHash: previewHash == const $CopyWithPlaceholder()
          ? _value.previewHash
          // ignore: cast_nullable_to_non_nullable
          : previewHash as String,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      requestId: requestId == const $CopyWithPlaceholder()
          ? _value.requestId
          // ignore: cast_nullable_to_non_nullable
          : requestId as String,
    );
  }
}

extension $CommandCopyWith on Command {
  /// Returns a callable class that can be used as follows: `instanceOfCommand.copyWith(...)` or like so:`instanceOfCommand.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommandCWProxy get copyWith => _$CommandCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Command _$CommandFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Command',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'expected_refund_revision',
        'items',
        'method',
        'mode',
        'preview_hash',
        'reason',
        'request_id',
      ],
    );
    final val = Command(
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
          _$CommandMethodEnumEnumMap,
          v,
          unknownValue: CommandMethodEnum.unknownDefaultOpenApi,
        ),
      ),
      mode: $checkedConvert(
        'mode',
        (v) => $enumDecode(
          _$CommandModeEnumEnumMap,
          v,
          unknownValue: CommandModeEnum.unknownDefaultOpenApi,
        ),
      ),
      previewHash: $checkedConvert('preview_hash', (v) => v as String),
      reason: $checkedConvert('reason', (v) => v as String),
      requestId: $checkedConvert('request_id', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'expectedRefundRevision': 'expected_refund_revision',
    'previewHash': 'preview_hash',
    'requestId': 'request_id',
  },
);

Map<String, dynamic> _$CommandToJson(Command instance) => <String, dynamic>{
  'expected_refund_revision': instance.expectedRefundRevision,
  'items': instance.items?.map((e) => e.toJson()).toList(),
  'method': _$CommandMethodEnumEnumMap[instance.method]!,
  'mode': _$CommandModeEnumEnumMap[instance.mode]!,
  'preview_hash': instance.previewHash,
  'reason': instance.reason,
  'request_id': instance.requestId,
};

const _$CommandMethodEnumEnumMap = {
  CommandMethodEnum.cash: 'cash',
  CommandMethodEnum.wallet: 'wallet',
  CommandMethodEnum.debitCard: 'debit_card',
  CommandMethodEnum.qris: 'qris',
  CommandMethodEnum.transfer: 'transfer',
  CommandMethodEnum.unknownDefaultOpenApi: 'unknown_default_open_api',
};

const _$CommandModeEnumEnumMap = {
  CommandModeEnum.full: 'full',
  CommandModeEnum.items: 'items',
  CommandModeEnum.unknownDefaultOpenApi: 'unknown_default_open_api',
};
