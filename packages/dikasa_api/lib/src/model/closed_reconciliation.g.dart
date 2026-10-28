// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'closed_reconciliation.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClosedReconciliationCWProxy {
  ClosedReconciliation closeRequestId(String closeRequestId);

  ClosedReconciliation closedAt(DateTime closedAt);

  ClosedReconciliation closedBy(String closedBy);

  ClosedReconciliation closedByName(String closedByName);

  ClosedReconciliation countedCash(int countedCash);

  ClosedReconciliation difference(int difference);

  ClosedReconciliation previewHash(String previewHash);

  ClosedReconciliation reason(String reason);

  ClosedReconciliation sessionId(String sessionId);

  ClosedReconciliation summary(ReconciliationSummary summary);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClosedReconciliation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClosedReconciliation(...).copyWith(id: 12, name: "My name")
  /// ````
  ClosedReconciliation call({
    String closeRequestId,
    DateTime closedAt,
    String closedBy,
    String closedByName,
    int countedCash,
    int difference,
    String previewHash,
    String reason,
    String sessionId,
    ReconciliationSummary summary,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfClosedReconciliation.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfClosedReconciliation.copyWith.fieldName(...)`
class _$ClosedReconciliationCWProxyImpl
    implements _$ClosedReconciliationCWProxy {
  const _$ClosedReconciliationCWProxyImpl(this._value);

  final ClosedReconciliation _value;

  @override
  ClosedReconciliation closeRequestId(String closeRequestId) =>
      this(closeRequestId: closeRequestId);

  @override
  ClosedReconciliation closedAt(DateTime closedAt) => this(closedAt: closedAt);

  @override
  ClosedReconciliation closedBy(String closedBy) => this(closedBy: closedBy);

  @override
  ClosedReconciliation closedByName(String closedByName) =>
      this(closedByName: closedByName);

  @override
  ClosedReconciliation countedCash(int countedCash) =>
      this(countedCash: countedCash);

  @override
  ClosedReconciliation difference(int difference) =>
      this(difference: difference);

  @override
  ClosedReconciliation previewHash(String previewHash) =>
      this(previewHash: previewHash);

  @override
  ClosedReconciliation reason(String reason) => this(reason: reason);

  @override
  ClosedReconciliation sessionId(String sessionId) =>
      this(sessionId: sessionId);

  @override
  ClosedReconciliation summary(ReconciliationSummary summary) =>
      this(summary: summary);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClosedReconciliation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClosedReconciliation(...).copyWith(id: 12, name: "My name")
  /// ````
  ClosedReconciliation call({
    Object? closeRequestId = const $CopyWithPlaceholder(),
    Object? closedAt = const $CopyWithPlaceholder(),
    Object? closedBy = const $CopyWithPlaceholder(),
    Object? closedByName = const $CopyWithPlaceholder(),
    Object? countedCash = const $CopyWithPlaceholder(),
    Object? difference = const $CopyWithPlaceholder(),
    Object? previewHash = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? sessionId = const $CopyWithPlaceholder(),
    Object? summary = const $CopyWithPlaceholder(),
  }) {
    return ClosedReconciliation(
      closeRequestId: closeRequestId == const $CopyWithPlaceholder()
          ? _value.closeRequestId
          // ignore: cast_nullable_to_non_nullable
          : closeRequestId as String,
      closedAt: closedAt == const $CopyWithPlaceholder()
          ? _value.closedAt
          // ignore: cast_nullable_to_non_nullable
          : closedAt as DateTime,
      closedBy: closedBy == const $CopyWithPlaceholder()
          ? _value.closedBy
          // ignore: cast_nullable_to_non_nullable
          : closedBy as String,
      closedByName: closedByName == const $CopyWithPlaceholder()
          ? _value.closedByName
          // ignore: cast_nullable_to_non_nullable
          : closedByName as String,
      countedCash: countedCash == const $CopyWithPlaceholder()
          ? _value.countedCash
          // ignore: cast_nullable_to_non_nullable
          : countedCash as int,
      difference: difference == const $CopyWithPlaceholder()
          ? _value.difference
          // ignore: cast_nullable_to_non_nullable
          : difference as int,
      previewHash: previewHash == const $CopyWithPlaceholder()
          ? _value.previewHash
          // ignore: cast_nullable_to_non_nullable
          : previewHash as String,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      sessionId: sessionId == const $CopyWithPlaceholder()
          ? _value.sessionId
          // ignore: cast_nullable_to_non_nullable
          : sessionId as String,
      summary: summary == const $CopyWithPlaceholder()
          ? _value.summary
          // ignore: cast_nullable_to_non_nullable
          : summary as ReconciliationSummary,
    );
  }
}

extension $ClosedReconciliationCopyWith on ClosedReconciliation {
  /// Returns a callable class that can be used as follows: `instanceOfClosedReconciliation.copyWith(...)` or like so:`instanceOfClosedReconciliation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClosedReconciliationCWProxy get copyWith =>
      _$ClosedReconciliationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClosedReconciliation _$ClosedReconciliationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ClosedReconciliation',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'close_request_id',
        'closed_at',
        'closed_by',
        'closed_by_name',
        'counted_cash',
        'difference',
        'preview_hash',
        'reason',
        'session_id',
        'summary',
      ],
    );
    final val = ClosedReconciliation(
      closeRequestId: $checkedConvert('close_request_id', (v) => v as String),
      closedAt: $checkedConvert(
        'closed_at',
        (v) => DateTime.parse(v as String),
      ),
      closedBy: $checkedConvert('closed_by', (v) => v as String),
      closedByName: $checkedConvert('closed_by_name', (v) => v as String),
      countedCash: $checkedConvert('counted_cash', (v) => (v as num).toInt()),
      difference: $checkedConvert('difference', (v) => (v as num).toInt()),
      previewHash: $checkedConvert('preview_hash', (v) => v as String),
      reason: $checkedConvert('reason', (v) => v as String),
      sessionId: $checkedConvert('session_id', (v) => v as String),
      summary: $checkedConvert(
        'summary',
        (v) => ReconciliationSummary.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'closeRequestId': 'close_request_id',
    'closedAt': 'closed_at',
    'closedBy': 'closed_by',
    'closedByName': 'closed_by_name',
    'countedCash': 'counted_cash',
    'previewHash': 'preview_hash',
    'sessionId': 'session_id',
  },
);

Map<String, dynamic> _$ClosedReconciliationToJson(
  ClosedReconciliation instance,
) => <String, dynamic>{
  'close_request_id': instance.closeRequestId,
  'closed_at': instance.closedAt.toIso8601String(),
  'closed_by': instance.closedBy,
  'closed_by_name': instance.closedByName,
  'counted_cash': instance.countedCash,
  'difference': instance.difference,
  'preview_hash': instance.previewHash,
  'reason': instance.reason,
  'session_id': instance.sessionId,
  'summary': instance.summary.toJson(),
};
