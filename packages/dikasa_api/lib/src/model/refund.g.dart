// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RefundCWProxy {
  Refund actorId(String actorId);

  Refund actorName(String actorName);

  Refund cashSessionId(String cashSessionId);

  Refund createdAt(DateTime createdAt);

  Refund id(String id);

  Refund items(List<RefundItem>? items);

  Refund method(String method);

  Refund mode(String mode);

  Refund netAmount(int netAmount);

  Refund reason(String reason);

  Refund refundNumber(String refundNumber);

  Refund requestId(String requestId);

  Refund taxAmount(int taxAmount);

  Refund totalAmount(int totalAmount);

  Refund transactionId(String transactionId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Refund(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Refund(...).copyWith(id: 12, name: "My name")
  /// ````
  Refund call({
    String actorId,
    String actorName,
    String cashSessionId,
    DateTime createdAt,
    String id,
    List<RefundItem>? items,
    String method,
    String mode,
    int netAmount,
    String reason,
    String refundNumber,
    String requestId,
    int taxAmount,
    int totalAmount,
    String transactionId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRefund.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRefund.copyWith.fieldName(...)`
class _$RefundCWProxyImpl implements _$RefundCWProxy {
  const _$RefundCWProxyImpl(this._value);

  final Refund _value;

  @override
  Refund actorId(String actorId) => this(actorId: actorId);

  @override
  Refund actorName(String actorName) => this(actorName: actorName);

  @override
  Refund cashSessionId(String cashSessionId) =>
      this(cashSessionId: cashSessionId);

  @override
  Refund createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Refund id(String id) => this(id: id);

  @override
  Refund items(List<RefundItem>? items) => this(items: items);

  @override
  Refund method(String method) => this(method: method);

  @override
  Refund mode(String mode) => this(mode: mode);

  @override
  Refund netAmount(int netAmount) => this(netAmount: netAmount);

  @override
  Refund reason(String reason) => this(reason: reason);

  @override
  Refund refundNumber(String refundNumber) => this(refundNumber: refundNumber);

  @override
  Refund requestId(String requestId) => this(requestId: requestId);

  @override
  Refund taxAmount(int taxAmount) => this(taxAmount: taxAmount);

  @override
  Refund totalAmount(int totalAmount) => this(totalAmount: totalAmount);

  @override
  Refund transactionId(String transactionId) =>
      this(transactionId: transactionId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Refund(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Refund(...).copyWith(id: 12, name: "My name")
  /// ````
  Refund call({
    Object? actorId = const $CopyWithPlaceholder(),
    Object? actorName = const $CopyWithPlaceholder(),
    Object? cashSessionId = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
    Object? mode = const $CopyWithPlaceholder(),
    Object? netAmount = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? refundNumber = const $CopyWithPlaceholder(),
    Object? requestId = const $CopyWithPlaceholder(),
    Object? taxAmount = const $CopyWithPlaceholder(),
    Object? totalAmount = const $CopyWithPlaceholder(),
    Object? transactionId = const $CopyWithPlaceholder(),
  }) {
    return Refund(
      actorId: actorId == const $CopyWithPlaceholder()
          ? _value.actorId
          // ignore: cast_nullable_to_non_nullable
          : actorId as String,
      actorName: actorName == const $CopyWithPlaceholder()
          ? _value.actorName
          // ignore: cast_nullable_to_non_nullable
          : actorName as String,
      cashSessionId: cashSessionId == const $CopyWithPlaceholder()
          ? _value.cashSessionId
          // ignore: cast_nullable_to_non_nullable
          : cashSessionId as String,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<RefundItem>?,
      method: method == const $CopyWithPlaceholder()
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as String,
      mode: mode == const $CopyWithPlaceholder()
          ? _value.mode
          // ignore: cast_nullable_to_non_nullable
          : mode as String,
      netAmount: netAmount == const $CopyWithPlaceholder()
          ? _value.netAmount
          // ignore: cast_nullable_to_non_nullable
          : netAmount as int,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      refundNumber: refundNumber == const $CopyWithPlaceholder()
          ? _value.refundNumber
          // ignore: cast_nullable_to_non_nullable
          : refundNumber as String,
      requestId: requestId == const $CopyWithPlaceholder()
          ? _value.requestId
          // ignore: cast_nullable_to_non_nullable
          : requestId as String,
      taxAmount: taxAmount == const $CopyWithPlaceholder()
          ? _value.taxAmount
          // ignore: cast_nullable_to_non_nullable
          : taxAmount as int,
      totalAmount: totalAmount == const $CopyWithPlaceholder()
          ? _value.totalAmount
          // ignore: cast_nullable_to_non_nullable
          : totalAmount as int,
      transactionId: transactionId == const $CopyWithPlaceholder()
          ? _value.transactionId
          // ignore: cast_nullable_to_non_nullable
          : transactionId as String,
    );
  }
}

extension $RefundCopyWith on Refund {
  /// Returns a callable class that can be used as follows: `instanceOfRefund.copyWith(...)` or like so:`instanceOfRefund.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RefundCWProxy get copyWith => _$RefundCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Refund _$RefundFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Refund',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'actor_id',
        'actor_name',
        'cash_session_id',
        'created_at',
        'id',
        'items',
        'method',
        'mode',
        'net_amount',
        'reason',
        'refund_number',
        'request_id',
        'tax_amount',
        'total_amount',
        'transaction_id',
      ],
    );
    final val = Refund(
      actorId: $checkedConvert('actor_id', (v) => v as String),
      actorName: $checkedConvert('actor_name', (v) => v as String),
      cashSessionId: $checkedConvert('cash_session_id', (v) => v as String),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      id: $checkedConvert('id', (v) => v as String),
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>?)
            ?.map((e) => RefundItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      method: $checkedConvert('method', (v) => v as String),
      mode: $checkedConvert('mode', (v) => v as String),
      netAmount: $checkedConvert('net_amount', (v) => (v as num).toInt()),
      reason: $checkedConvert('reason', (v) => v as String),
      refundNumber: $checkedConvert('refund_number', (v) => v as String),
      requestId: $checkedConvert('request_id', (v) => v as String),
      taxAmount: $checkedConvert('tax_amount', (v) => (v as num).toInt()),
      totalAmount: $checkedConvert('total_amount', (v) => (v as num).toInt()),
      transactionId: $checkedConvert('transaction_id', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'actorId': 'actor_id',
    'actorName': 'actor_name',
    'cashSessionId': 'cash_session_id',
    'createdAt': 'created_at',
    'netAmount': 'net_amount',
    'refundNumber': 'refund_number',
    'requestId': 'request_id',
    'taxAmount': 'tax_amount',
    'totalAmount': 'total_amount',
    'transactionId': 'transaction_id',
  },
);

Map<String, dynamic> _$RefundToJson(Refund instance) => <String, dynamic>{
  'actor_id': instance.actorId,
  'actor_name': instance.actorName,
  'cash_session_id': instance.cashSessionId,
  'created_at': instance.createdAt.toIso8601String(),
  'id': instance.id,
  'items': instance.items?.map((e) => e.toJson()).toList(),
  'method': instance.method,
  'mode': instance.mode,
  'net_amount': instance.netAmount,
  'reason': instance.reason,
  'refund_number': instance.refundNumber,
  'request_id': instance.requestId,
  'tax_amount': instance.taxAmount,
  'total_amount': instance.totalAmount,
  'transaction_id': instance.transactionId,
};
