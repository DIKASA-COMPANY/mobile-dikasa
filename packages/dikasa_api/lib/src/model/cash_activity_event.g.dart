// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_activity_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CashActivityEventCWProxy {
  CashActivityEvent amount(int amount);

  CashActivityEvent createdBy(String createdBy);

  CashActivityEvent createdByName(String createdByName);

  CashActivityEvent direction(String direction);

  CashActivityEvent id(String id);

  CashActivityEvent kind(String kind);

  CashActivityEvent name(String name);

  CashActivityEvent occurredAt(DateTime occurredAt);

  CashActivityEvent reason(String reason);

  CashActivityEvent reversesId(String? reversesId);

  CashActivityEvent sourceId(String sourceId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashActivityEvent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashActivityEvent(...).copyWith(id: 12, name: "My name")
  /// ````
  CashActivityEvent call({
    int amount,
    String createdBy,
    String createdByName,
    String direction,
    String id,
    String kind,
    String name,
    DateTime occurredAt,
    String reason,
    String? reversesId,
    String sourceId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCashActivityEvent.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCashActivityEvent.copyWith.fieldName(...)`
class _$CashActivityEventCWProxyImpl implements _$CashActivityEventCWProxy {
  const _$CashActivityEventCWProxyImpl(this._value);

  final CashActivityEvent _value;

  @override
  CashActivityEvent amount(int amount) => this(amount: amount);

  @override
  CashActivityEvent createdBy(String createdBy) => this(createdBy: createdBy);

  @override
  CashActivityEvent createdByName(String createdByName) =>
      this(createdByName: createdByName);

  @override
  CashActivityEvent direction(String direction) => this(direction: direction);

  @override
  CashActivityEvent id(String id) => this(id: id);

  @override
  CashActivityEvent kind(String kind) => this(kind: kind);

  @override
  CashActivityEvent name(String name) => this(name: name);

  @override
  CashActivityEvent occurredAt(DateTime occurredAt) =>
      this(occurredAt: occurredAt);

  @override
  CashActivityEvent reason(String reason) => this(reason: reason);

  @override
  CashActivityEvent reversesId(String? reversesId) =>
      this(reversesId: reversesId);

  @override
  CashActivityEvent sourceId(String sourceId) => this(sourceId: sourceId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CashActivityEvent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CashActivityEvent(...).copyWith(id: 12, name: "My name")
  /// ````
  CashActivityEvent call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? createdBy = const $CopyWithPlaceholder(),
    Object? createdByName = const $CopyWithPlaceholder(),
    Object? direction = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? kind = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? occurredAt = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? reversesId = const $CopyWithPlaceholder(),
    Object? sourceId = const $CopyWithPlaceholder(),
  }) {
    return CashActivityEvent(
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as int,
      createdBy: createdBy == const $CopyWithPlaceholder()
          ? _value.createdBy
          // ignore: cast_nullable_to_non_nullable
          : createdBy as String,
      createdByName: createdByName == const $CopyWithPlaceholder()
          ? _value.createdByName
          // ignore: cast_nullable_to_non_nullable
          : createdByName as String,
      direction: direction == const $CopyWithPlaceholder()
          ? _value.direction
          // ignore: cast_nullable_to_non_nullable
          : direction as String,
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
      occurredAt: occurredAt == const $CopyWithPlaceholder()
          ? _value.occurredAt
          // ignore: cast_nullable_to_non_nullable
          : occurredAt as DateTime,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      reversesId: reversesId == const $CopyWithPlaceholder()
          ? _value.reversesId
          // ignore: cast_nullable_to_non_nullable
          : reversesId as String?,
      sourceId: sourceId == const $CopyWithPlaceholder()
          ? _value.sourceId
          // ignore: cast_nullable_to_non_nullable
          : sourceId as String,
    );
  }
}

extension $CashActivityEventCopyWith on CashActivityEvent {
  /// Returns a callable class that can be used as follows: `instanceOfCashActivityEvent.copyWith(...)` or like so:`instanceOfCashActivityEvent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CashActivityEventCWProxy get copyWith =>
      _$CashActivityEventCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashActivityEvent _$CashActivityEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CashActivityEvent',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'amount',
            'created_by',
            'created_by_name',
            'direction',
            'id',
            'kind',
            'name',
            'occurred_at',
            'reason',
            'reverses_id',
            'source_id',
          ],
        );
        final val = CashActivityEvent(
          amount: $checkedConvert('amount', (v) => (v as num).toInt()),
          createdBy: $checkedConvert('created_by', (v) => v as String),
          createdByName: $checkedConvert('created_by_name', (v) => v as String),
          direction: $checkedConvert('direction', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String),
          kind: $checkedConvert('kind', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          occurredAt: $checkedConvert(
            'occurred_at',
            (v) => DateTime.parse(v as String),
          ),
          reason: $checkedConvert('reason', (v) => v as String),
          reversesId: $checkedConvert('reverses_id', (v) => v as String?),
          sourceId: $checkedConvert('source_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'createdBy': 'created_by',
        'createdByName': 'created_by_name',
        'occurredAt': 'occurred_at',
        'reversesId': 'reverses_id',
        'sourceId': 'source_id',
      },
    );

Map<String, dynamic> _$CashActivityEventToJson(CashActivityEvent instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'created_by': instance.createdBy,
      'created_by_name': instance.createdByName,
      'direction': instance.direction,
      'id': instance.id,
      'kind': instance.kind,
      'name': instance.name,
      'occurred_at': instance.occurredAt.toIso8601String(),
      'reason': instance.reason,
      'reverses_id': instance.reversesId,
      'source_id': instance.sourceId,
    };
