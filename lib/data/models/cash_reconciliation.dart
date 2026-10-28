/// Checked whole-Rupiah JSON values shared by open and frozen summaries.
int cashNumber(dynamic n) {
  if (n is! num ||
      !n.isFinite ||
      n != n.roundToDouble() ||
      n.abs() > 9007199254740991) {
    throw const FormatException('Invalid cash amount');
  }
  return n.toInt();
}

class CashSummary {
  CashSummary.fromJson(this.json) {
    cashNumber(json['expected_cash']);
  }
  final Map<String, dynamic> json;
  String get sessionId => json['session_id'] as String;
  String get opener => json['opening_user_name'] as String;
  String get openedAt => json['opened_at'] as String;
  int get opening => cashNumber(json['opening_cash']);
  int get sales => cashNumber(json['cash_sales']);
  int get refunds => cashNumber(json['cash_refunds']);
  int get cashIn =>
      json.containsKey('cash_in') ? cashNumber(json['cash_in']) : 0;
  int get cashOut =>
      json.containsKey('cash_out') ? cashNumber(json['cash_out']) : 0;
  int get movementCount => json.containsKey('movement_count')
      ? cashNumber(json['movement_count'])
      : 0;
  int get expected => cashNumber(json['expected_cash']);
  int get saleCount => cashNumber(json['sale_count']);
  int get refundCount => cashNumber(json['refund_count']);
  List<Map<String, dynamic>> get methods =>
      (json['methods'] as List).cast<Map<String, dynamic>>();
}

class CashClosePreview {
  CashClosePreview.fromJson(this.json)
    : summary = CashSummary.fromJson(
        Map<String, dynamic>.from(json['summary'] as Map),
      ) {
    cashNumber(json['counted_cash']);
    cashNumber(json['difference']);
    if ((json['preview_hash'] as String).isEmpty) {
      throw const FormatException('Missing preview');
    }
  }
  final Map<String, dynamic> json;
  final CashSummary summary;
  String get hash => json['preview_hash'] as String;
  String get reason => json['reason'] as String;
  int get counted => cashNumber(json['counted_cash']);
  int get difference => cashNumber(json['difference']);
}

class CashClosedRecord extends CashClosePreview {
  CashClosedRecord.fromJson(super.json) : super.fromJson() {
    if (sessionId.isEmpty ||
        requestId.isEmpty ||
        closer.isEmpty ||
        closedAt.isEmpty) {
      throw const FormatException('Incomplete closure');
    }
  }
  String get sessionId => json['session_id'] as String;
  String get requestId => json['close_request_id'] as String;
  String get closer => json['closed_by_name'] as String;
  String get closedAt => json['closed_at'] as String;
}

class CashSessionRecord {
  CashSessionRecord.fromJson(this.json)
    : summary = json['summary'] == null
          ? null
          : CashSummary.fromJson(
              Map<String, dynamic>.from(json['summary'] as Map),
            ),
      closing = json['closing'] == null
          ? null
          : CashClosedRecord.fromJson(
              Map<String, dynamic>.from(json['closing'] as Map),
            );
  final Map<String, dynamic> json;
  final CashSummary? summary;
  final CashClosedRecord? closing;
  String get id => json['id'] as String;
  String get status => json['status'] as String;
  String get opener => json['opening_user_name'] as String? ?? '';
  String get openedAt => json['opened_at'] as String? ?? '';
  int get opening => cashNumber(json['opening_cash']);
  bool get canClose => json['can_close'] == true;
  String get unsupportedReason =>
      json['unsupported_reason'] as String? ??
      'Rekonsiliasi historis tidak tersedia.';
}

class CashSessionPage {
  CashSessionPage.fromJson(Map<String, dynamic> j)
    : items = (j['data'] as List)
          .map(
            (i) =>
                CashSessionRecord.fromJson(Map<String, dynamic>.from(i as Map)),
          )
          .toList(),
      total = cashNumber((j['meta'] as Map)['total']);
  final List<CashSessionRecord> items;
  final int total;
}
