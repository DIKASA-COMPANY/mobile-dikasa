// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_item_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionItemRequestCWProxy {
  TransactionItemRequest lineTotal(int lineTotal);

  TransactionItemRequest notes(String? notes);

  TransactionItemRequest productId(String productId);

  TransactionItemRequest productName(String productName);

  TransactionItemRequest productVariantId(String? productVariantId);

  TransactionItemRequest quantity(int quantity);

  TransactionItemRequest unitPrice(int unitPrice);

  TransactionItemRequest variantName(String? variantName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionItemRequest call({
    int lineTotal,
    String? notes,
    String productId,
    String productName,
    String? productVariantId,
    int quantity,
    int unitPrice,
    String? variantName,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransactionItemRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransactionItemRequest.copyWith.fieldName(...)`
class _$TransactionItemRequestCWProxyImpl
    implements _$TransactionItemRequestCWProxy {
  const _$TransactionItemRequestCWProxyImpl(this._value);

  final TransactionItemRequest _value;

  @override
  TransactionItemRequest lineTotal(int lineTotal) => this(lineTotal: lineTotal);

  @override
  TransactionItemRequest notes(String? notes) => this(notes: notes);

  @override
  TransactionItemRequest productId(String productId) =>
      this(productId: productId);

  @override
  TransactionItemRequest productName(String productName) =>
      this(productName: productName);

  @override
  TransactionItemRequest productVariantId(String? productVariantId) =>
      this(productVariantId: productVariantId);

  @override
  TransactionItemRequest quantity(int quantity) => this(quantity: quantity);

  @override
  TransactionItemRequest unitPrice(int unitPrice) => this(unitPrice: unitPrice);

  @override
  TransactionItemRequest variantName(String? variantName) =>
      this(variantName: variantName);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionItemRequest call({
    Object? lineTotal = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? productId = const $CopyWithPlaceholder(),
    Object? productName = const $CopyWithPlaceholder(),
    Object? productVariantId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? unitPrice = const $CopyWithPlaceholder(),
    Object? variantName = const $CopyWithPlaceholder(),
  }) {
    return TransactionItemRequest(
      lineTotal: lineTotal == const $CopyWithPlaceholder()
          ? _value.lineTotal
          // ignore: cast_nullable_to_non_nullable
          : lineTotal as int,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
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

extension $TransactionItemRequestCopyWith on TransactionItemRequest {
  /// Returns a callable class that can be used as follows: `instanceOfTransactionItemRequest.copyWith(...)` or like so:`instanceOfTransactionItemRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionItemRequestCWProxy get copyWith =>
      _$TransactionItemRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionItemRequest _$TransactionItemRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'TransactionItemRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'line_total',
        'product_id',
        'product_name',
        'quantity',
        'unit_price',
      ],
    );
    final val = TransactionItemRequest(
      lineTotal: $checkedConvert('line_total', (v) => (v as num).toInt()),
      notes: $checkedConvert('notes', (v) => v as String?),
      productId: $checkedConvert('product_id', (v) => v as String),
      productName: $checkedConvert('product_name', (v) => v as String),
      productVariantId: $checkedConvert(
        'product_variant_id',
        (v) => v as String?,
      ),
      quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
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
    'unitPrice': 'unit_price',
    'variantName': 'variant_name',
  },
);

Map<String, dynamic> _$TransactionItemRequestToJson(
  TransactionItemRequest instance,
) => <String, dynamic>{
  'line_total': instance.lineTotal,
  'notes': ?instance.notes,
  'product_id': instance.productId,
  'product_name': instance.productName,
  'product_variant_id': ?instance.productVariantId,
  'quantity': instance.quantity,
  'unit_price': instance.unitPrice,
  'variant_name': ?instance.variantName,
};
