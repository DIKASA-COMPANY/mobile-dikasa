import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/table/main.dart';
import 'package:mobile_dikasa/data/models/sales_report.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';
import 'report_header.dart';

String reportMoney(int n) => formatRupiah(n, prefix: 'Rp ');
String methodLabel(String s) => switch (s) {
  'cash' => 'Tunai',
  'wallet' => 'Dompet digital',
  'debit_card' => 'Kartu debit',
  'qris' => 'QRIS',
  'transfer' => 'Transfer',
  'point' => 'Poin',
  _ => s,
};

class ReportTables extends StatelessWidget {
  const ReportTables({super.key, required this.report});
  final ReportData report;
  @override
  Widget build(BuildContext context) {
    if (report.kind == ReportKind.methods) {
      final rows = [
        ...report.methods.map((m) => m.json),
        {
          'method': 'Total',
          'sale_count': report.totals.saleCount,
          'sales_amount': report.totals.n('charged_sales'),
          'refund_count': report.totals.n('refund_count'),
          'refund_amount': report.totals.refundAmount,
          'net_amount': report.totals.n('value_after_refunds'),
        },
      ];
      return _table<Map<String, dynamic>>([
        TableFieldColumn(
          title: 'Metode Pembayaran',
          width: 170.w,
          valueBuilder: (m) => methodLabel(m['method'] as String),
        ),
        for (final c in [
          ('Transaksi', 'sale_count', 80.0, false),
          ('Penjualan Dibayar', 'sales_amount', 160.0, true),
          ('Refund', 'refund_amount', 150.0, true),
          ('Setelah Refund', 'net_amount', 160.0, true),
        ])
          TableFieldColumn(
            title: c.$1,
            width: c.$3,
            valueBuilder: (m) =>
                c.$4 ? reportMoney(reportNumber(m[c.$2])) : m[c.$2].toString(),
          ),
      ], rows);
    }
    return _table<SalesGroupReportRow>([
      TableFieldColumn(
        title: report.kind == ReportKind.products
            ? 'Produk / Variasi'
            : 'Kategori',
        width: 190.w,
        valueBuilder: (r) => r.name,
      ),
      if (report.kind == ReportKind.products) ...[
        TableFieldColumn(
          title: 'Kategori historis',
          width: 165.w,
          valueBuilder: (r) =>
              r.category.isEmpty ? 'Tidak tercatat' : r.category,
        ),
        TableFieldColumn(
          title: 'Harga saat terjual',
          width: 160.w,
          valueBuilder: (r) => r.minPrice == null
              ? '—'
              : r.minPrice == r.maxPrice
              ? reportMoney(r.minPrice!)
              : '${reportMoney(r.minPrice!)}–${reportMoney(r.maxPrice!)}',
        ),
      ],
      for (final c in [
        ('Terjual', 'sold_quantity', 80.0, false),
        ('Direfund', 'returned_quantity', 90.0, false),
        ('Unit Bersih', 'net_quantity', 100.0, false),
        ('Penjualan Kotor', 'gross_sales', 150.0, true),
        ('Refund', 'refund_amount', 150.0, true),
        ('Penjualan Bersih', 'net_sales', 170.0, true),
        ('Pajak Bersih', 'net_tax', 150.0, true),
      ])
        TableFieldColumn(
          title: c.$1,
          width: c.$3,
          valueBuilder: (r) => c.$4
              ? reportMoney(r.totals.n(c.$2))
              : r.totals.n(c.$2).toString(),
        ),
    ], report.rows);
  }

  Widget _table<T>(List<TableFieldColumn<T>> columns, List<T> rows) =>
      TableField<T>(
        columns: columns,
        rows: rows,
        emptyText: 'Tidak ada aktivitas pada periode ini.',
        headerBackgroundColor: reportBlue,
        rowBackgroundColor: const Color(0xfff4f4f4),
        headingRowHeight: 73,
        rowHeight: 73,
        borderRadius: 10,
        headerTextStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        cellTextStyle: TextStyle(fontSize: 13.sp, color: Color(0xff656565)),
      );
}
