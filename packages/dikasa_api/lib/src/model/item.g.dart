// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ItemCWProxy {
  Item notes(String? notes);

  Item position(int? position);

  Item productId(String productId);

  Item productName(String productName);

  Item productVariantId(String? productVariantId);

  Item quantity(int quantity);

  Item unitPrice(int unitPrice);

  Item variantName(String? variantName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Item(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Item(...).copyWith(id: 12, name: "My name")
  /// ````
  Item call({
    String? notes,
    int? position,
    String productId,
    String productName,
    String? productVariantId,
    int quantity,
    int unitPrice,
    String? variantName,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfItem.copyWith.fieldName(...)`
class _$ItemCWProxyImpl implements _$ItemCWProxy {
  const _$ItemCWProxyImpl(this._value);

  final Item _value;

  @override
  Item notes(String? notes) => this(notes: notes);

  @override
  Item position(int? position) => this(position: position);

  @override
  Item productId(String productId) => this(productId: productId);

  @override
  Item productName(String productName) => this(productName: productName);

  @override
  Item productVariantId(String? productVariantId) =>
      this(productVariantId: productVariantId);

  @override
  Item quantity(int quantity) => this(quantity: quantity);

  @override
  Item unitPrice(int unitPrice) => this(unitPrice: unitPrice);

  @override
  Item variantName(String? variantName) => this(variantName: variantName);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Item(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Item(...).copyWith(id: 12, name: "My name")
  /// ````
  Item call({
    Object? notes = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? productId = const $CopyWithPlaceholder(),
    Object? productName = const $CopyWithPlaceholder(),
    Object? productVariantId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? unitPrice = const $CopyWithPlaceholder(),
    Object? variantName = const $CopyWithPlaceholder(),
  }) {
    return Item(
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
      position: position == const $CopyWithPlaceholder()
          ? _value.position
          // ignore: cast_nullable_to_non_nullable
          : position as int?,
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

extension $ItemCopyWith on Item {
  /// Returns a callable class that can be used as follows: `instanceOfItem.copyWith(...)` or like so:`instanceOfItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ItemCWProxy get copyWith => _$ItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Item',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'product_id',
        'product_name',
        'quantity',
        'unit_price',
      ],
    );
    final val = Item(
      notes: $checkedConvert('notes', (v) => v as String?),
      position: $checkedConvert('position', (v) => (v as num?)?.toInt()),
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
    'productId': 'product_id',
    'productName': 'product_name',
    'productVariantId': 'product_variant_id',
    'unitPrice': 'unit_price',
    'variantName': 'variant_name',
  },
);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
  'notes': ?instance.notes,
  'position': ?instance.position,
  'product_id': instance.productId,
  'product_name': instance.productName,
  'product_variant_id': ?instance.productVariantId,
  'quantity': instance.quantity,
  'unit_price': instance.unitPrice,
  'variant_name': ?instance.variantName,
};
