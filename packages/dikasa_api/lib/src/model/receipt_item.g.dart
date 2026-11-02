// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReceiptItemCWProxy {
  ReceiptItem id(String id);

  ReceiptItem lineTotal(int lineTotal);

  ReceiptItem productId(String productId);

  ReceiptItem productName(String productName);

  ReceiptItem productVariantId(String? productVariantId);

  ReceiptItem quantity(int quantity);

  ReceiptItem refundedQuantity(int refundedQuantity);

  ReceiptItem restockBudget(int restockBudget);

  ReceiptItem returnedQuantity(int returnedQuantity);

  ReceiptItem stockQuantity(int stockQuantity);

  ReceiptItem trackStock(bool trackStock);

  ReceiptItem unitPrice(int unitPrice);

  ReceiptItem variantName(String? variantName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReceiptItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReceiptItem(...).copyWith(id: 12, name: "My name")
  /// ````
  ReceiptItem call({
    String id,
    int lineTotal,
    String productId,
    String productName,
    String? productVariantId,
    int quantity,
    int refundedQuantity,
    int restockBudget,
    int returnedQuantity,
    int stockQuantity,
    bool trackStock,
    int unitPrice,
    String? variantName,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReceiptItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReceiptItem.copyWith.fieldName(...)`
class _$ReceiptItemCWProxyImpl implements _$ReceiptItemCWProxy {
  const _$ReceiptItemCWProxyImpl(this._value);

  final ReceiptItem _value;

  @override
  ReceiptItem id(String id) => this(id: id);

  @override
  ReceiptItem lineTotal(int lineTotal) => this(lineTotal: lineTotal);

  @override
  ReceiptItem productId(String productId) => this(productId: productId);

  @override
  ReceiptItem productName(String productName) => this(productName: productName);

  @override
  ReceiptItem productVariantId(String? productVariantId) =>
      this(productVariantId: productVariantId);

  @override
  ReceiptItem quantity(int quantity) => this(quantity: quantity);

  @override
  ReceiptItem refundedQuantity(int refundedQuantity) =>
      this(refundedQuantity: refundedQuantity);

  @override
  ReceiptItem restockBudget(int restockBudget) =>
      this(restockBudget: restockBudget);

  @override
  ReceiptItem returnedQuantity(int returnedQuantity) =>
      this(returnedQuantity: returnedQuantity);

  @override
  ReceiptItem stockQuantity(int stockQuantity) =>
      this(stockQuantity: stockQuantity);

  @override
  ReceiptItem trackStock(bool trackStock) => this(trackStock: trackStock);

  @override
  ReceiptItem unitPrice(int unitPrice) => this(unitPrice: unitPrice);

  @override
  ReceiptItem variantName(String? variantName) =>
      this(variantName: variantName);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReceiptItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReceiptItem(...).copyWith(id: 12, name: "My name")
  /// ````
  ReceiptItem call({
    Object? id = const $CopyWithPlaceholder(),
    Object? lineTotal = const $CopyWithPlaceholder(),
    Object? productId = const $CopyWithPlaceholder(),
    Object? productName = const $CopyWithPlaceholder(),
    Object? productVariantId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? refundedQuantity = const $CopyWithPlaceholder(),
    Object? restockBudget = const $CopyWithPlaceholder(),
    Object? returnedQuantity = const $CopyWithPlaceholder(),
    Object? stockQuantity = const $CopyWithPlaceholder(),
    Object? trackStock = const $CopyWithPlaceholder(),
    Object? unitPrice = const $CopyWithPlaceholder(),
    Object? variantName = const $CopyWithPlaceholder(),
  }) {
    return ReceiptItem(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      lineTotal: lineTotal == const $CopyWithPlaceholder()
          ? _value.lineTotal
          // ignore: cast_nullable_to_non_nullable
          : lineTotal as int,
      productId: productId == const $CopyWithPlaceholder()
          ? _value.productId
          // ignore: cast_nullable_to_non_nullable
          : productId as String,
      productName: productName == const $CopyWithPlaceholder()
          ? _value.productName
          // ignore: cast_nullable_to_non_nullable
          : productName as String,
      productVariantId: productVariantId == const $CopyWithPlaceholder()
          ? _value.productVariantId
          // ignore: cast_nullable_to_non_nullable
          : productVariantId as String?,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int,
      refundedQuantity: refundedQuantity == const $CopyWithPlaceholder()
          ? _value.refundedQuantity
          // ignore: cast_nullable_to_non_nullable
          : refundedQuantity as int,
      restockBudget: restockBudget == const $CopyWithPlaceholder()
          ? _value.restockBudget
          // ignore: cast_nullable_to_non_nullable
          : restockBudget as int,
      returnedQuantity: returnedQuantity == const $CopyWithPlaceholder()
          ? _value.returnedQuantity
          // ignore: cast_nullable_to_non_nullable
          : returnedQuantity as int,
      stockQuantity: stockQuantity == const $CopyWithPlaceholder()
          ? _value.stockQuantity
          // ignore: cast_nullable_to_non_nullable
          : stockQuantity as int,
      trackStock: trackStock == const $CopyWithPlaceholder()
          ? _value.trackStock
          // ignore: cast_nullable_to_non_nullable
          : trackStock as bool,
      unitPrice: unitPrice == const $CopyWithPlaceholder()
          ? _value.unitPrice
          // ignore: cast_nullable_to_non_nullable
          : unitPrice as int,
      variantName: variantName == const $CopyWithPlaceholder()
          ? _value.variantName
          // ignore: cast_nullable_to_non_nullable
          : variantName as String?,
    );
  }
}

extension $ReceiptItemCopyWith on ReceiptItem {
  /// Returns a callable class that can be used as follows: `instanceOfReceiptItem.copyWith(...)` or like so:`instanceOfReceiptItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReceiptItemCWProxy get copyWith => _$ReceiptItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptItem _$ReceiptItemFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ReceiptItem',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'id',
        'line_total',
        'product_id',
        'product_name',
        'quantity',
        'refunded_quantity',
        'restock_budget',
        'returned_quantity',
        'stock_quantity',
        'track_stock',
        'unit_price',
      ],
    );
    final val = ReceiptItem(
      id: $checkedConvert('id', (v) => v as String),
      lineTotal: $checkedConvert('line_total', (v) => (v as num).toInt()),
      productId: $checkedConvert('product_id', (v) => v as String),
      productName: $checkedConvert('product_name', (v) => v as String),
      productVariantId: $checkedConvert(
        'product_variant_id',
        (v) => v as String?,
      ),
      quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
      refundedQuantity: $checkedConvert(
        'refunded_quantity',
        (v) => (v as num).toInt(),
      ),
      restockBudget: $checkedConvert(
        'restock_budget',
        (v) => (v as num).toInt(),
      ),
      returnedQuantity: $checkedConvert(
        'returned_quantity',
        (v) => (v as num).toInt(),
      ),
      stockQuantity: $checkedConvert(
        'stock_quantity',
        (v) => (v as num).toInt(),
      ),
      trackStock: $checkedConvert('track_stock', (v) => v as bool),
      unitPrice: $checkedConvert('unit_price', (v) => (v as num).toInt()),
      variantName: $checkedConvert('variant_name', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'lineTotal': 'line_total',
    'productId': 'product_id',
    'productName': 'product_name',
    'productVariantId': 'product_variant_id',
    'refundedQuantity': 'refunded_quantity',
    'restockBudget': 'restock_budget',
    'returnedQuantity': 'returned_quantity',
    'stockQuantity': 'stock_quantity',
    'trackStock': 'track_stock',
    'unitPrice': 'unit_price',
    'variantName': 'variant_name',
  },
);

Map<String, dynamic> _$ReceiptItemToJson(ReceiptItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'line_total': instance.lineTotal,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'product_variant_id': ?instance.productVariantId,
      'quantity': instance.quantity,
      'refunded_quantity': instance.refundedQuantity,
      'restock_budget': instance.restockBudget,
      'returned_quantity': instance.returnedQuantity,
      'stock_quantity': instance.stockQuantity,
      'track_stock': instance.trackStock,
      'unit_price': instance.unitPrice,
      'variant_name': ?instance.variantName,
    };
