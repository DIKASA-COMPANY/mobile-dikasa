// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RefundItemCWProxy {
  RefundItem id(String id);

  RefundItem netAmount(int netAmount);

  RefundItem quantity(int quantity);

  RefundItem restockQuantity(int restockQuantity);

  RefundItem taxAmount(int taxAmount);

  RefundItem totalAmount(int totalAmount);

  RefundItem transactionItemId(String transactionItemId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RefundItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RefundItem(...).copyWith(id: 12, name: "My name")
  /// ````
  RefundItem call({
    String id,
    int netAmount,
    int quantity,
    int restockQuantity,
    int taxAmount,
    int totalAmount,
    String transactionItemId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRefundItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRefundItem.copyWith.fieldName(...)`
class _$RefundItemCWProxyImpl implements _$RefundItemCWProxy {
  const _$RefundItemCWProxyImpl(this._value);

  final RefundItem _value;

  @override
  RefundItem id(String id) => this(id: id);

  @override
  RefundItem netAmount(int netAmount) => this(netAmount: netAmount);

  @override
  RefundItem quantity(int quantity) => this(quantity: quantity);

  @override
  RefundItem restockQuantity(int restockQuantity) =>
      this(restockQuantity: restockQuantity);

  @override
  RefundItem taxAmount(int taxAmount) => this(taxAmount: taxAmount);

  @override
  RefundItem totalAmount(int totalAmount) => this(totalAmount: totalAmount);

  @override
  RefundItem transactionItemId(String transactionItemId) =>
      this(transactionItemId: transactionItemId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RefundItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RefundItem(...).copyWith(id: 12, name: "My name")
  /// ````
  RefundItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? netAmount = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? restockQuantity = const $CopyWithPlaceholder(),
    Object? taxAmount = const $CopyWithPlaceholder(),
    Object? totalAmount = const $CopyWithPlaceholder(),
    Object? transactionItemId = const $CopyWithPlaceholder(),
  }) {
    return RefundItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      netAmount: netAmount == const $CopyWithPlaceholder()
          ? _value.netAmount
          // ignore: cast_nullable_to_non_nullable
          : netAmount as int,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int,
      restockQuantity: restockQuantity == const $CopyWithPlaceholder()
          ? _value.restockQuantity
          // ignore: cast_nullable_to_non_nullable
          : restockQuantity as int,
      taxAmount: taxAmount == const $CopyWithPlaceholder()
          ? _value.taxAmount
          // ignore: cast_nullable_to_non_nullable
          : taxAmount as int,
      totalAmount: totalAmount == const $CopyWithPlaceholder()
          ? _value.totalAmount
          // ignore: cast_nullable_to_non_nullable
          : totalAmount as int,
      transactionItemId: transactionItemId == const $CopyWithPlaceholder()
          ? _value.transactionItemId
          // ignore: cast_nullable_to_non_nullable
          : transactionItemId as String,
    );
  }
}

extension $RefundItemCopyWith on RefundItem {
  /// Returns a callable class that can be used as follows: `instanceOfRefundItem.copyWith(...)` or like so:`instanceOfRefundItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RefundItemCWProxy get copyWith => _$RefundItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundItem _$RefundItemFromJson(Map<String, dynamic> json) => $checkedCreate(
  'RefundItem',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'id',
        'net_amount',
        'quantity',
        'restock_quantity',
        'tax_amount',
        'total_amount',
        'transaction_item_id',
      ],
    );
    final val = RefundItem(
      id: $checkedConvert('id', (v) => v as String),
      netAmount: $checkedConvert('net_amount', (v) => (v as num).toInt()),
      quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
      restockQuantity: $checkedConvert(
        'restock_quantity',
        (v) => (v as num).toInt(),
      ),
      taxAmount: $checkedConvert('tax_amount', (v) => (v as num).toInt()),
      totalAmount: $checkedConvert('total_amount', (v) => (v as num).toInt()),
      transactionItemId: $checkedConvert(
        'transaction_item_id',
        (v) => v as String,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'netAmount': 'net_amount',
    'restockQuantity': 'restock_quantity',
    'taxAmount': 'tax_amount',
    'totalAmount': 'total_amount',
    'transactionItemId': 'transaction_item_id',
  },
);

Map<String, dynamic> _$RefundItemToJson(RefundItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'net_amount': instance.netAmount,
      'quantity': instance.quantity,
      'restock_quantity': instance.restockQuantity,
      'tax_amount': instance.taxAmount,
      'total_amount': instance.totalAmount,
      'transaction_item_id': instance.transactionItemId,
    };
