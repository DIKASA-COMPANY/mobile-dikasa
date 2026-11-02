// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_command.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StockCommandCWProxy {
  StockCommand initialQuantity(int? initialQuantity);

  StockCommand lowStockThreshold(int? lowStockThreshold);

  StockCommand quantityDelta(int? quantityDelta);

  StockCommand reason(String reason);

  StockCommand requestId(String requestId);

  StockCommand trackStock(bool? trackStock);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StockCommand(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StockCommand(...).copyWith(id: 12, name: "My name")
  /// ````
  StockCommand call({
    int? initialQuantity,
    int? lowStockThreshold,
    int? quantityDelta,
    String reason,
    String requestId,
    bool? trackStock,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStockCommand.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStockCommand.copyWith.fieldName(...)`
class _$StockCommandCWProxyImpl implements _$StockCommandCWProxy {
  const _$StockCommandCWProxyImpl(this._value);

  final StockCommand _value;

  @override
  StockCommand initialQuantity(int? initialQuantity) =>
      this(initialQuantity: initialQuantity);

  @override
  StockCommand lowStockThreshold(int? lowStockThreshold) =>
      this(lowStockThreshold: lowStockThreshold);

  @override
  StockCommand quantityDelta(int? quantityDelta) =>
      this(quantityDelta: quantityDelta);

  @override
  StockCommand reason(String reason) => this(reason: reason);

  @override
  StockCommand requestId(String requestId) => this(requestId: requestId);

  @override
  StockCommand trackStock(bool? trackStock) => this(trackStock: trackStock);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StockCommand(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StockCommand(...).copyWith(id: 12, name: "My name")
  /// ````
  StockCommand call({
    Object? initialQuantity = const $CopyWithPlaceholder(),
    Object? lowStockThreshold = const $CopyWithPlaceholder(),
    Object? quantityDelta = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? requestId = const $CopyWithPlaceholder(),
    Object? trackStock = const $CopyWithPlaceholder(),
  }) {
    return StockCommand(
      initialQuantity: initialQuantity == const $CopyWithPlaceholder()
          ? _value.initialQuantity
          // ignore: cast_nullable_to_non_nullable
          : initialQuantity as int?,
      lowStockThreshold: lowStockThreshold == const $CopyWithPlaceholder()
          ? _value.lowStockThreshold
          // ignore: cast_nullable_to_non_nullable
          : lowStockThreshold as int?,
      quantityDelta: quantityDelta == const $CopyWithPlaceholder()
          ? _value.quantityDelta
          // ignore: cast_nullable_to_non_nullable
          : quantityDelta as int?,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      requestId: requestId == const $CopyWithPlaceholder()
          ? _value.requestId
          // ignore: cast_nullable_to_non_nullable
          : requestId as String,
      trackStock: trackStock == const $CopyWithPlaceholder()
          ? _value.trackStock
          // ignore: cast_nullable_to_non_nullable
          : trackStock as bool?,
    );
  }
}

extension $StockCommandCopyWith on StockCommand {
  /// Returns a callable class that can be used as follows: `instanceOfStockCommand.copyWith(...)` or like so:`instanceOfStockCommand.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StockCommandCWProxy get copyWith => _$StockCommandCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockCommand _$StockCommandFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'StockCommand',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['reason', 'request_id']);
        final val = StockCommand(
          initialQuantity: $checkedConvert(
            'initial_quantity',
            (v) => (v as num?)?.toInt(),
          ),
          lowStockThreshold: $checkedConvert(
            'low_stock_threshold',
            (v) => (v as num?)?.toInt(),
          ),
          quantityDelta: $checkedConvert(
            'quantity_delta',
            (v) => (v as num?)?.toInt(),
          ),
          reason: $checkedConvert('reason', (v) => v as String),
          requestId: $checkedConvert('request_id', (v) => v as String),
          trackStock: $checkedConvert('track_stock', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'initialQuantity': 'initial_quantity',
        'lowStockThreshold': 'low_stock_threshold',
        'quantityDelta': 'quantity_delta',
        'requestId': 'request_id',
        'trackStock': 'track_stock',
      },
    );

Map<String, dynamic> _$StockCommandToJson(StockCommand instance) =>
    <String, dynamic>{
      'initial_quantity': ?instance.initialQuantity,
      'low_stock_threshold': ?instance.lowStockThreshold,
      'quantity_delta': ?instance.quantityDelta,
      'reason': instance.reason,
      'request_id': instance.requestId,
      'track_stock': ?instance.trackStock,
    };
