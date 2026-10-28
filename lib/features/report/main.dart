import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_loading_indicator.dart';
import 'package:mobile_dikasa/data/models/user.dart';
import 'package:mobile_dikasa/data/models/sales_report.dart';
import 'view_model.dart';
import 'widgets/report_header.dart';
import 'widgets/report_selector.dart';
import 'widgets/summary_chart.dart';
import 'widgets/report_tables.dart';

/// Four Figma report views sharing one filter and the existing authenticated client.
class SalesReportsView extends StatefulWidget {
  const SalesReportsView({
    super.key,
    required this.viewModel,
    this.user,
    this.onLock,
    this.onCashDrawer,
    this.initialKind = ReportKind.summary,
    this.initialFilter,
  });
  final ReportViewModel viewModel;
  final User? user;
  final VoidCallback? onLock;
  final VoidCallback? onCashDrawer;
  final ReportKind initialKind;
  final ReportFilter? initialFilter;
  @override
  State<SalesReportsView> createState() => _ReportState();
}

class _ReportState extends State<SalesReportsView> {
  late final ReportViewModel vm;
  @override
  void initState() {
    super.initState();
    vm = widget.viewModel;
    vm.kind = widget.initialKind;
    if (widget.initialFilter != null) vm.filter = widget.initialFilter!;
    vm.reload();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  Future<void> _date() async {
    final selected = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100, 12, 31),
      initialDateRange: DateTimeRange(
        start: DateTime.parse(vm.filter.startDate),
        end: DateTime.parse(vm.filter.endDate),
      ),
      helpText: 'Periode laporan (WIB, maksimal366 hari)',
    );
    if (!mounted || !vm.current || selected == null) return;
    await vm.setDateRange(selected.start, selected.end);
  }

  Future<void> _export() async {
    final ok = await vm.export();
    if (!mounted || !vm.current) return;
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Workbook laporan disimpan.')),
      );
    }
  }

  Widget _dateButton() => OutlinedButton(
    onPressed: _date,
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xff9b9b9b),
      minimumSize: const Size(270, 46),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ReportIcon('calendar'),
        SizedBox(width: 18.w),
        Text(
          '${vm.filter.startDate} – ${vm.filter.endDate}',
          style: TextStyle(fontSize: 15.sp, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
  Widget _strip() => Container(
    width: double.infinity,
    color: reportDark,
    padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 20.h),
    constraints: BoxConstraints(minHeight: 88.h),
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 22,
      runSpacing: 12,
      children: [
        IconButton(
          onPressed: () => Navigator.maybePop(context),
          tooltip: 'Kembali',
          icon: const ReportIcon('back'),
        ),
        if (vm.kind.grouped)
          SizedBox(
            width: 250.w,
            height: 46.h,
            child: TextFormField(
              key: ValueKey(vm.kind),
              initialValue: vm.filter.query,
              onChanged: vm.setQuery,
              decoration: InputDecoration(
                hintText: vm.kind == ReportKind.products
                    ? 'Cari Produk'
                    : 'Cari Kategori',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Center(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: ReportIcon('search'),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 44.w,
                  minHeight: 44.h,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          )
        else
          _dateButton(),
        if (vm.kind == ReportKind.summary)
          Text(
            widget.user?.outletName ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        SizedBox(
          height: 46.h,
          width: 150.w,
          child: OutlinedButton(
            onPressed: vm.exporting ? null : _export,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xff656565),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (vm.exporting)
                  const AppLoadingIndicator(compact: true)
                else
                  const ReportIcon('export'),
                SizedBox(width: 10.w),
                Flexible(
                  child: Text(
                    'Export',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 17.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  Widget _cards(ReportData r) {
    final summary = vm.kind == ReportKind.summary;
    final cells = summary
        ? [
            ('Penjualan Kotor', reportMoney(r.totals.grossSales)),
            ('Refund', reportMoney(r.totals.refundAmount)),
            ('Penjualan Bersih', reportMoney(r.totals.netSales)),
            (
              'Rata-rata Transaksi',
              r.totals.average == null ? '—' : reportMoney(r.totals.average!),
            ),
            ('Total Transaksi', '${r.totals.saleCount}'),
            ('Produk Terjual', '${r.totals.soldQuantity}'),
          ]
        : [
            ('Total Terjual', '${r.totals.soldQuantity}'),
            ('Penjualan Bersih', reportMoney(r.totals.netSales)),
            ('Penjualan Kotor', reportMoney(r.totals.grossSales)),
          ];
    return LayoutBuilder(
      builder: (c, size) {
        final count = size.maxWidth >= 600
            ? 3
            : size.maxWidth >= 380
            ? 2
            : 1;
        final width = (size.maxWidth - (count - 1) * 18) / count;
        return Wrap(
          spacing: 18,
          runSpacing: 16,
          children: [
            for (var i = 0; i < cells.length; i++)
              Container(
                width: width,
                height: summary ? 80 : 110,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: summary
                      ? (i < 3 ? reportBlue : reportSide)
                      : const Color(0xfff4f4f4),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: summary
                      ? null
                      : const [
                          BoxShadow(color: Color(0x33000000), blurRadius: 8),
                        ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cells[i].$1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: summary ? 13 : 15,
                        color: summary ? Colors.white : const Color(0xff979797),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        cells[i].$2,
                        style: TextStyle(
                          fontSize: summary ? 21 : 26,
                          fontWeight: FontWeight.w600,
                          color: summary
                              ? Colors.white
                              : const Color(0xff777777),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _body() {
    final r = vm.report;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(48.w, 24.h, 34.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (vm.loading) const AppLinearLoadingIndicator(),
          if (vm.error != null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      vm.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: vm.reload,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            ),
          if (r != null) ...[
            if (vm.kind == ReportKind.summary) ...[
              Text(
                'Tabel Transaksi',
                style: TextStyle(fontSize: 20.sp, color: Color(0xff656565)),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: const Color(0xfff4f4f4),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: DailySalesChart(points: r.daily),
                ),
              ),
              SizedBox(height: 18.h),
              _cards(r),
            ] else if (vm.kind.grouped) ...[
              _cards(r),
              SizedBox(height: 28.h),
              Wrap(
                spacing: 20,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _dateButton(),
                  SizedBox(
                    width: 260.w,
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: vm.filter.sort,
                      key: ValueKey('${vm.kind}-${vm.filter.sort}'),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                      ),
                      icon: const ReportIcon('down'),
                      items: const [
                        DropdownMenuItem(
                          value: 'quantity_desc',
                          child: Text('Unit bersih terbanyak'),
                        ),
                        DropdownMenuItem(
                          value: 'net_desc',
                          child: Text('Penjualan bersih terbesar'),
                        ),
                        DropdownMenuItem(
                          value: 'name_asc',
                          child: Text('Nama A–Z'),
                        ),
                      ],
                      onChanged: (s) {
                        if (s != null) vm.setSort(s);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ],
            if (vm.kind != ReportKind.summary) ...[
              Text(
                'Diperbarui ${reportWib(r.meta.generatedAt).toIso8601String().substring(0, 16).replaceAll('T', ' ')} WIB',
                style: const TextStyle(
                  color: Color(0xffff8227),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              ReportTables(report: r),
            ],
            SizedBox(height: 16.h),
            if (vm.kind.grouped)
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                children: [
                  TextButton(
                    onPressed: vm.filter.page > 1
                        ? () => vm.setPage(vm.filter.page - 1)
                        : null,
                    child: const Text('Sebelumnya'),
                  ),
                  Text('Halaman ${vm.filter.page} • ${r.meta.total} baris'),
                  TextButton(
                    onPressed: vm.filter.page * 20 < r.meta.total
                        ? () => vm.setPage(vm.filter.page + 1)
                        : null,
                    child: const Text('Berikutnya'),
                  ),
                ],
              ),
            if (r.totals.n('excluded_receipts') > 0)
              Text(
                '${r.totals.n('excluded_receipts')} transaksi lama tidak dapat diverifikasi dan dikecualikan.',
                style: const TextStyle(color: Colors.deepOrange),
              ),
            if (r.totals.n('unknown_category_quantity') > 0)
              Text(
                '${r.totals.n('unknown_category_quantity')} unit memiliki kategori historis tidak tercatat.',
                style: const TextStyle(color: Colors.deepOrange),
              ),
            const Divider(),
            Text(
              'Penjualan bersih tanpa pajak • Pajak bersih ${reportMoney(r.totals.n('net_tax'))} • Nilai setelah refund ${reportMoney(r.totals.n('value_after_refunds'))}',
              style: TextStyle(fontSize: 12.sp, color: Color(0xff656565)),
            ),
            SizedBox(height: 8.h),
            Text(
              'Penjualan menurut tanggal bayar; refund menurut tanggal pengembalian. Periode WIB. Export dihitung ulang saat dibuat.',
              style: TextStyle(fontSize: 11.sp, color: Color(0xff888888)),
            ),
            SizedBox(height: 20.h),
            const Center(
              child: Text(
                'Powered By Dikasa',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Color(0xffb5b5b5),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: vm,
    builder: (c, _) => Scaffold(
      backgroundColor: Colors.white,
      appBar: ReportHeader(
        user: widget.user,
        onBack: () => Navigator.maybePop(context),
        onLock: widget.onLock,
      ),
      body: LayoutBuilder(
        builder: (context, size) {
          final wide = size.maxWidth >= 1000;
          if (!wide) {
            return Column(
              children: [
                ReportSelector(
                  onCashDrawer: widget.onCashDrawer,
                  kind: vm.kind,
                  onChanged: vm.setKind,
                  compact: true,
                ),
                Expanded(
                  child: Column(
                    children: [
                      _strip(),
                      Expanded(child: _body()),
                    ],
                  ),
                ),
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 889,
                child: Column(
                  children: [
                    _strip(),
                    Expanded(child: _body()),
                  ],
                ),
              ),
              Expanded(
                flex: 451,
                child: ReportSelector(
                  kind: vm.kind,
                  onChanged: vm.setKind,
                  onCashDrawer: widget.onCashDrawer,
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
