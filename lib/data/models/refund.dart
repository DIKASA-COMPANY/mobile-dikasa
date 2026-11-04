/// Original sale line with authoritative remaining-unit and stock-return limits.
class RefundLine {
  RefundLine.fromJson(Map<String, dynamic> j)
    : id = j['id'] as String,
      productId = j['product_id'] as String,
      name = j['product_name'] as String,
      variant = j['variant_name'] as String?,
      quantity = (j['quantity'] as num).toInt(),
      refunded = (j['refunded_quantity'] as num).toInt(),
      price = (j['unit_price'] as num).toInt(),
      restockBudget = (j['restock_budget'] as num).toInt(),
      tracked = j['track_stock'] as bool;
  final String id, productId, name;
  final String? variant;
  final int quantity, refunded, price, restockBudget;
  final bool tracked;
  int get remaining => quantity - refunded;
  String get label => variant == null ? name : '$name — $variant';
}

/// Read-only original receipt data, unaffected by current catalog prices.
class ReceiptRefundDetail {
  ReceiptRefundDetail.fromJson(Map<String, dynamic> j)
    : id = j['id'] as String,
      number = j['transaction_number'] as String,
      status = j['status'] as String,
      method = j['payment_method'] as String,
      revision = (j['refund_revision'] as num).toInt(),
      total = (j['total_amount'] as num).toInt(),
      refunded = (j['refunded_amount'] as num).toInt(),
      supported = j['refunds_supported'] as bool,
      items = (j['items'] as List)
          .map((i) => RefundLine.fromJson(Map<String, dynamic>.from(i as Map)))
          .toList();
  final String id, number, status, method;
  final int revision, total, refunded;
  final bool supported;
  final List<RefundLine> items;
  bool get canRefund => supported && items.any((i) => i.remaining > 0);
}

/// Server preview amounts and hash must be preserved unchanged for confirmation.
class RefundPreview {
  RefundPreview.fromJson(Map<String, dynamic> j)
    : hash = j['preview_hash'] as String,
      net = (j['net_amount'] as num).toInt(),
      tax = (j['tax_amount'] as num).toInt(),
      total = (j['total_amount'] as num).toInt();
  final String hash;
  final int net, tax, total;
}

/// Immutable confirmed refund record, suitable for lost-response recovery.
class RefundRecord {
  RefundRecord.fromJson(Map<String, dynamic> j)
    : id = j['id'] as String,
      transactionId = j['transaction_id'] as String,
      requestId = j['request_id'] as String,
      number = j['refund_number'] as String,
      reason = j['reason'] as String,
      actor = j['actor_name'] as String,
      method = j['method'] as String,
      date = j['created_at'] as String,
      total = (j['total_amount'] as num).toInt(),
      items = (j['items'] as List).cast<Map<String, dynamic>>() {
    if (id.isEmpty || number.isEmpty || total < 0) {
      throw const FormatException('Invalid refund');
    }
  }
  final String id,
      transactionId,
      requestId,
      number,
      reason,
      actor,
      method,
      date;
  final int total;
  final List<Map<String, dynamic>> items;
}

/// Paginated immutable refund audit history.
class RefundHistoryPage {
  RefundHistoryPage.fromJson(Map<String, dynamic> j)
    : items = (j['data'] as List)
          .map(
            (i) => RefundRecord.fromJson(Map<String, dynamic>.from(i as Map)),
          )
          .toList(),
      total = ((j['meta'] as Map)['total'] as num).toInt();
  final List<RefundRecord> items;
  final int total;
}
