// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_movement.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StockMovementCWProxy {
  StockMovement balanceAfter(int balanceAfter);

  StockMovement createdAt(DateTime createdAt);

  StockMovement createdBy(String createdBy);

  StockMovement id(String id);

  StockMovement kind(String kind);

  StockMovement lowStockThreshold(int lowStockThreshold);

  StockMovement productId(String productId);

  StockMovement quantityDelta(int quantityDelta);

  StockMovement reason(String reason);

  StockMovement refundId(String? refundId);

  StockMovement requestId(String? requestId);

  StockMovement trackStock(bool trackStock);

  StockMovement transactionId(String? transactionId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StockMovement(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StockMovement(...).copyWith(id: 12, name: "My name")
  /// ````
  StockMovement call({
    int balanceAfter,
    DateTime createdAt,
    String createdBy,
    String id,
    String kind,
    int lowStockThreshold,
    String productId,
    int quantityDelta,
    String reason,
    String? refundId,
    String? requestId,
    bool trackStock,
    String? transactionId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStockMovement.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStockMovement.copyWith.fieldName(...)`
class _$StockMovementCWProxyImpl implements _$StockMovementCWProxy {
  const _$StockMovementCWProxyImpl(this._value);

  final StockMovement _value;

  @override
  StockMovement balanceAfter(int balanceAfter) =>
      this(balanceAfter: balanceAfter);

  @override
  StockMovement createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  StockMovement createdBy(String createdBy) => this(createdBy: createdBy);

  @override
  StockMovement id(String id) => this(id: id);

  @override
  StockMovement kind(String kind) => this(kind: kind);

  @override
  StockMovement lowStockThreshold(int lowStockThreshold) =>
      this(lowStockThreshold: lowStockThreshold);

  @override
  StockMovement productId(String productId) => this(productId: productId);

  @override
  StockMovement quantityDelta(int quantityDelta) =>
      this(quantityDelta: quantityDelta);

  @override
  StockMovement reason(String reason) => this(reason: reason);

  @override
  StockMovement refundId(String? refundId) => this(refundId: refundId);

  @override
  StockMovement requestId(String? requestId) => this(requestId: requestId);

  @override
  StockMovement trackStock(bool trackStock) => this(trackStock: trackStock);

  @override
  StockMovement transactionId(String? transactionId) =>
      this(transactionId: transactionId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StockMovement(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StockMovement(...).copyWith(id: 12, name: "My name")
  /// ````
  StockMovement call({
    Object? balanceAfter = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? createdBy = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? kind = const $CopyWithPlaceholder(),
    Object? lowStockThreshold = const $CopyWithPlaceholder(),
    Object? productId = const $CopyWithPlaceholder(),
    Object? quantityDelta = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? refundId = const $CopyWithPlaceholder(),
    Object? requestId = const $CopyWithPlaceholder(),
    Object? trackStock = const $CopyWithPlaceholder(),
    Object? transactionId = const $CopyWithPlaceholder(),
  }) {
    return StockMovement(
      balanceAfter: balanceAfter == const $CopyWithPlaceholder()
          ? _value.balanceAfter
          // ignore: cast_nullable_to_non_nullable
          : balanceAfter as int,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      createdBy: createdBy == const $CopyWithPlaceholder()
          ? _value.createdBy
          // ignore: cast_nullable_to_non_nullable
          : createdBy as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      kind: kind == const $CopyWithPlaceholder()
          ? _value.kind
          // ignore: cast_nullable_to_non_nullable
          : kind as String,
      lowStockThreshold: lowStockThreshold == const $CopyWithPlaceholder()
          ? _value.lowStockThreshold
          // ignore: cast_nullable_to_non_nullable
          : lowStockThreshold as int,
      productId: productId == const $CopyWithPlaceholder()
          ? _value.productId
          // ignore: cast_nullable_to_non_nullable
          : productId as String,
      quantityDelta: quantityDelta == const $CopyWithPlaceholder()
          ? _value.quantityDelta
          // ignore: cast_nullable_to_non_nullable
          : quantityDelta as int,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      refundId: refundId == const $CopyWithPlaceholder()
          ? _value.refundId
          // ignore: cast_nullable_to_non_nullable
          : refundId as String?,
      requestId: requestId == const $CopyWithPlaceholder()
          ? _value.requestId
          // ignore: cast_nullable_to_non_nullable
          : requestId as String?,
      trackStock: trackStock == const $CopyWithPlaceholder()
          ? _value.trackStock
          // ignore: cast_nullable_to_non_nullable
          : trackStock as bool,
      transactionId: transactionId == const $CopyWithPlaceholder()
          ? _value.transactionId
          // ignore: cast_nullable_to_non_nullable
          : transactionId as String?,
    );
  }
}

extension $StockMovementCopyWith on StockMovement {
  /// Returns a callable class that can be used as follows: `instanceOfStockMovement.copyWith(...)` or like so:`instanceOfStockMovement.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StockMovementCWProxy get copyWith => _$StockMovementCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockMovement _$StockMovementFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'StockMovement',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'balance_after',
            'created_at',
            'created_by',
            'id',
            'kind',
            'low_stock_threshold',
            'product_id',
            'quantity_delta',
            'reason',
            'track_stock',
          ],
        );
        final val = StockMovement(
          balanceAfter: $checkedConvert(
            'balance_after',
            (v) => (v as num).toInt(),
          ),
          createdAt: $checkedConvert(
            'created_at',
            (v) => DateTime.parse(v as String),
          ),
          createdBy: $checkedConvert('created_by', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String),
          kind: $checkedConvert('kind', (v) => v as String),
          lowStockThreshold: $checkedConvert(
            'low_stock_threshold',
            (v) => (v as num).toInt(),
          ),
          productId: $checkedConvert('product_id', (v) => v as String),
          quantityDelta: $checkedConvert(
            'quantity_delta',
            (v) => (v as num).toInt(),
          ),
          reason: $checkedConvert('reason', (v) => v as String),
          refundId: $checkedConvert('refund_id', (v) => v as String?),
          requestId: $checkedConvert('request_id', (v) => v as String?),
          trackStock: $checkedConvert('track_stock', (v) => v as bool),
          transactionId: $checkedConvert('transaction_id', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'balanceAfter': 'balance_after',
        'createdAt': 'created_at',
        'createdBy': 'created_by',
        'lowStockThreshold': 'low_stock_threshold',
        'productId': 'product_id',
        'quantityDelta': 'quantity_delta',
        'refundId': 'refund_id',
        'requestId': 'request_id',
        'trackStock': 'track_stock',
        'transactionId': 'transaction_id',
      },
    );

Map<String, dynamic> _$StockMovementToJson(StockMovement instance) =>
    <String, dynamic>{
      'balance_after': instance.balanceAfter,
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'id': instance.id,
      'kind': instance.kind,
      'low_stock_threshold': instance.lowStockThreshold,
      'product_id': instance.productId,
      'quantity_delta': instance.quantityDelta,
      'reason': instance.reason,
      'refund_id': ?instance.refundId,
      'request_id': ?instance.requestId,
      'track_stock': instance.trackStock,
      'transaction_id': ?instance.transactionId,
    };
