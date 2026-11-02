// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PreviewCWProxy {
  Preview items(List<RefundItem>? items);

  Preview netAmount(int netAmount);

  Preview previewHash(String previewHash);

  Preview refundRevision(int refundRevision);

  Preview resultStatus(String resultStatus);

  Preview taxAmount(int taxAmount);

  Preview totalAmount(int totalAmount);

  Preview transactionId(String transactionId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Preview(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Preview(...).copyWith(id: 12, name: "My name")
  /// ````
  Preview call({
    List<RefundItem>? items,
    int netAmount,
    String previewHash,
    int refundRevision,
    String resultStatus,
    int taxAmount,
    int totalAmount,
    String transactionId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPreview.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPreview.copyWith.fieldName(...)`
class _$PreviewCWProxyImpl implements _$PreviewCWProxy {
  const _$PreviewCWProxyImpl(this._value);

  final Preview _value;

  @override
  Preview items(List<RefundItem>? items) => this(items: items);

  @override
  Preview netAmount(int netAmount) => this(netAmount: netAmount);

  @override
  Preview previewHash(String previewHash) => this(previewHash: previewHash);

  @override
  Preview refundRevision(int refundRevision) =>
      this(refundRevision: refundRevision);

  @override
  Preview resultStatus(String resultStatus) => this(resultStatus: resultStatus);

  @override
  Preview taxAmount(int taxAmount) => this(taxAmount: taxAmount);

  @override
  Preview totalAmount(int totalAmount) => this(totalAmount: totalAmount);

  @override
  Preview transactionId(String transactionId) =>
      this(transactionId: transactionId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Preview(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Preview(...).copyWith(id: 12, name: "My name")
  /// ````
  Preview call({
    Object? items = const $CopyWithPlaceholder(),
    Object? netAmount = const $CopyWithPlaceholder(),
    Object? previewHash = const $CopyWithPlaceholder(),
    Object? refundRevision = const $CopyWithPlaceholder(),
    Object? resultStatus = const $CopyWithPlaceholder(),
    Object? taxAmount = const $CopyWithPlaceholder(),
    Object? totalAmount = const $CopyWithPlaceholder(),
    Object? transactionId = const $CopyWithPlaceholder(),
  }) {
    return Preview(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<RefundItem>?,
      netAmount: netAmount == const $CopyWithPlaceholder()
          ? _value.netAmount
          // ignore: cast_nullable_to_non_nullable
          : netAmount as int,
      previewHash: previewHash == const $CopyWithPlaceholder()
          ? _value.previewHash
          // ignore: cast_nullable_to_non_nullable
          : previewHash as String,
      refundRevision: refundRevision == const $CopyWithPlaceholder()
          ? _value.refundRevision
          // ignore: cast_nullable_to_non_nullable
          : refundRevision as int,
      resultStatus: resultStatus == const $CopyWithPlaceholder()
          ? _value.resultStatus
          // ignore: cast_nullable_to_non_nullable
          : resultStatus as String,
      taxAmount: taxAmount == const $CopyWithPlaceholder()
          ? _value.taxAmount
          // ignore: cast_nullable_to_non_nullable
          : taxAmount as int,
      totalAmount: totalAmount == const $CopyWithPlaceholder()
          ? _value.totalAmount
          // ignore: cast_nullable_to_non_nullable
          : totalAmount as int,
      transactionId: transactionId == const $CopyWithPlaceholder()
          ? _value.transactionId
          // ignore: cast_nullable_to_non_nullable
          : transactionId as String,
    );
  }
}

extension $PreviewCopyWith on Preview {
  /// Returns a callable class that can be used as follows: `instanceOfPreview.copyWith(...)` or like so:`instanceOfPreview.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PreviewCWProxy get copyWith => _$PreviewCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preview _$PreviewFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Preview',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'items',
        'net_amount',
        'preview_hash',
        'refund_revision',
        'result_status',
        'tax_amount',
        'total_amount',
        'transaction_id',
      ],
    );
    final val = Preview(
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>?)
            ?.map((e) => RefundItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      netAmount: $checkedConvert('net_amount', (v) => (v as num).toInt()),
      previewHash: $checkedConvert('preview_hash', (v) => v as String),
      refundRevision: $checkedConvert(
        'refund_revision',
        (v) => (v as num).toInt(),
      ),
      resultStatus: $checkedConvert('result_status', (v) => v as String),
      taxAmount: $checkedConvert('tax_amount', (v) => (v as num).toInt()),
      totalAmount: $checkedConvert('total_amount', (v) => (v as num).toInt()),
      transactionId: $checkedConvert('transaction_id', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'netAmount': 'net_amount',
    'previewHash': 'preview_hash',
    'refundRevision': 'refund_revision',
    'resultStatus': 'result_status',
    'taxAmount': 'tax_amount',
    'totalAmount': 'total_amount',
    'transactionId': 'transaction_id',
  },
);

Map<String, dynamic> _$PreviewToJson(Preview instance) => <String, dynamic>{
  'items': instance.items?.map((e) => e.toJson()).toList(),
  'net_amount': instance.netAmount,
  'preview_hash': instance.previewHash,
  'refund_revision': instance.refundRevision,
  'result_status': instance.resultStatus,
  'tax_amount': instance.taxAmount,
  'total_amount': instance.totalAmount,
  'transaction_id': instance.transactionId,
};
