/// Typed report contracts: whole Rupiah, explicit WIB dates and nullable averages.
enum ReportKind { summary, methods, products, categories }

extension ReportKindLabel on ReportKind {
  String get label => switch (this) {
    ReportKind.summary => 'Ringkasan Penjualan',
    ReportKind.methods => 'Metode Pembayaran',
    ReportKind.products => 'Penjualan Per Produk',
    ReportKind.categories => 'Penjualan Per Kategori',
  };
  bool get grouped =>
      this == ReportKind.products || this == ReportKind.categories;
}

int reportNumber(dynamic v) {
  if (v is! num ||
      !v.isFinite ||
      v != v.roundToDouble() ||
      v.abs() > 9007199254740991) {
    throw const FormatException('Invalid report integer');
  }
  return v.toInt();
}

String reportDate(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
DateTime reportWib(DateTime d) => d.toUtc().add(const Duration(hours: 7));

class ReportFilter {
  const ReportFilter({
    required this.startDate,
    required this.endDate,
    this.query = '',
    this.sort = 'quantity_desc',
    this.page = 1,
  });
  final String startDate, endDate, query, sort;
  final int page;
  ReportFilter copyWith({
    String? startDate,
    String? endDate,
    String? query,
    String? sort,
    int? page,
  }) => ReportFilter(
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    query: query ?? this.query,
    sort: sort ?? this.sort,
    page: page ?? this.page,
  );
  Map<String, dynamic> parameters(ReportKind kind, {bool exporting = false}) =>
      {
        'start_date': startDate,
        'end_date': endDate,
        if (kind.grouped) 'query': query,
        if (kind.grouped) 'sort': sort,
        if (!exporting) 'page': page,
        if (!exporting) 'page_size': 20,
      };
}

class ReportTotals {
  ReportTotals.fromJson(this.json) {
    for (final key in [
      'gross_sales',
      'refund_amount',
      'net_sales',
      'charged_sales',
      'sale_count',
      'refund_count',
      'sold_quantity',
      'returned_quantity',
      'net_quantity',
      'sale_tax',
      'net_tax',
      'value_after_refunds',
      'excluded_receipts',
      'unknown_category_quantity',
    ]) {
      reportNumber(json[key]);
    }
    if (json['average_transaction'] != null) {
      reportNumber(json['average_transaction']);
    }
  }
  final Map<String, dynamic> json;
  int n(String k) => reportNumber(json[k]);
  int get grossSales => n('gross_sales');
  int get refundAmount => n('refund_amount');
  int get netSales => n('net_sales');
  int get saleCount => n('sale_count');
  int get soldQuantity => n('sold_quantity');
  int? get average => json['average_transaction'] == null
      ? null
      : reportNumber(json['average_transaction']);
}

class DailyReportPoint {
  DailyReportPoint.fromJson(Map<String, dynamic> j)
    : date = j['date'] as String,
      count = reportNumber(j['sale_count']),
      charged = reportNumber(j['charged_sales']),
      refunds = reportNumber(j['refund_amount']),
      net = reportNumber(j['net_sales']);
  final String date;
  final int count, charged, refunds, net;
}

class PaymentMethodReportRow {
  PaymentMethodReportRow.fromJson(this.json) {
    for (final k in [
      'sale_count',
      'sales_amount',
      'refund_count',
      'refund_amount',
      'net_amount',
    ]) {
      reportNumber(json[k]);
    }
  }
  final Map<String, dynamic> json;
  String get method => json['method'] as String;
  int n(String k) => reportNumber(json[k]);
}

class SalesGroupReportRow {
  SalesGroupReportRow.fromJson(this.json)
    : totals = ReportTotals.fromJson(json);
  final Map<String, dynamic> json;
  final ReportTotals totals;
  String get name => json['name'] as String;
  String get category => json['category_name'] as String? ?? '';
  int? get minPrice => json['unit_price_min'] == null
      ? null
      : reportNumber(json['unit_price_min']);
  int? get maxPrice => json['unit_price_max'] == null
      ? null
      : reportNumber(json['unit_price_max']);
}

class ReportMeta {
  ReportMeta.fromJson(Map<String, dynamic> j)
    : start = j['start_date'] as String,
      end = j['end_date'] as String,
      timezone = j['timezone'] as String,
      generatedAt = DateTime.parse(j['generated_at'] as String),
      page = reportNumber(j['page']),
      total = reportNumber(j['total']);
  final String start, end, timezone;
  final DateTime generatedAt;
  final int page, total;
}

class ReportData {
  ReportData.fromJson(Map<String, dynamic> j)
    : this._(
        j['data'] as Map<String, dynamic>,
        j['meta'] as Map<String, dynamic>,
      );
  ReportData._(Map<String, dynamic> d, Map<String, dynamic> m)
    : kind = ReportKind.values.byName(d['kind'] as String),
      totals = ReportTotals.fromJson(d['totals'] as Map<String, dynamic>),
      daily = (d['daily'] as List)
          .map(
            (i) =>
                DailyReportPoint.fromJson(Map<String, dynamic>.from(i as Map)),
          )
          .toList(),
      methods = (d['methods'] as List)
          .map(
            (i) => PaymentMethodReportRow.fromJson(
              Map<String, dynamic>.from(i as Map),
            ),
          )
          .toList(),
      rows = (d['rows'] as List)
          .map(
            (i) => SalesGroupReportRow.fromJson(
              Map<String, dynamic>.from(i as Map),
            ),
          )
          .toList(),
      meta = ReportMeta.fromJson(m);
  final ReportKind kind;
  final ReportTotals totals;
  final List<DailyReportPoint> daily;
  final List<PaymentMethodReportRow> methods;
  final List<SalesGroupReportRow> rows;
  final ReportMeta meta;
}
