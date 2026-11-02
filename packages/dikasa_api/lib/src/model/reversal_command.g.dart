// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reversal_command.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReversalCommandCWProxy {
  ReversalCommand reason(String reason);

  ReversalCommand requestId(String requestId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReversalCommand(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReversalCommand(...).copyWith(id: 12, name: "My name")
  /// ````
  ReversalCommand call({String reason, String requestId});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReversalCommand.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReversalCommand.copyWith.fieldName(...)`
class _$ReversalCommandCWProxyImpl implements _$ReversalCommandCWProxy {
  const _$ReversalCommandCWProxyImpl(this._value);

  final ReversalCommand _value;

  @override
  ReversalCommand reason(String reason) => this(reason: reason);

  @override
  ReversalCommand requestId(String requestId) => this(requestId: requestId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReversalCommand(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReversalCommand(...).copyWith(id: 12, name: "My name")
  /// ````
  ReversalCommand call({
    Object? reason = const $CopyWithPlaceholder(),
    Object? requestId = const $CopyWithPlaceholder(),
  }) {
    return ReversalCommand(
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

extension $ReversalCommandCopyWith on ReversalCommand {
  /// Returns a callable class that can be used as follows: `instanceOfReversalCommand.copyWith(...)` or like so:`instanceOfReversalCommand.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReversalCommandCWProxy get copyWith => _$ReversalCommandCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReversalCommand _$ReversalCommandFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReversalCommand', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['reason', 'request_id']);
      final val = ReversalCommand(
        reason: $checkedConvert('reason', (v) => v as String),
        requestId: $checkedConvert('request_id', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'requestId': 'request_id'});

Map<String, dynamic> _$ReversalCommandToJson(ReversalCommand instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'request_id': instance.requestId,
    };
