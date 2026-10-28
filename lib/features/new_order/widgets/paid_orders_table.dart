import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';
import 'package:mobile_dikasa/data/models/pos.dart';
import 'browser_design.dart';

class PaidOrdersTable extends StatelessWidget {
  const PaidOrdersTable({
    super.key,
    required this.page,
    required this.actionsBlocked,
    required this.onDetail,
  });
  final PosPage page;
  final bool actionsBlocked;
  final ValueChanged<String> onDetail;
  String money(dynamic n) =>
      n is num ? formatRupiah(n.toInt(), prefix: 'Rp ') : '—';
  @override
  Widget build(BuildContext c) => BrowserTable(
    headers: const [
      'No Nota',
      'Nama Pelanggan',
      'Tanggal Order',
      'Jenis Order',
      'Jumlah',
      'Tagihan',
      '',
    ],
    fractions: const [.1715, .18, .1843, .1627, .1026, .132, .0669],
    fontSize: 18.sp,
    leftPadding: const [37, 22, 22, 22, 22, 22, 6],
    rows: page.items.map((i) {
      final status = i['status']?.toString() ?? '';
      final statusLabel = {
        'partially_refunded': 'Refund sebagian',
        'refunded': 'Dikembalikan',
        'cancelled': 'Dibatalkan',
      }[status];
      final type = i['order_type'] is Map
          ? i['order_type']['name'] ?? '—'
          : '—';
      final table = i['restaurant_table'] is Map
          ? i['restaurant_table']['name']
          : null;
      return <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${i['receipt_number'] ?? '—'}'),
            if (statusLabel != null)
              Text(
                statusLabel,
                style: TextStyle(fontSize: 12.sp, color: Color(0xff9d1414)),
              ),
          ],
        ),
        Text(
          (i['customer_name']?.toString().isNotEmpty ?? false)
              ? i['customer_name'].toString()
              : 'Tanpa pelanggan',
        ),
        Text(browserDate(i['ordered_at'])),
        Text('$type${table == null ? '' : ' [$table]'}'),
        Text(
          i['total_quantity'] == null ? '—' : '${i['total_quantity']} Produk',
        ),
        Tooltip(
          message:
              'Total asli: ${money(i['total_amount'])}\nRefund: ${money(i['refunded_amount'])}\nNeto: ${money(i['net_after_refund'])}',
          child: Text(money(i['total_amount'])),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: 30.w, minHeight: 40.h),
          tooltip: 'Detail transaksi',
          onPressed: actionsBlocked ? null : () => onDetail(i['id'] as String),
          icon: const BrowserDesignIcon('edit'),
        ),
      ];
    }).toList(),
  );
}
