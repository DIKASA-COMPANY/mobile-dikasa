import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_loading_indicator.dart';
import 'package:flutter/services.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';
import 'package:mobile_dikasa/data/models/cash_reconciliation.dart';
import 'package:mobile_dikasa/features/new_order/cash_closing_controller.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';

String cashText(int n) => formatRupiah(n, prefix: 'Rp ');

/// Reused live/frozen breakdown; each method remains separate from physical cash.
class CashSummaryView extends StatelessWidget {
  const CashSummaryView({super.key, required this.summary});
  final CashSummary summary;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Dibuka oleh ${summary.opener}'),
      Text(summary.openedAt),
      const Divider(),
      Text('Kas awal: ${cashText(summary.opening)}'),
      Text('Kas masuk manual: ${cashText(summary.cashIn)}'),
      Text('Kas keluar manual: ${cashText(summary.cashOut)}'),
      Text('Penjualan tunai setelah kembalian: ${cashText(summary.sales)}'),
      Text('Refund tunai pada sesi ini: ${cashText(summary.refunds)}'),
      Text(
        'Kas seharusnya: ${cashText(summary.expected)}',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      Text('${summary.saleCount} penjualan • ${summary.refundCount} refund'),
      const Divider(),
      const Text('Rincian metode pembayaran'),
      for (final m in summary.methods)
        Text(
          '${m['method']}: penjualan ${cashText(cashNumber(m['sales_amount']))} (${m['sale_count']}), refund ${cashText(cashNumber(m['refunds_amount']))} (${m['refund_count']})',
        ),
    ],
  );
}

/// Physical count confirmation owns the POS lock until accepted or safely dismissed.
class CashClosingDialog extends StatelessWidget {
  const CashClosingDialog({super.key, required this.controller});
  final CashClosingController controller;
  static Future<CashClosedRecord?> show(
    BuildContext context,
    NewOrderViewModel vm,
    String id,
  ) async {
    final c = CashClosingController(
      service: vm.posService.cashReconciliation,
      accountId: () => vm.currentUser?.id,
      acquire: vm.beginCashClosing,
      release: vm.endCashClosing,
      onCommitted: vm.refreshCashAfterClose,
    );
    final loading = c.load(id);
    try {
      await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (_) => CashClosingDialog(controller: c),
      );
      await loading;
      return c.result;
    } finally {
      c.dispose();
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: controller,
    builder: (context, _) {
      final c = controller;
      final d = c.detail;
      return PopScope(
        canPop: !c.locked,
        child: AlertDialog(
          title: const Text('Tutup Kas'),
          content: SizedBox(
            width: 640.w,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * .65,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (c.busy) const AppLinearLoadingIndicator(),
                    if (d?.summary != null)
                      CashSummaryView(summary: d!.summary!),
                    if (d != null && d.summary == null)
                      Text(d.unsupportedReason),
                    if (d?.canClose == true) ...[
                      SizedBox(height: 16.h),
                      TextFormField(
                        key: const Key('cash-count'),
                        initialValue: c.countedText,
                        enabled: !c.locked,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Kas fisik yang dihitung (Rupiah)',
                          helperText: 'Masukkan 0 bila tidak ada uang tunai.',
                        ),
                        onChanged: c.setCountedCash,
                      ),
                      TextFormField(
                        key: const Key('cash-reason'),
                        initialValue: c.reason,
                        enabled: !c.locked,
                        maxLength: 500,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Catatan / alasan selisih',
                        ),
                        onChanged: c.setReason,
                      ),
                    ],
                    if (c.error != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Text(
                          c.error!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    if (c.quote != null) ...[
                      const Divider(),
                      Text('Dihitung: ${cashText(c.quote!.counted)}'),
                      Text(
                        c.quote!.difference == 0
                            ? 'Kas sesuai'
                            : '${c.quote!.difference > 0 ? 'Lebih' : 'Kurang'}: ${cashText(c.quote!.difference.abs())}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Text(
                        'Konfirmasi menyimpan hitungan ini dan menutup sesi. Keranjang tetap tersimpan; transaksi berikutnya memerlukan sesi terbuka.',
                      ),
                    ],
                    if (c.uncertain) ...[
                      TextButton(
                        onPressed: c.busy
                            ? null
                            : () async {
                                if (await c.resolvePending() &&
                                    context.mounted) {
                                  Navigator.pop(context, true);
                                }
                              },
                        child: const Text('Periksa Hasil Penutupan'),
                      ),
                      FilledButton(
                        onPressed: c.busy
                            ? null
                            : () async {
                                if (await c.retryPending() && context.mounted) {
                                  Navigator.pop(context, true);
                                }
                              },
                        child: const Text('Ulangi Permintaan yang Sama'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: c.locked ? null : () => Navigator.pop(context, false),
              child: const Text('Kembali'),
            ),
            if (!c.uncertain && d != null) ...[
              TextButton(
                onPressed: c.busy ? null : () => c.load(d.id),
                child: const Text('Muat Ulang Sesi'),
              ),
              if (d.canClose)
                FilledButton(
                  onPressed: c.busy
                      ? null
                      : c.quote == null
                      ? c.preview
                      : () async {
                          if (await c.confirm() && context.mounted) {
                            Navigator.pop(context, true);
                          }
                        },
                  child: Text(
                    c.quote == null ? 'Pratinjau Penutupan' : 'Tutup Sesi Kas',
                  ),
                ),
            ],
          ],
        ),
      );
    },
  );
}
