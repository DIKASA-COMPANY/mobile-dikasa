// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionRequestCWProxy {
  TransactionRequest changeAmount(int changeAmount);

  TransactionRequest discountAmount(int discountAmount);

  TransactionRequest items(List<TransactionItemRequest>? items);

  TransactionRequest orderTypeId(String orderTypeId);

  TransactionRequest paidAmount(int paidAmount);

  TransactionRequest paymentMethod(
    TransactionRequestPaymentMethodEnum paymentMethod,
  );

  TransactionRequest restaurantTableId(String? restaurantTableId);

  TransactionRequest roundingAmount(int roundingAmount);

  TransactionRequest subtotal(int subtotal);

  TransactionRequest taxAmount(int taxAmount);

  TransactionRequest taxPercentage(double taxPercentage);

  TransactionRequest tipAmount(int tipAmount);

  TransactionRequest totalAmount(int totalAmount);

  TransactionRequest walletId(String? walletId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionRequest call({
    int changeAmount,
    int discountAmount,
    List<TransactionItemRequest>? items,
    String orderTypeId,
    int paidAmount,
    TransactionRequestPaymentMethodEnum paymentMethod,
    String? restaurantTableId,
    int roundingAmount,
    int subtotal,
    int taxAmount,
    double taxPercentage,
    int tipAmount,
    int totalAmount,
    String? walletId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransactionRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransactionRequest.copyWith.fieldName(...)`
class _$TransactionRequestCWProxyImpl implements _$TransactionRequestCWProxy {
  const _$TransactionRequestCWProxyImpl(this._value);

  final TransactionRequest _value;

  @override
  TransactionRequest changeAmount(int changeAmount) =>
      this(changeAmount: changeAmount);

  @override
  TransactionRequest discountAmount(int discountAmount) =>
      this(discountAmount: discountAmount);

  @override
  TransactionRequest items(List<TransactionItemRequest>? items) =>
      this(items: items);

  @override
  TransactionRequest orderTypeId(String orderTypeId) =>
      this(orderTypeId: orderTypeId);

  @override
  TransactionRequest paidAmount(int paidAmount) => this(paidAmount: paidAmount);

  @override
  TransactionRequest paymentMethod(
    TransactionRequestPaymentMethodEnum paymentMethod,
  ) => this(paymentMethod: paymentMethod);

  @override
  TransactionRequest restaurantTableId(String? restaurantTableId) =>
      this(restaurantTableId: restaurantTableId);

  @override
  TransactionRequest roundingAmount(int roundingAmount) =>
      this(roundingAmount: roundingAmount);

  @override
  TransactionRequest subtotal(int subtotal) => this(subtotal: subtotal);

  @override
  TransactionRequest taxAmount(int taxAmount) => this(taxAmount: taxAmount);

  @override
  TransactionRequest taxPercentage(double taxPercentage) =>
      this(taxPercentage: taxPercentage);

  @override
  TransactionRequest tipAmount(int tipAmount) => this(tipAmount: tipAmount);

  @override
  TransactionRequest totalAmount(int totalAmount) =>
      this(totalAmount: totalAmount);

  @override
  TransactionRequest walletId(String? walletId) => this(walletId: walletId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TransactionRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TransactionRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  TransactionRequest call({
    Object? changeAmount = const $CopyWithPlaceholder(),
    Object? discountAmount = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? orderTypeId = const $CopyWithPlaceholder(),
    Object? paidAmount = const $CopyWithPlaceholder(),
    Object? paymentMethod = const $CopyWithPlaceholder(),
    Object? restaurantTableId = const $CopyWithPlaceholder(),
    Object? roundingAmount = const $CopyWithPlaceholder(),
    Object? subtotal = const $CopyWithPlaceholder(),
    Object? taxAmount = const $CopyWithPlaceholder(),
    Object? taxPercentage = const $CopyWithPlaceholder(),
    Object? tipAmount = const $CopyWithPlaceholder(),
    Object? totalAmount = const $CopyWithPlaceholder(),
    Object? walletId = const $CopyWithPlaceholder(),
  }) {
    return TransactionRequest(
      changeAmount: changeAmount == const $CopyWithPlaceholder()
          ? _value.changeAmount
          // ignore: cast_nullable_to_non_nullable
          : changeAmount as int,
      discountAmount: discountAmount == const $CopyWithPlaceholder()
          ? _value.discountAmount
          // ignore: cast_nullable_to_non_nullable
          : discountAmount as int,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<TransactionItemRequest>?,
      orderTypeId: orderTypeId == const $CopyWithPlaceholder()
          ? _value.orderTypeId
          // ignore: cast_nullable_to_non_nullable
          : orderTypeId as String,
      paidAmount: paidAmount == const $CopyWithPlaceholder()
          ? _value.paidAmount
          // ignore: cast_nullable_to_non_nullable
          : paidAmount as int,
      paymentMethod: paymentMethod == const $CopyWithPlaceholder()
          ? _value.paymentMethod
          // ignore: cast_nullable_to_non_nullable
          : paymentMethod as TransactionRequestPaymentMethodEnum,
      restaurantTableId: restaurantTableId == const $CopyWithPlaceholder()
          ? _value.restaurantTableId
          // ignore: cast_nullable_to_non_nullable
          : restaurantTableId as String?,
      roundingAmount: roundingAmount == const $CopyWithPlaceholder()
          ? _value.roundingAmount
          // ignore: cast_nullable_to_non_nullable
          : roundingAmount as int,
      subtotal: subtotal == const $CopyWithPlaceholder()
          ? _value.subtotal
          // ignore: cast_nullable_to_non_nullable
          : subtotal as int,
      taxAmount: taxAmount == const $CopyWithPlaceholder()
          ? _value.taxAmount
          // ignore: cast_nullable_to_non_nullable
          : taxAmount as int,
      taxPercentage: taxPercentage == const $CopyWithPlaceholder()
          ? _value.taxPercentage
          // ignore: cast_nullable_to_non_nullable
          : taxPercentage as double,
      tipAmount: tipAmount == const $CopyWithPlaceholder()
          ? _value.tipAmount
          // ignore: cast_nullable_to_non_nullable
          : tipAmount as int,
      totalAmount: totalAmount == const $CopyWithPlaceholder()
          ? _value.totalAmount
          // ignore: cast_nullable_to_non_nullable
          : totalAmount as int,
      walletId: walletId == const $CopyWithPlaceholder()
          ? _value.walletId
          // ignore: cast_nullable_to_non_nullable
          : walletId as String?,
    );
  }
}

extension $TransactionRequestCopyWith on TransactionRequest {
  /// Returns a callable class that can be used as follows: `instanceOfTransactionRequest.copyWith(...)` or like so:`instanceOfTransactionRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionRequestCWProxy get copyWith =>
      _$TransactionRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionRequest _$TransactionRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'TransactionRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'change_amount',
        'discount_amount',
        'items',
        'order_type_id',
        'paid_amount',
        'payment_method',
        'rounding_amount',
        'subtotal',
        'tax_amount',
        'tax_percentage',
        'tip_amount',
        'total_amount',
      ],
    );
    final val = TransactionRequest(
      changeAmount: $checkedConvert('change_amount', (v) => (v as num).toInt()),
      discountAmount: $checkedConvert(
        'discount_amount',
        (v) => (v as num).toInt(),
      ),
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) => TransactionItemRequest.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      orderTypeId: $checkedConvert('order_type_id', (v) => v as String),
      paidAmount: $checkedConvert('paid_amount', (v) => (v as num).toInt()),
      paymentMethod: $checkedConvert(
        'payment_method',
        (v) => $enumDecode(
          _$TransactionRequestPaymentMethodEnumEnumMap,
          v,
          unknownValue:
              TransactionRequestPaymentMethodEnum.unknownDefaultOpenApi,
        ),
      ),
      restaurantTableId: $checkedConvert(
        'restaurant_table_id',
        (v) => v as String?,
      ),
      roundingAmount: $checkedConvert(
        'rounding_amount',
        (v) => (v as num).toInt(),
      ),
      subtotal: $checkedConvert('subtotal', (v) => (v as num).toInt()),
      taxAmount: $checkedConvert('tax_amount', (v) => (v as num).toInt()),
      taxPercentage: $checkedConvert(
        'tax_percentage',
        (v) => (v as num).toDouble(),
      ),
      tipAmount: $checkedConvert('tip_amount', (v) => (v as num).toInt()),
      totalAmount: $checkedConvert('total_amount', (v) => (v as num).toInt()),
      walletId: $checkedConvert('wallet_id', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'changeAmount': 'change_amount',
    'discountAmount': 'discount_amount',
    'orderTypeId': 'order_type_id',
    'paidAmount': 'paid_amount',
    'paymentMethod': 'payment_method',
    'restaurantTableId': 'restaurant_table_id',
    'roundingAmount': 'rounding_amount',
    'taxAmount': 'tax_amount',
    'taxPercentage': 'tax_percentage',
    'tipAmount': 'tip_amount',
    'totalAmount': 'total_amount',
    'walletId': 'wallet_id',
  },
);

