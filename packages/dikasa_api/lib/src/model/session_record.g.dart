// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_record.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SessionRecordCWProxy {
  SessionRecord canClose(bool canClose);

  SessionRecord closedAt(DateTime? closedAt);

  SessionRecord closing(ClosedReconciliation closing);

  SessionRecord closingCash(int? closingCash);

  SessionRecord id(String id);

  SessionRecord openedAt(DateTime openedAt);

  SessionRecord openingCash(int openingCash);

  SessionRecord openingUserName(String openingUserName);

  SessionRecord outletId(String outletId);

  SessionRecord reconciliationSupported(bool reconciliationSupported);

  SessionRecord status(SessionRecordStatusEnum status);

  SessionRecord summary(ReconciliationSummary summary);

  SessionRecord unsupportedReason(String? unsupportedReason);

  SessionRecord userId(String userId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SessionRecord(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SessionRecord(...).copyWith(id: 12, name: "My name")
  /// ````
  SessionRecord call({
    bool canClose,
    DateTime? closedAt,
    ClosedReconciliation closing,
    int? closingCash,
    String id,
    DateTime openedAt,
    int openingCash,
    String openingUserName,
    String outletId,
    bool reconciliationSupported,
    SessionRecordStatusEnum status,
    ReconciliationSummary summary,
    String? unsupportedReason,
    String userId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSessionRecord.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSessionRecord.copyWith.fieldName(...)`
class _$SessionRecordCWProxyImpl implements _$SessionRecordCWProxy {
  const _$SessionRecordCWProxyImpl(this._value);

  final SessionRecord _value;

  @override
  SessionRecord canClose(bool canClose) => this(canClose: canClose);

  @override
  SessionRecord closedAt(DateTime? closedAt) => this(closedAt: closedAt);

  @override
  SessionRecord closing(ClosedReconciliation closing) => this(closing: closing);

  @override
  SessionRecord closingCash(int? closingCash) => this(closingCash: closingCash);

  @override
  SessionRecord id(String id) => this(id: id);

  @override
  SessionRecord openedAt(DateTime openedAt) => this(openedAt: openedAt);

  @override
  SessionRecord openingCash(int openingCash) => this(openingCash: openingCash);

  @override
  SessionRecord openingUserName(String openingUserName) =>
      this(openingUserName: openingUserName);

  @override
  SessionRecord outletId(String outletId) => this(outletId: outletId);

  @override
  SessionRecord reconciliationSupported(bool reconciliationSupported) =>
      this(reconciliationSupported: reconciliationSupported);

  @override
  SessionRecord status(SessionRecordStatusEnum status) => this(status: status);

  @override
  SessionRecord summary(ReconciliationSummary summary) =>
      this(summary: summary);

  @override
  SessionRecord unsupportedReason(String? unsupportedReason) =>
      this(unsupportedReason: unsupportedReason);

  @override
  SessionRecord userId(String userId) => this(userId: userId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SessionRecord(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SessionRecord(...).copyWith(id: 12, name: "My name")
  /// ````
  SessionRecord call({
    Object? canClose = const $CopyWithPlaceholder(),
    Object? closedAt = const $CopyWithPlaceholder(),
    Object? closing = const $CopyWithPlaceholder(),
    Object? closingCash = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? openedAt = const $CopyWithPlaceholder(),
    Object? openingCash = const $CopyWithPlaceholder(),
    Object? openingUserName = const $CopyWithPlaceholder(),
    Object? outletId = const $CopyWithPlaceholder(),
    Object? reconciliationSupported = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? summary = const $CopyWithPlaceholder(),
    Object? unsupportedReason = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return SessionRecord(
      canClose: canClose == const $CopyWithPlaceholder()
          ? _value.canClose
          // ignore: cast_nullable_to_non_nullable
          : canClose as bool,
      closedAt: closedAt == const $CopyWithPlaceholder()
          ? _value.closedAt
          // ignore: cast_nullable_to_non_nullable
          : closedAt as DateTime?,
      closing: closing == const $CopyWithPlaceholder()
          ? _value.closing
          // ignore: cast_nullable_to_non_nullable
          : closing as ClosedReconciliation,
      closingCash: closingCash == const $CopyWithPlaceholder()
          ? _value.closingCash
          // ignore: cast_nullable_to_non_nullable
          : closingCash as int?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      openedAt: openedAt == const $CopyWithPlaceholder()
          ? _value.openedAt
          // ignore: cast_nullable_to_non_nullable
          : openedAt as DateTime,
      openingCash: openingCash == const $CopyWithPlaceholder()
          ? _value.openingCash
          // ignore: cast_nullable_to_non_nullable
          : openingCash as int,
      openingUserName: openingUserName == const $CopyWithPlaceholder()
          ? _value.openingUserName
          // ignore: cast_nullable_to_non_nullable
          : openingUserName as String,
      outletId: outletId == const $CopyWithPlaceholder()
          ? _value.outletId
          // ignore: cast_nullable_to_non_nullable
          : outletId as String,
      reconciliationSupported:
          reconciliationSupported == const $CopyWithPlaceholder()
          ? _value.reconciliationSupported
          // ignore: cast_nullable_to_non_nullable
          : reconciliationSupported as bool,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as SessionRecordStatusEnum,
      summary: summary == const $CopyWithPlaceholder()
          ? _value.summary
          // ignore: cast_nullable_to_non_nullable
          : summary as ReconciliationSummary,
      unsupportedReason: unsupportedReason == const $CopyWithPlaceholder()
          ? _value.unsupportedReason
          // ignore: cast_nullable_to_non_nullable
          : unsupportedReason as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
    );
  }
}

extension $SessionRecordCopyWith on SessionRecord {
  /// Returns a callable class that can be used as follows: `instanceOfSessionRecord.copyWith(...)` or like so:`instanceOfSessionRecord.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SessionRecordCWProxy get copyWith => _$SessionRecordCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionRecord _$SessionRecordFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'SessionRecord',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'can_close',
        'closing',
        'id',
        'opened_at',
        'opening_cash',
        'opening_user_name',
        'outlet_id',
        'reconciliation_supported',
        'status',
        'summary',
        'user_id',
      ],
    );
    final val = SessionRecord(
      canClose: $checkedConvert('can_close', (v) => v as bool),
      closedAt: $checkedConvert(
        'closed_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      closing: $checkedConvert(
        'closing',
        (v) => ClosedReconciliation.fromJson(v as Map<String, dynamic>),
      ),
      closingCash: $checkedConvert('closing_cash', (v) => (v as num?)?.toInt()),
      id: $checkedConvert('id', (v) => v as String),
      openedAt: $checkedConvert(
        'opened_at',
        (v) => DateTime.parse(v as String),
      ),
      openingCash: $checkedConvert('opening_cash', (v) => (v as num).toInt()),
      openingUserName: $checkedConvert('opening_user_name', (v) => v as String),
      outletId: $checkedConvert('outlet_id', (v) => v as String),
      reconciliationSupported: $checkedConvert(
        'reconciliation_supported',
        (v) => v as bool,
      ),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(
          _$SessionRecordStatusEnumEnumMap,
          v,
          unknownValue: SessionRecordStatusEnum.unknownDefaultOpenApi,
        ),
      ),
      summary: $checkedConvert(
        'summary',
        (v) => ReconciliationSummary.fromJson(v as Map<String, dynamic>),
      ),
      unsupportedReason: $checkedConvert(
        'unsupported_reason',
        (v) => v as String?,
      ),
      userId: $checkedConvert('user_id', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'canClose': 'can_close',
    'closedAt': 'closed_at',
    'closingCash': 'closing_cash',
    'openedAt': 'opened_at',
    'openingCash': 'opening_cash',
    'openingUserName': 'opening_user_name',
    'outletId': 'outlet_id',
    'reconciliationSupported': 'reconciliation_supported',
    'unsupportedReason': 'unsupported_reason',
    'userId': 'user_id',
  },
);

Map<String, dynamic> _$SessionRecordToJson(SessionRecord instance) =>
    <String, dynamic>{
      'can_close': instance.canClose,
      'closed_at': ?instance.closedAt?.toIso8601String(),
      'closing': instance.closing.toJson(),
      'closing_cash': ?instance.closingCash,
      'id': instance.id,
      'opened_at': instance.openedAt.toIso8601String(),
      'opening_cash': instance.openingCash,
      'opening_user_name': instance.openingUserName,
      'outlet_id': instance.outletId,
      'reconciliation_supported': instance.reconciliationSupported,
      'status': _$SessionRecordStatusEnumEnumMap[instance.status]!,
      'summary': instance.summary.toJson(),
      'unsupported_reason': ?instance.unsupportedReason,
      'user_id': instance.userId,
    };

const _$SessionRecordStatusEnumEnumMap = {
  SessionRecordStatusEnum.open: 'open',
  SessionRecordStatusEnum.closed: 'closed',
  SessionRecordStatusEnum.unknownDefaultOpenApi: 'unknown_default_open_api',
};
