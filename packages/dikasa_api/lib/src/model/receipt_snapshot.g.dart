// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_snapshot.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReceiptSnapshotCWProxy {
  ReceiptSnapshot discountAmount(int discountAmount);

  ReceiptSnapshot id(String id);

  ReceiptSnapshot items(List<ReceiptItem>? items);

  ReceiptSnapshot paymentMethod(String paymentMethod);

  ReceiptSnapshot refundRevision(int refundRevision);

  ReceiptSnapshot refundedAmount(int refundedAmount);

  ReceiptSnapshot refundsSupported(bool refundsSupported);

  ReceiptSnapshot status(String status);

  ReceiptSnapshot subtotal(int subtotal);

  ReceiptSnapshot taxAmount(int taxAmount);

  ReceiptSnapshot totalAmount(int totalAmount);

  ReceiptSnapshot transactionNumber(String transactionNumber);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReceiptSnapshot(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReceiptSnapshot(...).copyWith(id: 12, name: "My name")
  /// ````
  ReceiptSnapshot call({
    int discountAmount,
    String id,
    List<ReceiptItem>? items,
    String paymentMethod,
    int refundRevision,
    int refundedAmount,
    bool refundsSupported,
    String status,
    int subtotal,
    int taxAmount,
    int totalAmount,
    String transactionNumber,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReceiptSnapshot.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReceiptSnapshot.copyWith.fieldName(...)`
class _$ReceiptSnapshotCWProxyImpl implements _$ReceiptSnapshotCWProxy {
  const _$ReceiptSnapshotCWProxyImpl(this._value);

  final ReceiptSnapshot _value;

  @override
  ReceiptSnapshot discountAmount(int discountAmount) =>
      this(discountAmount: discountAmount);

  @override
  ReceiptSnapshot id(String id) => this(id: id);

  @override
  ReceiptSnapshot items(List<ReceiptItem>? items) => this(items: items);

  @override
  ReceiptSnapshot paymentMethod(String paymentMethod) =>
      this(paymentMethod: paymentMethod);

  @override
  ReceiptSnapshot refundRevision(int refundRevision) =>
      this(refundRevision: refundRevision);

  @override
  ReceiptSnapshot refundedAmount(int refundedAmount) =>
      this(refundedAmount: refundedAmount);

  @override
  ReceiptSnapshot refundsSupported(bool refundsSupported) =>
      this(refundsSupported: refundsSupported);

  @override
  ReceiptSnapshot status(String status) => this(status: status);

  @override
  ReceiptSnapshot subtotal(int subtotal) => this(subtotal: subtotal);

  @override
  ReceiptSnapshot taxAmount(int taxAmount) => this(taxAmount: taxAmount);

  @override
  ReceiptSnapshot totalAmount(int totalAmount) =>
      this(totalAmount: totalAmount);

  @override
  ReceiptSnapshot transactionNumber(String transactionNumber) =>
      this(transactionNumber: transactionNumber);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReceiptSnapshot(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReceiptSnapshot(...).copyWith(id: 12, name: "My name")
  /// ````
  ReceiptSnapshot call({
    Object? discountAmount = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? paymentMethod = const $CopyWithPlaceholder(),
    Object? refundRevision = const $CopyWithPlaceholder(),
    Object? refundedAmount = const $CopyWithPlaceholder(),
    Object? refundsSupported = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? subtotal = const $CopyWithPlaceholder(),
    Object? taxAmount = const $CopyWithPlaceholder(),
    Object? totalAmount = const $CopyWithPlaceholder(),
    Object? transactionNumber = const $CopyWithPlaceholder(),
  }) {
    return ReceiptSnapshot(
      discountAmount: discountAmount == const $CopyWithPlaceholder()
          ? _value.discountAmount
          // ignore: cast_nullable_to_non_nullable
          : discountAmount as int,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<ReceiptItem>?,
      paymentMethod: paymentMethod == const $CopyWithPlaceholder()
          ? _value.paymentMethod
          // ignore: cast_nullable_to_non_nullable
          : paymentMethod as String,
      refundRevision: refundRevision == const $CopyWithPlaceholder()
          ? _value.refundRevision
          // ignore: cast_nullable_to_non_nullable
          : refundRevision as int,
      refundedAmount: refundedAmount == const $CopyWithPlaceholder()
          ? _value.refundedAmount
          // ignore: cast_nullable_to_non_nullable
          : refundedAmount as int,
      refundsSupported: refundsSupported == const $CopyWithPlaceholder()
          ? _value.refundsSupported
          // ignore: cast_nullable_to_non_nullable
          : refundsSupported as bool,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String,
      subtotal: subtotal == const $CopyWithPlaceholder()
          ? _value.subtotal
          // ignore: cast_nullable_to_non_nullable
          : subtotal as int,
      taxAmount: taxAmount == const $CopyWithPlaceholder()
          ? _value.taxAmount
          // ignore: cast_nullable_to_non_nullable
          : taxAmount as int,
      totalAmount: totalAmount == const $CopyWithPlaceholder()
          ? _value.totalAmount
          // ignore: cast_nullable_to_non_nullable
          : totalAmount as int,
      transactionNumber: transactionNumber == const $CopyWithPlaceholder()
          ? _value.transactionNumber
          // ignore: cast_nullable_to_non_nullable
          : transactionNumber as String,
    );
  }
}

extension $ReceiptSnapshotCopyWith on ReceiptSnapshot {
  /// Returns a callable class that can be used as follows: `instanceOfReceiptSnapshot.copyWith(...)` or like so:`instanceOfReceiptSnapshot.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReceiptSnapshotCWProxy get copyWith => _$ReceiptSnapshotCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptSnapshot _$ReceiptSnapshotFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'ReceiptSnapshot',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'discount_amount',
        'id',
        'items',
        'payment_method',
        'refund_revision',
        'refunded_amount',
        'refunds_supported',
        'status',
        'subtotal',
        'tax_amount',
        'total_amount',
        'transaction_number',
      ],
    );
    final val = ReceiptSnapshot(
      discountAmount: $checkedConvert(
        'discount_amount',
        (v) => (v as num).toInt(),
      ),
      id: $checkedConvert('id', (v) => v as String),
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>?)
            ?.map((e) => ReceiptItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      paymentMethod: $checkedConvert('payment_method', (v) => v as String),
      refundRevision: $checkedConvert(
        'refund_revision',
        (v) => (v as num).toInt(),
      ),
      refundedAmount: $checkedConvert(
        'refunded_amount',
        (v) => (v as num).toInt(),
      ),
      refundsSupported: $checkedConvert('refunds_supported', (v) => v as bool),
      status: $checkedConvert('status', (v) => v as String),
      subtotal: $checkedConvert('subtotal', (v) => (v as num).toInt()),
      taxAmount: $checkedConvert('tax_amount', (v) => (v as num).toInt()),
      totalAmount: $checkedConvert('total_amount', (v) => (v as num).toInt()),
      transactionNumber: $checkedConvert(
        'transaction_number',
        (v) => v as String,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'discountAmount': 'discount_amount',
    'paymentMethod': 'payment_method',
    'refundRevision': 'refund_revision',
    'refundedAmount': 'refunded_amount',
    'refundsSupported': 'refunds_supported',
    'taxAmount': 'tax_amount',
    'totalAmount': 'total_amount',
    'transactionNumber': 'transaction_number',
  },
);

Map<String, dynamic> _$ReceiptSnapshotToJson(ReceiptSnapshot instance) =>
    <String, dynamic>{
      'discount_amount': instance.discountAmount,
      'id': instance.id,
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'payment_method': instance.paymentMethod,
      'refund_revision': instance.refundRevision,
      'refunded_amount': instance.refundedAmount,
      'refunds_supported': instance.refundsSupported,
      'status': instance.status,
      'subtotal': instance.subtotal,
      'tax_amount': instance.taxAmount,
      'total_amount': instance.totalAmount,
      'transaction_number': instance.transactionNumber,
    };
