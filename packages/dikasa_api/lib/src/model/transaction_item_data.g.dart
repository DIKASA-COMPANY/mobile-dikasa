// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_item_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionItemDataCWProxy {
  TransactionItemData id(String id);

  TransactionItemData lineTotal(int lineTotal);

  TransactionItemData notes(String? notes);

  TransactionItemData productId(String productId);

  TransactionItemData productName(String productName);

  TransactionItemData productVariantId(String? productVariantId);

  TransactionItemData quantity(int quantity);

  TransactionItemData unitPrice(int unitPrice);

  TransactionItemData variantName(String? variantName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionItemData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionItemData(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionItemData call({
    String id,
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

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransactionItemData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransactionItemData.copyWith.fieldName(...)`
class _$TransactionItemDataCWProxyImpl implements _$TransactionItemDataCWProxy {
  const _$TransactionItemDataCWProxyImpl(this._value);

  final TransactionItemData _value;

  @override
  TransactionItemData id(String id) => this(id: id);

  @override
  TransactionItemData lineTotal(int lineTotal) => this(lineTotal: lineTotal);

  @override
  TransactionItemData notes(String? notes) => this(notes: notes);

  @override
  TransactionItemData productId(String productId) => this(productId: productId);

  @override
  TransactionItemData productName(String productName) =>
      this(productName: productName);

  @override
  TransactionItemData productVariantId(String? productVariantId) =>
      this(productVariantId: productVariantId);

  @override
  TransactionItemData quantity(int quantity) => this(quantity: quantity);

  @override
  TransactionItemData unitPrice(int unitPrice) => this(unitPrice: unitPrice);

  @override
  TransactionItemData variantName(String? variantName) =>
      this(variantName: variantName);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionItemData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionItemData(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionItemData call({
    Object? id = const $CopyWithPlaceholder(),
    Object? lineTotal = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? productId = const $CopyWithPlaceholder(),
    Object? productName = const $CopyWithPlaceholder(),
    Object? productVariantId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? unitPrice = const $CopyWithPlaceholder(),
    Object? variantName = const $CopyWithPlaceholder(),
  }) {
    return TransactionItemData(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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

extension $TransactionItemDataCopyWith on TransactionItemData {
  /// Returns a callable class that can be used as follows: `instanceOfTransactionItemData.copyWith(...)` or like so:`instanceOfTransactionItemData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionItemDataCWProxy get copyWith =>
      _$TransactionItemDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionItemData _$TransactionItemDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TransactionItemData',
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
            'unit_price',
          ],
        );
        final val = TransactionItemData(
          id: $checkedConvert('id', (v) => v as String),
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

Map<String, dynamic> _$TransactionItemDataToJson(
  TransactionItemData instance,
) => <String, dynamic>{
  'id': instance.id,
  'line_total': instance.lineTotal,
  'notes': ?instance.notes,
  'product_id': instance.productId,
  'product_name': instance.productName,
  'product_variant_id': ?instance.productVariantId,
  'quantity': instance.quantity,
  'unit_price': instance.unitPrice,
  'variant_name': ?instance.variantName,
};
