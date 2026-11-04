/// Local presentation of the exact request that received a confirmed receipt.
/// Never reconstructed from a cleared cart or a subsequently changed catalog.
class PaymentSnapshot {
  PaymentSnapshot.fromPayload(
    Map<String, dynamic> p, {
    required this.orderTypeLabel,
  }) : items = List.unmodifiable(
         (p['items'] as List).map(
           (j) => PaymentSnapshotLine(Map<String, dynamic>.from(j as Map)),
         ),
       ),
       subtotal = (p['subtotal'] as num).toInt(),
       taxPercentage = (p['tax_percentage'] as num).toDouble(),
       tax = (p['tax_amount'] as num).toInt(),
       total = (p['total_amount'] as num).toInt(),
       paid = (p['paid_amount'] as num).toInt(),
       change = (p['change_amount'] as num).toInt(),
       rounding = (p['rounding_amount'] as num).toInt(),
       tips = (p['tip_amount'] as num).toInt(),
       method = p['payment_method'] as String;
  final List<PaymentSnapshotLine> items;
  final String orderTypeLabel, method;
  final int subtotal, tax, total, paid, change, rounding, tips;
  final double taxPercentage;
  int get quantity => items.fold(0, (sum, i) => sum + i.quantity);
}

class PaymentSnapshotLine {
  PaymentSnapshotLine(Map<String, dynamic> j)
    : name = j['product_name'] as String,
      variant = j['variant_name'] as String?,
      note = j['notes'] as String? ?? '',
      quantity = (j['quantity'] as num).toInt(),
      price = (j['unit_price'] as num).toInt(),
      total = (j['line_total'] as num).toInt();
  final String name, note;
  final String? variant;
  final int quantity, price, total;
  String get label => variant == null ? name : '$name — $variant';
}
