// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductVariantRequestCWProxy {
  ProductVariantRequest costPrice(int? costPrice);

  ProductVariantRequest name(String name);

  ProductVariantRequest onlineCostPrice(int? onlineCostPrice);

  ProductVariantRequest onlineSellingPrice(int? onlineSellingPrice);

  ProductVariantRequest sellingPrice(int sellingPrice);

  ProductVariantRequest sortOrder(int sortOrder);

  ProductVariantRequest stockStatus(
    ProductVariantRequestStockStatusEnum stockStatus,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductVariantRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductVariantRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductVariantRequest call({
    int? costPrice,
    String name,
    int? onlineCostPrice,
    int? onlineSellingPrice,
    int sellingPrice,
    int sortOrder,
    ProductVariantRequestStockStatusEnum stockStatus,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductVariantRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductVariantRequest.copyWith.fieldName(...)`
class _$ProductVariantRequestCWProxyImpl
    implements _$ProductVariantRequestCWProxy {
  const _$ProductVariantRequestCWProxyImpl(this._value);

  final ProductVariantRequest _value;

  @override
  ProductVariantRequest costPrice(int? costPrice) => this(costPrice: costPrice);

  @override
  ProductVariantRequest name(String name) => this(name: name);

  @override
  ProductVariantRequest onlineCostPrice(int? onlineCostPrice) =>
      this(onlineCostPrice: onlineCostPrice);

  @override
  ProductVariantRequest onlineSellingPrice(int? onlineSellingPrice) =>
      this(onlineSellingPrice: onlineSellingPrice);

  @override
  ProductVariantRequest sellingPrice(int sellingPrice) =>
      this(sellingPrice: sellingPrice);

  @override
  ProductVariantRequest sortOrder(int sortOrder) => this(sortOrder: sortOrder);

  @override
  ProductVariantRequest stockStatus(
    ProductVariantRequestStockStatusEnum stockStatus,
  ) => this(stockStatus: stockStatus);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductVariantRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductVariantRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductVariantRequest call({
    Object? costPrice = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? onlineCostPrice = const $CopyWithPlaceholder(),
    Object? onlineSellingPrice = const $CopyWithPlaceholder(),
    Object? sellingPrice = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
    Object? stockStatus = const $CopyWithPlaceholder(),
  }) {
    return ProductVariantRequest(
      costPrice: costPrice == const $CopyWithPlaceholder()
          ? _value.costPrice
          // ignore: cast_nullable_to_non_nullable
          : costPrice as int?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      onlineCostPrice: onlineCostPrice == const $CopyWithPlaceholder()
          ? _value.onlineCostPrice
          // ignore: cast_nullable_to_non_nullable
          : onlineCostPrice as int?,
      onlineSellingPrice: onlineSellingPrice == const $CopyWithPlaceholder()
          ? _value.onlineSellingPrice
          // ignore: cast_nullable_to_non_nullable
          : onlineSellingPrice as int?,
      sellingPrice: sellingPrice == const $CopyWithPlaceholder()
          ? _value.sellingPrice
          // ignore: cast_nullable_to_non_nullable
          : sellingPrice as int,
      sortOrder: sortOrder == const $CopyWithPlaceholder()
          ? _value.sortOrder
          // ignore: cast_nullable_to_non_nullable
          : sortOrder as int,
      stockStatus: stockStatus == const $CopyWithPlaceholder()
          ? _value.stockStatus
          // ignore: cast_nullable_to_non_nullable
          : stockStatus as ProductVariantRequestStockStatusEnum,
    );
  }
}

extension $ProductVariantRequestCopyWith on ProductVariantRequest {
  /// Returns a callable class that can be used as follows: `instanceOfProductVariantRequest.copyWith(...)` or like so:`instanceOfProductVariantRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductVariantRequestCWProxy get copyWith =>
      _$ProductVariantRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariantRequest _$ProductVariantRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ProductVariantRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'name',
        'selling_price',
        'sort_order',
        'stock_status',
      ],
    );
    final val = ProductVariantRequest(
      costPrice: $checkedConvert('cost_price', (v) => (v as num?)?.toInt()),
      name: $checkedConvert('name', (v) => v as String),
      onlineCostPrice: $checkedConvert(
        'online_cost_price',
        (v) => (v as num?)?.toInt(),
      ),
      onlineSellingPrice: $checkedConvert(
        'online_selling_price',
        (v) => (v as num?)?.toInt(),
      ),
      sellingPrice: $checkedConvert('selling_price', (v) => (v as num).toInt()),
      sortOrder: $checkedConvert('sort_order', (v) => (v as num).toInt()),
      stockStatus: $checkedConvert(
        'stock_status',
        (v) => $enumDecode(
          _$ProductVariantRequestStockStatusEnumEnumMap,
          v,
          unknownValue:
              ProductVariantRequestStockStatusEnum.unknownDefaultOpenApi,
        ),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'costPrice': 'cost_price',
    'onlineCostPrice': 'online_cost_price',
    'onlineSellingPrice': 'online_selling_price',
    'sellingPrice': 'selling_price',
    'sortOrder': 'sort_order',
    'stockStatus': 'stock_status',
  },
);

Map<String, dynamic> _$ProductVariantRequestToJson(
  ProductVariantRequest instance,
) => <String, dynamic>{
  'cost_price': ?instance.costPrice,
  'name': instance.name,
  'online_cost_price': ?instance.onlineCostPrice,
  'online_selling_price': ?instance.onlineSellingPrice,
  'selling_price': instance.sellingPrice,
  'sort_order': instance.sortOrder,
  'stock_status':
      _$ProductVariantRequestStockStatusEnumEnumMap[instance.stockStatus]!,
};

const _$ProductVariantRequestStockStatusEnumEnumMap = {
  ProductVariantRequestStockStatusEnum.available: 'available',
  ProductVariantRequestStockStatusEnum.outOfStock: 'out_of_stock',
  ProductVariantRequestStockStatusEnum.unknownDefaultOpenApi:
      'unknown_default_open_api',
};
