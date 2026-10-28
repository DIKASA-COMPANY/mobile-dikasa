// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement_record.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MovementRecordCWProxy {
  MovementRecord amount(int amount);

  MovementRecord createdAt(DateTime createdAt);

  MovementRecord createdBy(String createdBy);

  MovementRecord createdByName(String createdByName);

  MovementRecord hasProof(bool hasProof);

  MovementRecord id(String id);

  MovementRecord kind(String kind);

  MovementRecord name(String name);

  MovementRecord outletId(String outletId);

  MovementRecord reason(String reason);

  MovementRecord requestId(String requestId);

  MovementRecord reversesId(String? reversesId);

  MovementRecord sessionId(String sessionId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MovementRecord(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MovementRecord(...).copyWith(id: 12, name: "My name")
  /// ````
  MovementRecord call({
    int amount,
    DateTime createdAt,
    String createdBy,
    String createdByName,
    bool hasProof,
    String id,
    String kind,
    String name,
    String outletId,
    String reason,
    String requestId,
    String? reversesId,
    String sessionId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMovementRecord.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMovementRecord.copyWith.fieldName(...)`
class _$MovementRecordCWProxyImpl implements _$MovementRecordCWProxy {
  const _$MovementRecordCWProxyImpl(this._value);

  final MovementRecord _value;

  @override
  MovementRecord amount(int amount) => this(amount: amount);

  @override
  MovementRecord createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  MovementRecord createdBy(String createdBy) => this(createdBy: createdBy);

  @override
  MovementRecord createdByName(String createdByName) =>
      this(createdByName: createdByName);

  @override
  MovementRecord hasProof(bool hasProof) => this(hasProof: hasProof);

  @override
  MovementRecord id(String id) => this(id: id);

  @override
  MovementRecord kind(String kind) => this(kind: kind);

  @override
  MovementRecord name(String name) => this(name: name);

  @override
  MovementRecord outletId(String outletId) => this(outletId: outletId);

  @override
  MovementRecord reason(String reason) => this(reason: reason);

  @override
  MovementRecord requestId(String requestId) => this(requestId: requestId);

  @override
  MovementRecord reversesId(String? reversesId) => this(reversesId: reversesId);

  @override
  MovementRecord sessionId(String sessionId) => this(sessionId: sessionId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MovementRecord(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MovementRecord(...).copyWith(id: 12, name: "My name")
  /// ````
  MovementRecord call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? createdBy = const $CopyWithPlaceholder(),
    Object? createdByName = const $CopyWithPlaceholder(),
    Object? hasProof = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? kind = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? outletId = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? requestId = const $CopyWithPlaceholder(),
    Object? reversesId = const $CopyWithPlaceholder(),
    Object? sessionId = const $CopyWithPlaceholder(),
  }) {
    return MovementRecord(
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as int,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      createdBy: createdBy == const $CopyWithPlaceholder()
          ? _value.createdBy
          // ignore: cast_nullable_to_non_nullable
          : createdBy as String,
      createdByName: createdByName == const $CopyWithPlaceholder()
          ? _value.createdByName
          // ignore: cast_nullable_to_non_nullable
          : createdByName as String,
      hasProof: hasProof == const $CopyWithPlaceholder()
          ? _value.hasProof
          // ignore: cast_nullable_to_non_nullable
          : hasProof as bool,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      kind: kind == const $CopyWithPlaceholder()
          ? _value.kind
          // ignore: cast_nullable_to_non_nullable
          : kind as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      outletId: outletId == const $CopyWithPlaceholder()
          ? _value.outletId
          // ignore: cast_nullable_to_non_nullable
          : outletId as String,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      requestId: requestId == const $CopyWithPlaceholder()
          ? _value.requestId
          // ignore: cast_nullable_to_non_nullable
          : requestId as String,
      reversesId: reversesId == const $CopyWithPlaceholder()
          ? _value.reversesId
          // ignore: cast_nullable_to_non_nullable
          : reversesId as String?,
      sessionId: sessionId == const $CopyWithPlaceholder()
          ? _value.sessionId
          // ignore: cast_nullable_to_non_nullable
          : sessionId as String,
    );
  }
}

extension $MovementRecordCopyWith on MovementRecord {
  /// Returns a callable class that can be used as follows: `instanceOfMovementRecord.copyWith(...)` or like so:`instanceOfMovementRecord.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MovementRecordCWProxy get copyWith => _$MovementRecordCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovementRecord _$MovementRecordFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'MovementRecord',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'amount',
            'created_at',
            'created_by',
            'created_by_name',
            'has_proof',
            'id',
            'kind',
            'name',
            'outlet_id',
            'reason',
            'request_id',
            'reverses_id',
            'session_id',
          ],
        );
        final val = MovementRecord(
          amount: $checkedConvert('amount', (v) => (v as num).toInt()),
          createdAt: $checkedConvert(
            'created_at',
            (v) => DateTime.parse(v as String),
          ),
          createdBy: $checkedConvert('created_by', (v) => v as String),
          createdByName: $checkedConvert('created_by_name', (v) => v as String),
          hasProof: $checkedConvert('has_proof', (v) => v as bool),
          id: $checkedConvert('id', (v) => v as String),
          kind: $checkedConvert('kind', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          outletId: $checkedConvert('outlet_id', (v) => v as String),
          reason: $checkedConvert('reason', (v) => v as String),
          requestId: $checkedConvert('request_id', (v) => v as String),
          reversesId: $checkedConvert('reverses_id', (v) => v as String?),
          sessionId: $checkedConvert('session_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'createdAt': 'created_at',
        'createdBy': 'created_by',
        'createdByName': 'created_by_name',
        'hasProof': 'has_proof',
        'outletId': 'outlet_id',
        'requestId': 'request_id',
        'reversesId': 'reverses_id',
        'sessionId': 'session_id',
      },
    );

Map<String, dynamic> _$MovementRecordToJson(MovementRecord instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'created_by_name': instance.createdByName,
      'has_proof': instance.hasProof,
      'id': instance.id,
      'kind': instance.kind,
      'name': instance.name,
      'outlet_id': instance.outletId,
      'reason': instance.reason,
      'request_id': instance.requestId,
      'reverses_id': instance.reversesId,
      'session_id': instance.sessionId,
    };
