import 'payment_snapshot.dart';

/// Server-backed outlet order type; IDs must come from the API, not enum ordinals.
class PosOrderType {
  const PosOrderType({
    required this.id,
    required this.code,
    required this.label,
  });
  final String id;
  final String code;
  final String label;
  factory PosOrderType.fromJson(Map<String, dynamic> json) => PosOrderType(
    id: json['id'] as String,
    code: json['code'] as String,
    label: json['name'] as String,
  );
}

class CashSession {
  const CashSession({required this.id, required this.openingCash});
  final String id;
  final int openingCash;
  factory CashSession.fromJson(Map<String, dynamic> json) => CashSession(
    id: json['id'] as String,
    openingCash: (json['opening_cash'] as num).toInt(),
  );
}

class PosOption {
  const PosOption({required this.id, required this.name});
  final String id;
  final String name;
  factory PosOption.fromJson(Map<String, dynamic> json) =>
      PosOption(id: json['id'] as String, name: json['name'] as String);
}

class PaymentReceipt {
  const PaymentReceipt({
    required this.id,
    required this.number,
    required this.total,
    this.snapshot,
  });
  final String id;
  final String number;
  final int total;
  final PaymentSnapshot? snapshot;
  PaymentReceipt withSnapshot(PaymentSnapshot value) =>
      PaymentReceipt(id: id, number: number, total: total, snapshot: value);
  factory PaymentReceipt.fromJson(Map<String, dynamic> json) => PaymentReceipt(
    id: json['id'] as String,
    number: json['transaction_number'] as String,
    total: (json['total_amount'] as num).toInt(),
  );
}

/// A server-paginated read model for history and customer browsing.
class PosPage {
  const PosPage({required this.items, required this.total, required this.page});
  final List<Map<String, dynamic>> items;
  final int total;
  final int page;
  factory PosPage.fromJson(Map<String, dynamic> json) => PosPage(
    items: (json['data'] as List).cast<Map<String, dynamic>>(),
    total: ((json['meta'] as Map<String, dynamic>)['total'] as num).toInt(),
    page: ((json['meta'] as Map<String, dynamic>)['page'] as num).toInt(),
  );
}

/// A payment request may have committed when its response was lost or malformed.
class PaymentUncertainException implements Exception {
  const PaymentUncertainException();
}
