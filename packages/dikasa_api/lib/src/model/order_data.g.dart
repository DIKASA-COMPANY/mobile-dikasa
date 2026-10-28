// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderDataCWProxy {
  OrderData customerId(String? customerId);

  OrderData customerName(String customerName);

  OrderData id(String id);

  OrderData netAfterRefund(int? netAfterRefund);

  OrderData orderType(OrderListTypeData orderType);

  OrderData orderedAt(DateTime orderedAt);

  OrderData receiptNumber(String receiptNumber);

  OrderData refundRevision(int refundRevision);

  OrderData refundedAmount(int? refundedAmount);

  OrderData refundsSupported(bool refundsSupported);

  OrderData restaurantTable(RestaurantTableData? restaurantTable);

  OrderData status(OrderDataStatusEnum status);

  OrderData totalAmount(int totalAmount);

  OrderData totalQuantity(int totalQuantity);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderData(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderData call({
    String? customerId,
    String customerName,
    String id,
    int? netAfterRefund,
    OrderListTypeData orderType,
    DateTime orderedAt,
    String receiptNumber,
    int refundRevision,
    int? refundedAmount,
    bool refundsSupported,
    RestaurantTableData? restaurantTable,
    OrderDataStatusEnum status,
    int totalAmount,
    int totalQuantity,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderData.copyWith.fieldName(...)`
class _$OrderDataCWProxyImpl implements _$OrderDataCWProxy {
  const _$OrderDataCWProxyImpl(this._value);

  final OrderData _value;

  @override
  OrderData customerId(String? customerId) => this(customerId: customerId);

  @override
  OrderData customerName(String customerName) =>
      this(customerName: customerName);

  @override
  OrderData id(String id) => this(id: id);

  @override
  OrderData netAfterRefund(int? netAfterRefund) =>
      this(netAfterRefund: netAfterRefund);

  @override
  OrderData orderType(OrderListTypeData orderType) =>
      this(orderType: orderType);

  @override
  OrderData orderedAt(DateTime orderedAt) => this(orderedAt: orderedAt);

  @override
  OrderData receiptNumber(String receiptNumber) =>
      this(receiptNumber: receiptNumber);

  @override
  OrderData refundRevision(int refundRevision) =>
      this(refundRevision: refundRevision);

  @override
  OrderData refundedAmount(int? refundedAmount) =>
      this(refundedAmount: refundedAmount);

  @override
  OrderData refundsSupported(bool refundsSupported) =>
      this(refundsSupported: refundsSupported);

  @override
  OrderData restaurantTable(RestaurantTableData? restaurantTable) =>
      this(restaurantTable: restaurantTable);

  @override
  OrderData status(OrderDataStatusEnum status) => this(status: status);

  @override
  OrderData totalAmount(int totalAmount) => this(totalAmount: totalAmount);

  @override
  OrderData totalQuantity(int totalQuantity) =>
      this(totalQuantity: totalQuantity);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderData(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderData call({
    Object? customerId = const $CopyWithPlaceholder(),
    Object? customerName = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? netAfterRefund = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? orderedAt = const $CopyWithPlaceholder(),
    Object? receiptNumber = const $CopyWithPlaceholder(),
    Object? refundRevision = const $CopyWithPlaceholder(),
    Object? refundedAmount = const $CopyWithPlaceholder(),
    Object? refundsSupported = const $CopyWithPlaceholder(),
    Object? restaurantTable = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? totalAmount = const $CopyWithPlaceholder(),
    Object? totalQuantity = const $CopyWithPlaceholder(),
  }) {
    return OrderData(
      customerId: customerId == const $CopyWithPlaceholder()
          ? _value.customerId
          // ignore: cast_nullable_to_non_nullable
          : customerId as String?,
      customerName: customerName == const $CopyWithPlaceholder()
          ? _value.customerName
          // ignore: cast_nullable_to_non_nullable
          : customerName as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      netAfterRefund: netAfterRefund == const $CopyWithPlaceholder()
          ? _value.netAfterRefund
          // ignore: cast_nullable_to_non_nullable
          : netAfterRefund as int?,
      orderType: orderType == const $CopyWithPlaceholder()
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as OrderListTypeData,
      orderedAt: orderedAt == const $CopyWithPlaceholder()
          ? _value.orderedAt
          // ignore: cast_nullable_to_non_nullable
          : orderedAt as DateTime,
      receiptNumber: receiptNumber == const $CopyWithPlaceholder()
          ? _value.receiptNumber
          // ignore: cast_nullable_to_non_nullable
          : receiptNumber as String,
      refundRevision: refundRevision == const $CopyWithPlaceholder()
          ? _value.refundRevision
          // ignore: cast_nullable_to_non_nullable
          : refundRevision as int,
      refundedAmount: refundedAmount == const $CopyWithPlaceholder()
          ? _value.refundedAmount
          // ignore: cast_nullable_to_non_nullable
          : refundedAmount as int?,
      refundsSupported: refundsSupported == const $CopyWithPlaceholder()
          ? _value.refundsSupported
          // ignore: cast_nullable_to_non_nullable
          : refundsSupported as bool,
      restaurantTable: restaurantTable == const $CopyWithPlaceholder()
          ? _value.restaurantTable
          // ignore: cast_nullable_to_non_nullable
          : restaurantTable as RestaurantTableData?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as OrderDataStatusEnum,
      totalAmount: totalAmount == const $CopyWithPlaceholder()
          ? _value.totalAmount
          // ignore: cast_nullable_to_non_nullable
          : totalAmount as int,
      totalQuantity: totalQuantity == const $CopyWithPlaceholder()
          ? _value.totalQuantity
          // ignore: cast_nullable_to_non_nullable
          : totalQuantity as int,
    );
  }
}

extension $OrderDataCopyWith on OrderData {
  /// Returns a callable class that can be used as follows: `instanceOfOrderData.copyWith(...)` or like so:`instanceOfOrderData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderDataCWProxy get copyWith => _$OrderDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderData _$OrderDataFromJson(Map<String, dynamic> json) => $checkedCreate(
  'OrderData',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'customer_name',
        'id',
        'net_after_refund',
        'order_type',
        'ordered_at',
        'receipt_number',
        'refund_revision',
        'refunded_amount',
        'refunds_supported',
        'status',
        'total_amount',
        'total_quantity',
      ],
    );
    final val = OrderData(
      customerId: $checkedConvert('customer_id', (v) => v as String?),
      customerName: $checkedConvert('customer_name', (v) => v as String),
      id: $checkedConvert('id', (v) => v as String),
      netAfterRefund: $checkedConvert(
        'net_after_refund',
        (v) => (v as num?)?.toInt(),
      ),
      orderType: $checkedConvert(
        'order_type',
        (v) => OrderListTypeData.fromJson(v as Map<String, dynamic>),
      ),
      orderedAt: $checkedConvert(
        'ordered_at',
        (v) => DateTime.parse(v as String),
      ),
      receiptNumber: $checkedConvert('receipt_number', (v) => v as String),
      refundRevision: $checkedConvert(
        'refund_revision',
        (v) => (v as num).toInt(),
      ),
      refundedAmount: $checkedConvert(
        'refunded_amount',
        (v) => (v as num?)?.toInt(),
      ),
      refundsSupported: $checkedConvert('refunds_supported', (v) => v as bool),
      restaurantTable: $checkedConvert(
        'restaurant_table',
        (v) => v == null
            ? null
            : RestaurantTableData.fromJson(v as Map<String, dynamic>),
      ),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(
          _$OrderDataStatusEnumEnumMap,
          v,
          unknownValue: OrderDataStatusEnum.unknownDefaultOpenApi,
        ),
      ),
      totalAmount: $checkedConvert('total_amount', (v) => (v as num).toInt()),
      totalQuantity: $checkedConvert(
        'total_quantity',
        (v) => (v as num).toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'customerId': 'customer_id',
    'customerName': 'customer_name',
    'netAfterRefund': 'net_after_refund',
    'orderType': 'order_type',
    'orderedAt': 'ordered_at',
    'receiptNumber': 'receipt_number',
    'refundRevision': 'refund_revision',
    'refundedAmount': 'refunded_amount',
    'refundsSupported': 'refunds_supported',
    'restaurantTable': 'restaurant_table',
    'totalAmount': 'total_amount',
    'totalQuantity': 'total_quantity',
  },
);

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
  'customer_id': ?instance.customerId,
  'customer_name': instance.customerName,
  'id': instance.id,
  'net_after_refund': instance.netAfterRefund,
  'order_type': instance.orderType.toJson(),
  'ordered_at': instance.orderedAt.toIso8601String(),
  'receipt_number': instance.receiptNumber,
  'refund_revision': instance.refundRevision,
  'refunded_amount': instance.refundedAmount,
  'refunds_supported': instance.refundsSupported,
  'restaurant_table': ?instance.restaurantTable?.toJson(),
  'status': _$OrderDataStatusEnumEnumMap[instance.status]!,
  'total_amount': instance.totalAmount,
  'total_quantity': instance.totalQuantity,
};

const _$OrderDataStatusEnumEnumMap = {
  OrderDataStatusEnum.paid: 'paid',
  OrderDataStatusEnum.partiallyRefunded: 'partially_refunded',
  OrderDataStatusEnum.refunded: 'refunded',
  OrderDataStatusEnum.cancelled: 'cancelled',
  OrderDataStatusEnum.unknownDefaultOpenApi: 'unknown_default_open_api',
};
