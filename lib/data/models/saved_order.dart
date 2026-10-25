import 'package:mobile_dikasa/core/network/api_exception.dart';

/// A bounded unpaid line; prices are snapshots until reviewed against the catalog.
class SavedOrderItem {
  const SavedOrderItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.variantId,
    this.variantName,
    this.notes = '',
  });
  final String productId, name, notes;
  final String? variantId, variantName;
  final int price, quantity;
  factory SavedOrderItem.fromJson(Map<String, dynamic> j) => SavedOrderItem(
    productId: j['product_id'] as String,
    name: j['product_name'] as String,
    price: (j['unit_price'] as num).toInt(),
    quantity: (j['quantity'] as num).toInt(),
    variantId: j['product_variant_id'] as String?,
    variantName: j['variant_name'] as String?,
    notes: j['notes'] as String? ?? '',
  );
}

/// Persistent draft state, including the receipt reference used after lost replies.
class SavedOrder {
  const SavedOrder({
    required this.id,
    required this.label,
    required this.orderTypeId,
    required this.revision,
    required this.status,
    required this.items,
    required this.subtotal,
    required this.quantity,
    required this.creator,
    required this.updatedAt,
    this.transactionId,
  });
  final String id, label, orderTypeId, status, creator, updatedAt;
  final String? transactionId;
  final int revision, subtotal, quantity;
  final List<SavedOrderItem> items;
  factory SavedOrder.fromJson(Map<String, dynamic> j) {
    final d = SavedOrder(
      id: j['id'] as String,
      label: j['label'] as String,
      orderTypeId: j['order_type_id'] as String,
      revision: (j['revision'] as num).toInt(),
      status: j['status'] as String,
      items: (j['items'] as List)
          .map(
            (i) => SavedOrderItem.fromJson(Map<String, dynamic>.from(i as Map)),
          )
          .toList(),
      subtotal: (j['estimated_subtotal'] as num).toInt(),
      quantity: (j['total_quantity'] as num).toInt(),
      creator: j['creator_name'] as String? ?? '',
      updatedAt: j['updated_at'] as String,
      transactionId: j['transaction_id'] as String?,
    );
    if (d.id.isEmpty ||
        d.revision < 1 ||
        !['open', 'paid', 'deleted'].contains(d.status)) {
      throw const FormatException('Invalid saved order');
    }
    return d;
  }
}

/// Paginated outlet drafts use the same meta envelope as paid history.
class SavedOrderPage {
  const SavedOrderPage(this.items, this.total, this.page);
  final List<SavedOrder> items;
  final int total, page;
  factory SavedOrderPage.fromJson(Map<String, dynamic> j) => SavedOrderPage(
    (j['data'] as List)
        .map((i) => SavedOrder.fromJson(Map<String, dynamic>.from(i as Map)))
        .toList(),
    ((j['meta'] as Map)['total'] as num).toInt(),
    ((j['meta'] as Map)['page'] as num).toInt(),
  );
}

/// An unconfirmed mutation must retain its UUID and body for an identical retry.
class SavedCommandUncertainException implements Exception {
  const SavedCommandUncertainException();
}

/// Stable server codes distinguish stale drafts and already completed orders.
class SavedOrderApiException extends ApiException {
  const SavedOrderApiException({
    required super.type,
    required super.message,
    this.code,
  });
  final String? code;
}
