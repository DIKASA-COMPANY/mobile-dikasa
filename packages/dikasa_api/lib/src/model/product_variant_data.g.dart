// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProductVariantDataCWProxy {
  ProductVariantData costPrice(int? costPrice);

  ProductVariantData id(String id);

  ProductVariantData isActive(bool isActive);

  ProductVariantData name(String name);

  ProductVariantData onlineCostPrice(int? onlineCostPrice);

  ProductVariantData onlineSellingPrice(int? onlineSellingPrice);

  ProductVariantData sellingPrice(int sellingPrice);

  ProductVariantData sortOrder(int sortOrder);

  ProductVariantData stockStatus(ProductVariantDataStockStatusEnum stockStatus);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductVariantData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductVariantData(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductVariantData call({
    int? costPrice,
    String id,
    bool isActive,
    String name,
    int? onlineCostPrice,
    int? onlineSellingPrice,
    int sellingPrice,
    int sortOrder,
    ProductVariantDataStockStatusEnum stockStatus,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProductVariantData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProductVariantData.copyWith.fieldName(...)`
class _$ProductVariantDataCWProxyImpl implements _$ProductVariantDataCWProxy {
  const _$ProductVariantDataCWProxyImpl(this._value);

  final ProductVariantData _value;

  @override
  ProductVariantData costPrice(int? costPrice) => this(costPrice: costPrice);

  @override
  ProductVariantData id(String id) => this(id: id);

  @override
  ProductVariantData isActive(bool isActive) => this(isActive: isActive);

  @override
  ProductVariantData name(String name) => this(name: name);

  @override
  ProductVariantData onlineCostPrice(int? onlineCostPrice) =>
      this(onlineCostPrice: onlineCostPrice);

  @override
  ProductVariantData onlineSellingPrice(int? onlineSellingPrice) =>
      this(onlineSellingPrice: onlineSellingPrice);

  @override
  ProductVariantData sellingPrice(int sellingPrice) =>
      this(sellingPrice: sellingPrice);

  @override
  ProductVariantData sortOrder(int sortOrder) => this(sortOrder: sortOrder);

  @override
  ProductVariantData stockStatus(
    ProductVariantDataStockStatusEnum stockStatus,
  ) => this(stockStatus: stockStatus);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProductVariantData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProductVariantData(...).copyWith(id: 12, name: "My name")
  /// ````
  ProductVariantData call({
    Object? costPrice = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? onlineCostPrice = const $CopyWithPlaceholder(),
    Object? onlineSellingPrice = const $CopyWithPlaceholder(),
    Object? sellingPrice = const $CopyWithPlaceholder(),
    Object? sortOrder = const $CopyWithPlaceholder(),
    Object? stockStatus = const $CopyWithPlaceholder(),
  }) {
    return ProductVariantData(
      costPrice: costPrice == const $CopyWithPlaceholder()
          ? _value.costPrice
          // ignore: cast_nullable_to_non_nullable
          : costPrice as int?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
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
          : stockStatus as ProductVariantDataStockStatusEnum,
    );
  }
}

extension $ProductVariantDataCopyWith on ProductVariantData {
  /// Returns a callable class that can be used as follows: `instanceOfProductVariantData.copyWith(...)` or like so:`instanceOfProductVariantData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProductVariantDataCWProxy get copyWith =>
      _$ProductVariantDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariantData _$ProductVariantDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ProductVariantData',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'id',
        'is_active',
        'name',
        'selling_price',
        'sort_order',
        'stock_status',
      ],
    );
    final val = ProductVariantData(
      costPrice: $checkedConvert('cost_price', (v) => (v as num?)?.toInt()),
      id: $checkedConvert('id', (v) => v as String),
      isActive: $checkedConvert('is_active', (v) => v as bool),
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
          _$ProductVariantDataStockStatusEnumEnumMap,
          v,
          unknownValue: ProductVariantDataStockStatusEnum.unknownDefaultOpenApi,
        ),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'costPrice': 'cost_price',
    'isActive': 'is_active',
    'onlineCostPrice': 'online_cost_price',
    'onlineSellingPrice': 'online_selling_price',
    'sellingPrice': 'selling_price',
    'sortOrder': 'sort_order',
    'stockStatus': 'stock_status',
  },
);

Map<String, dynamic> _$ProductVariantDataToJson(ProductVariantData instance) =>
    <String, dynamic>{
      'cost_price': ?instance.costPrice,
      'id': instance.id,
      'is_active': instance.isActive,
      'name': instance.name,
      'online_cost_price': ?instance.onlineCostPrice,
      'online_selling_price': ?instance.onlineSellingPrice,
      'selling_price': instance.sellingPrice,
      'sort_order': instance.sortOrder,
      'stock_status':
          _$ProductVariantDataStockStatusEnumEnumMap[instance.stockStatus]!,
    };

const _$ProductVariantDataStockStatusEnumEnumMap = {
  ProductVariantDataStockStatusEnum.available: 'available',
  ProductVariantDataStockStatusEnum.outOfStock: 'out_of_stock',
  ProductVariantDataStockStatusEnum.unknownDefaultOpenApi:
      'unknown_default_open_api',
};