Map<String, dynamic> _$TransactionRequestToJson(TransactionRequest instance) =>
    <String, dynamic>{
      'change_amount': instance.changeAmount,
      'discount_amount': instance.discountAmount,
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'order_type_id': instance.orderTypeId,
      'paid_amount': instance.paidAmount,
      'payment_method':
          _$TransactionRequestPaymentMethodEnumEnumMap[instance.paymentMethod]!,
      'restaurant_table_id': ?instance.restaurantTableId,
      'rounding_amount': instance.roundingAmount,
      'subtotal': instance.subtotal,
      'tax_amount': instance.taxAmount,
      'tax_percentage': instance.taxPercentage,
      'tip_amount': instance.tipAmount,
      'total_amount': instance.totalAmount,
      'wallet_id': ?instance.walletId,
    };

const _$TransactionRequestPaymentMethodEnumEnumMap = {
  TransactionRequestPaymentMethodEnum.cash: 'cash',
  TransactionRequestPaymentMethodEnum.wallet: 'wallet',
  TransactionRequestPaymentMethodEnum.debitCard: 'debit_card',
  TransactionRequestPaymentMethodEnum.qris: 'qris',
  TransactionRequestPaymentMethodEnum.point: 'point',
  TransactionRequestPaymentMethodEnum.transfer: 'transfer',
  TransactionRequestPaymentMethodEnum.unknownDefaultOpenApi:
      'unknown_default_open_api',
};
