import 'package:flutter/material.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';
import 'package:mobile_dikasa/data/models/refund.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'refund_dialog.dart';

/// Original receipt and paginated refund audit, available without replacing the cart.
class ReceiptDetailDialog extends StatefulWidget {
  const ReceiptDetailDialog({
    super.key,
    required this.viewModel,
    required this.transactionId,
  });
  final NewOrderViewModel viewModel;
  final String transactionId;
  static Future<void> show(
    BuildContext context,
    NewOrderViewModel vm,
    String id,
  ) => showDialog<void>(
    context: context,
    builder: (_) => ReceiptDetailDialog(viewModel: vm, transactionId: id),
  );
  @override
  State<ReceiptDetailDialog> createState() => _ReceiptDetailDialogState();
}

class _ReceiptDetailDialogState extends State<ReceiptDetailDialog> {
  ReceiptRefundDetail? _detail;
  RefundHistoryPage? _history;
  String? _error;
  bool _loading = true;
  int _page = 1;
  late final String? _account = widget.viewModel.currentUser?.id;
  @override
  void initState() {
    super.initState();
    _load();
  }

  bool get current => mounted && widget.viewModel.currentUser?.id == _account;
  Future<void> _load() async {
    if (!current) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final service = widget.viewModel.posService.refunds;
      final d = await service.detail(widget.transactionId);
      final h = await service.history(widget.transactionId, page: _page);
      if (current) {
        setState(() {
          _detail = d;
          _history = h;
        });
      }
    } on ApiException catch (e) {
      if (current) setState(() => _error = e.message);
    } finally {
      if (current) setState(() => _loading = false);
    }
  }

  Future<void> _refund(String mode) async {
    if (await RefundDialog.show(
          context,
          widget.viewModel,
          widget.transactionId,
          mode,
        ) &&
        current) {
      await _load();
      if (!mounted) return;
      if (current) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Refund tercatat. Riwayat diperbarui.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = _detail;
    return AlertDialog(
      title: Text(d == null ? 'Detail Transaksi' : d.number),
      content: SizedBox(
        width: 700,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * .7,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_loading) const LinearProgressIndicator(),
                if (_error != null) Text(_error!),
                if (d != null) ...[
                  Text('Status: ${d.status} • metode asli: ${d.method}'),
                  Text('Total asli: ${formatRupiah(d.total, prefix: 'Rp ')}'),
                  if (d.supported) ...[
                    Text(
                      'Sudah refund: ${formatRupiah(d.refunded, prefix: 'Rp ')}',
                    ),
                    Text(
                      'Sisa nilai: ${formatRupiah(d.total - d.refunded, prefix: 'Rp ')}',
                    ),
                  ] else
                    const Text(
                      'Status lama tanpa catatan refund yang dapat diverifikasi. Refund diblokir.',
                    ),
                  const Divider(),
                  for (final i in d.items)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(i.label),
                      subtitle: Text(
                        '${i.quantity} terjual • ${i.refunded} direfund • ${i.remaining} tersisa',
                      ),
                      trailing: Text(formatRupiah(i.price, prefix: 'Rp ')),
                    ),
                  const Divider(),
                  const Text('Riwayat Refund'),
                  for (final r in _history?.items ?? <RefundRecord>[])
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${r.number} • ${formatRupiah(r.total, prefix: 'Rp ')}',
                            ),
                            Text('${r.actor} • ${r.date} • ${r.method}'),
                            Text('Alasan: ${r.reason}'),
                            for (final i in r.items)
                              Text(
                                'Item ${i['transaction_item_id']}: refund ${i['quantity']}, kembali ke stok ${i['restock_quantity']}',
                              ),
                          ],
                        ),
                      ),
                    ),
                  if (_history != null)
                    Wrap(
                      children: [
                        TextButton(
                          onPressed: _page > 1 && !_loading
                              ? () {
                                  _page--;
                                  _load();
                                }
                              : null,
                          child: const Text('Sebelumnya'),
                        ),
                        Text('Halaman $_page'),
                        TextButton(
                          onPressed: _page * 20 < _history!.total && !_loading
                              ? () {
                                  _page++;
                                  _load();
                                }
                              : null,
                          child: const Text('Berikutnya'),
                        ),
                      ],
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Tutup'),
        ),
        TextButton(
          onPressed: _loading ? null : _load,
          child: const Text('Muat Ulang'),
        ),
        if (d?.canRefund == true) ...[
          TextButton(
            onPressed: _loading ? null : () => _refund('full'),
            child: const Text('Batalkan / Refund Seluruh Sisa'),
          ),
          FilledButton(
            onPressed: _loading ? null : () => _refund('items'),
            child: const Text('Refund Item'),
          ),
        ],
      ],
    );
  }
}
