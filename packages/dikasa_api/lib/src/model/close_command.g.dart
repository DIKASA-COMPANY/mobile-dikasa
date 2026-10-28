// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_command.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CloseCommandCWProxy {
  CloseCommand countedCash(int countedCash);

  CloseCommand previewHash(String previewHash);

  CloseCommand reason(String reason);

  CloseCommand requestId(String requestId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CloseCommand(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CloseCommand(...).copyWith(id: 12, name: "My name")
  /// ````
  CloseCommand call({
    int countedCash,
    String previewHash,
    String reason,
    String requestId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCloseCommand.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCloseCommand.copyWith.fieldName(...)`
class _$CloseCommandCWProxyImpl implements _$CloseCommandCWProxy {
  const _$CloseCommandCWProxyImpl(this._value);

  final CloseCommand _value;

  @override
  CloseCommand countedCash(int countedCash) => this(countedCash: countedCash);

  @override
  CloseCommand previewHash(String previewHash) =>
      this(previewHash: previewHash);

  @override
  CloseCommand reason(String reason) => this(reason: reason);

  @override
  CloseCommand requestId(String requestId) => this(requestId: requestId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CloseCommand(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CloseCommand(...).copyWith(id: 12, name: "My name")
  /// ````
  CloseCommand call({
    Object? countedCash = const $CopyWithPlaceholder(),
    Object? previewHash = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? requestId = const $CopyWithPlaceholder(),
  }) {
    return CloseCommand(
      countedCash: countedCash == const $CopyWithPlaceholder()
          ? _value.countedCash
          // ignore: cast_nullable_to_non_nullable
          : countedCash as int,
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

extension $CloseCommandCopyWith on CloseCommand {
  /// Returns a callable class that can be used as follows: `instanceOfCloseCommand.copyWith(...)` or like so:`instanceOfCloseCommand.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CloseCommandCWProxy get copyWith => _$CloseCommandCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloseCommand _$CloseCommandFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CloseCommand',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'counted_cash',
            'preview_hash',
            'reason',
            'request_id',
          ],
        );
        final val = CloseCommand(
          countedCash: $checkedConvert(
            'counted_cash',
            (v) => (v as num).toInt(),
          ),
          previewHash: $checkedConvert('preview_hash', (v) => v as String),
          reason: $checkedConvert('reason', (v) => v as String),
          requestId: $checkedConvert('request_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'countedCash': 'counted_cash',
        'previewHash': 'preview_hash',
        'requestId': 'request_id',
      },
    );

Map<String, dynamic> _$CloseCommandToJson(CloseCommand instance) =>
    <String, dynamic>{
      'counted_cash': instance.countedCash,
      'preview_hash': instance.previewHash,
      'reason': instance.reason,
      'request_id': instance.requestId,
    };
