// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SessionDataCWProxy {
  SessionData closedAt(DateTime? closedAt);

  SessionData closingCash(int? closingCash);

  SessionData id(String id);

  SessionData openedAt(DateTime openedAt);

  SessionData openingCash(int openingCash);

  SessionData outletId(String outletId);

  SessionData status(SessionDataStatusEnum status);

  SessionData userId(String userId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SessionData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SessionData(...).copyWith(id: 12, name: "My name")
  /// ````
  SessionData call({
    DateTime? closedAt,
    int? closingCash,
    String id,
    DateTime openedAt,
    int openingCash,
    String outletId,
    SessionDataStatusEnum status,
    String userId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSessionData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSessionData.copyWith.fieldName(...)`
class _$SessionDataCWProxyImpl implements _$SessionDataCWProxy {
  const _$SessionDataCWProxyImpl(this._value);

  final SessionData _value;

  @override
  SessionData closedAt(DateTime? closedAt) => this(closedAt: closedAt);

  @override
  SessionData closingCash(int? closingCash) => this(closingCash: closingCash);

  @override
  SessionData id(String id) => this(id: id);

  @override
  SessionData openedAt(DateTime openedAt) => this(openedAt: openedAt);

  @override
  SessionData openingCash(int openingCash) => this(openingCash: openingCash);

  @override
  SessionData outletId(String outletId) => this(outletId: outletId);

  @override
  SessionData status(SessionDataStatusEnum status) => this(status: status);

  @override
  SessionData userId(String userId) => this(userId: userId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SessionData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SessionData(...).copyWith(id: 12, name: "My name")
  /// ````
  SessionData call({
    Object? closedAt = const $CopyWithPlaceholder(),
    Object? closingCash = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? openedAt = const $CopyWithPlaceholder(),
    Object? openingCash = const $CopyWithPlaceholder(),
    Object? outletId = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return SessionData(
      closedAt: closedAt == const $CopyWithPlaceholder()
          ? _value.closedAt
          // ignore: cast_nullable_to_non_nullable
          : closedAt as DateTime?,
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
      outletId: outletId == const $CopyWithPlaceholder()
          ? _value.outletId
          // ignore: cast_nullable_to_non_nullable
          : outletId as String,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as SessionDataStatusEnum,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
    );
  }
}

extension $SessionDataCopyWith on SessionData {
  /// Returns a callable class that can be used as follows: `instanceOfSessionData.copyWith(...)` or like so:`instanceOfSessionData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SessionDataCWProxy get copyWith => _$SessionDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionData _$SessionDataFromJson(Map<String, dynamic> json) => $checkedCreate(
  'SessionData',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'id',
        'opened_at',
        'opening_cash',
        'outlet_id',
        'status',
        'user_id',
      ],
    );
    final val = SessionData(
      closedAt: $checkedConvert(
        'closed_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      closingCash: $checkedConvert('closing_cash', (v) => (v as num?)?.toInt()),
      id: $checkedConvert('id', (v) => v as String),
      openedAt: $checkedConvert(
        'opened_at',
        (v) => DateTime.parse(v as String),
      ),
      openingCash: $checkedConvert('opening_cash', (v) => (v as num).toInt()),
      outletId: $checkedConvert('outlet_id', (v) => v as String),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(
          _$SessionDataStatusEnumEnumMap,
          v,
          unknownValue: SessionDataStatusEnum.unknownDefaultOpenApi,
        ),
      ),
      userId: $checkedConvert('user_id', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'closedAt': 'closed_at',
    'closingCash': 'closing_cash',
    'openedAt': 'opened_at',
    'openingCash': 'opening_cash',
    'outletId': 'outlet_id',
    'userId': 'user_id',
  },
);

Map<String, dynamic> _$SessionDataToJson(SessionData instance) =>
    <String, dynamic>{
      'closed_at': ?instance.closedAt?.toIso8601String(),
      'closing_cash': ?instance.closingCash,
      'id': instance.id,
      'opened_at': instance.openedAt.toIso8601String(),
      'opening_cash': instance.openingCash,
      'outlet_id': instance.outletId,
      'status': _$SessionDataStatusEnumEnumMap[instance.status]!,
      'user_id': instance.userId,
    };

const _$SessionDataStatusEnumEnumMap = {
  SessionDataStatusEnum.open: 'open',
  SessionDataStatusEnum.closed: 'closed',
  SessionDataStatusEnum.unknownDefaultOpenApi: 'unknown_default_open_api',
};
