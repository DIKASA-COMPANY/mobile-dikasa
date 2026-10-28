import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_loading_indicator.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';
import 'package:mobile_dikasa/features/new_order/refund_controller.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';

/// Records a manually completed payout after the cashier reviews authoritative amounts.
class RefundDialog extends StatelessWidget {
  const RefundDialog({super.key, required this.controller});
  final RefundController controller;
  static Future<bool> show(
    BuildContext context,
    NewOrderViewModel vm,
    String id,
    String mode,
  ) async {
    final c = RefundController(
      service: vm.posService.refunds,
      accountId: () => vm.currentUser?.id,
      acquire: vm.beginRefund,
      release: vm.endRefund,
      onCommitted: () => vm.loadProducts(forceRefresh: true),
    );
    final loading = c.load(id, mode);
    try {
      final result = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (_) => RefundDialog(controller: c),
      );
      await loading;
      return result == true;
    } finally {
      c.dispose();
    }
  }

  Widget _step(
    String label,
    int value,
    int maximum,
    void Function(int) update,
    bool enabled,
  ) => Row(
    children: [
      Expanded(child: Text('$label: $value')),
      IconButton(
        tooltip: 'Kurangi $label',
        onPressed: enabled && value > 0 ? () => update(value - 1) : null,
        icon: const Icon(Icons.remove),
      ),
      IconButton(
        tooltip: 'Tambah $label',
        onPressed: enabled && value < maximum ? () => update(value + 1) : null,
        icon: const Icon(Icons.add),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: controller,
    builder: (context, _) {
      final c = controller;
      final d = c.detail;
      return PopScope(
        canPop: !c.locked,
        child: AlertDialog(
          title: Text(c.mode == 'full' ? 'Refund Seluruh Sisa' : 'Refund Item'),
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
                    const Text(
                      'Mencatat uang yang sudah dikembalikan; tidak mengirim dana otomatis.',
                    ),
                    if (c.busy) const AppLinearLoadingIndicator(),
                    if (d != null) ...[
                      Text('Struk ${d.number} • pembayaran asli: ${d.method}'),
                      for (final i in d.items.where((i) => i.remaining > 0))
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(12.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  i.label,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  'Terjual ${i.quantity} • sudah refund ${i.refunded} • sisa ${i.remaining}',
                                ),
                                _step(
                                  'Jumlah refund',
                                  c.quantities[i.id] ?? 0,
                                  i.remaining,
                                  (q) => c.setQuantity(i.id, q),
                                  !c.locked && c.mode == 'items',
                                ),
                                if (i.tracked && i.restockBudget > 0)
                                  _step(
                                    'Kembali ke stok',
                                    c.returns[i.id] ?? 0,
                                    c.quantities[i.id] ?? 0,
                                    (q) => c.setReturn(i.id, q),
                                    !c.locked,
                                  )
                                else
                                  const Text(
                                    'Tidak ada stok penjualan terlacak untuk dikembalikan.',
                                  ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(height: 12.h),
                      TextFormField(
                        key: const Key('refund-reason'),
                        initialValue: c.reason,
                        enabled: !c.locked,
                        maxLength: 500,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Alasan refund (wajib)',
                        ),
                        onChanged: c.setReason,
                      ),
                      DropdownButtonFormField<String>(
                        initialValue: c.method.isEmpty ? null : c.method,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Uang dikembalikan melalui',
                        ),
                        items: const [
                          DropdownMenuItem(value: 'cash', child: Text('Tunai')),
                          DropdownMenuItem(
                            value: 'wallet',
                            child: Text('Dompet digital (manual)'),
                          ),
                          DropdownMenuItem(
                            value: 'debit_card',
                            child: Text('Kartu debit (manual)'),
                          ),
                          DropdownMenuItem(
                            value: 'qris',
                            child: Text('QRIS (manual)'),
                          ),
                          DropdownMenuItem(
                            value: 'transfer',
                            child: Text('Transfer (manual)'),
                          ),
                        ],
                        onChanged: c.locked
                            ? null
                            : (v) {
                                if (v != null) c.setMethod(v);
                              },
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
                      Text(
                        'Setelah diskon: ${formatRupiah(c.quote!.net, prefix: 'Rp ')}',
                      ),
                      Text(
                        'Pajak penjualan asli: ${formatRupiah(c.quote!.tax, prefix: 'Rp ')}',
                      ),
                      Text(
                        'Total dikembalikan: ${formatRupiah(c.quote!.total, prefix: 'Rp ')}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Text(
                        'Dengan konfirmasi, Anda menyatakan uang di atas sudah dikembalikan. Stok hanya bertambah sesuai jumlah yang dipilih.',
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
                        child: const Text('Periksa Hasil Refund'),
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
            if (!c.uncertain && d != null && d.canRefund) ...[
              TextButton(
                onPressed: c.busy ? null : () => c.load(d.id, c.mode),
                child: const Text('Muat Ulang Transaksi'),
              ),
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
                  c.quote == null
                      ? 'Pratinjau Refund'
                      : 'Catat Uang Sudah Dikembalikan',
                ),
              ),
            ],
          ],
        ),
      );
    },
  );
}
