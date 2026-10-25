import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';
import 'package:mobile_dikasa/core/utils/rupiah_input_formatter.dart';
import 'package:mobile_dikasa/data/models/pos.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/features/new_order/widgets/opening_cash_dialog.dart';
import 'package:mobile_dikasa/features/new_order/widgets/sales_browser.dart';

/// Confirms a received payment and records it; this does not charge a gateway.
class PaymentDialog extends StatefulWidget {
  const PaymentDialog({super.key, required this.viewModel});
  final NewOrderViewModel viewModel;

  static Future<PaymentReceipt?> show(
    BuildContext context,
    NewOrderViewModel viewModel,
  ) => showDialog<PaymentReceipt>(
    context: context,
    barrierDismissible: false,
    builder: (_) => PaymentDialog(viewModel: viewModel),
  );

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  final _paid = TextEditingController();
  bool _loading = true;
  bool _ready = false;
  String _method = 'cash';
  String? _wallet;
  String? _table;
  NewOrderViewModel get vm => widget.viewModel;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _paid.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _ready = false;
    });
    final ready = await vm.preparePayment();
    if (!mounted) return;
    setState(() {
      _loading = false;
      _ready = ready;
    });
  }

  int get _paidAmount => _method == 'cash'
      ? int.tryParse(_paid.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0
      : vm.paymentTotal;

  Future<void> _confirm() async {
    final receipt = await vm.pay(
      method: _method,
      paidAmount: _paidAmount,
      walletId: _wallet,
      tableId: _table,
    );
    if (mounted && receipt != null) Navigator.pop(context, receipt);
  }

  Future<void> _openCash() async {
    await OpeningCashDialog.show(
      context,
      onConfirm: (amount) async {
        final saved = await vm.openCash(amount);
        return saved ? null : vm.checkoutError ?? 'Kas belum tersimpan.';
      },
    );
    if (mounted) await _load();
  }

  Future<void> _reconcile() async {
    if (vm.savedOrderId != null) {
      final paid = await vm.reconcileSavedPayment();
      if (mounted && paid) Navigator.pop(context);
      return;
    }
    await SalesBrowser.show(context, vm);
    if (!mounted) return;
    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi hasil pemeriksaan'),
        content: const Text(
          'Periksa transaksi terbaru, nominal, dan waktu di Daftar Order. '
          'Izinkan percobaan ulang hanya setelah memastikan transaksi sebelumnya belum tersimpan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Kembali'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Dipastikan belum tersimpan'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Sudah tersimpan'),
          ),
        ],
      ),
    );
    if (!mounted || saved == null) return;
    vm.resolveUncertainPayment(wasSaved: saved);
    if (saved) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Observer(
    builder: (_) => PopScope(
      canPop: !vm.isPaying && !vm.draftLocked,
      child: AlertDialog(
        title: const Text('Pembayaran'),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_loading)
                  const Center(child: CircularProgressIndicator())
                else ...[
                  Text(
                    'Subtotal: ${formatRupiah(vm.totalPrice, prefix: 'Rp ')}',
                  ),
                  Text(
                    'Pajak ${vm.taxPercentage}%: ${formatRupiah(vm.taxAmount, prefix: 'Rp ')}',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total: ${formatRupiah(vm.paymentTotal, prefix: 'Rp ')}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: _method,
                    decoration: const InputDecoration(
                      labelText: 'Metode pembayaran',
                    ),
                    items: const [
                      DropdownMenuItem(value: 'cash', child: Text('Tunai')),
                      DropdownMenuItem(
                        value: 'wallet',
                        child: Text('Dompet digital (diterima manual)'),
                      ),
                      DropdownMenuItem(
                        value: 'debit_card',
                        child: Text('Kartu debit (diterima manual)'),
                      ),
                      DropdownMenuItem(
                        value: 'qris',
                        child: Text('QRIS (diterima manual)'),
                      ),
                      DropdownMenuItem(
                        value: 'transfer',
                        child: Text('Transfer (diterima manual)'),
                      ),
                    ],
                    onChanged: vm.isPaying || vm.paymentUncertain
                        ? null
                        : (value) => setState(() => _method = value!),
                  ),
                  if (_method == 'wallet')
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: _wallet,
                      decoration: const InputDecoration(
                        labelText: 'Dompet outlet',
                      ),
                      items: vm.wallets
                          .map(
                            (wallet) => DropdownMenuItem(
                              value: wallet.id,
                              child: Text(wallet.name),
                            ),
                          )
                          .toList(),
                      onChanged: vm.isPaying
                          ? null
                          : (value) => setState(() => _wallet = value),
                    ),
                  if (vm.tables.isNotEmpty)
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: _table,
                      decoration: const InputDecoration(
                        labelText: 'Meja (bila diperlukan)',
                      ),
                      items: vm.tables
                          .map(
                            (table) => DropdownMenuItem(
                              value: table.id,
                              child: Text(table.name),
                            ),
                          )
                          .toList(),
                      onChanged: vm.isPaying
                          ? null
                          : (value) => setState(() => _table = value),
                    ),
                  if (_method == 'cash') ...[
                    TextField(
                      controller: _paid,
                      enabled: !vm.isPaying && !vm.paymentUncertain,
                      keyboardType: TextInputType.number,
                      inputFormatters: const <TextInputFormatter>[
                        RupiahInputFormatter(),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Uang diterima',
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Kembalian: ${formatRupiah((_paidAmount - vm.paymentTotal).clamp(0, 9007199254740991), prefix: 'Rp ')}',
                    ),
                  ],
                  const SizedBox(height: 16),
                  const Text(
                    'Pastikan uang atau pembayaran sudah diterima. Aplikasi hanya mencatat pembayaran.',
                  ),
                ],
                if (vm.checkoutError != null || vm.paymentUncertain)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      vm.paymentUncertain
                          ? 'Status pembayaran belum pasti. Jangan bayar ulang; periksa Daftar Order.'
                          : vm.checkoutError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                if (!_loading && !_ready && !vm.paymentUncertain) ...[
                  TextButton(
                    onPressed: _load,
                    child: const Text('Coba muat ulang'),
                  ),
                  if (vm.cashSession == null)
                    TextButton(
                      onPressed: _openCash,
                      child: const Text('Buka Kas Awal'),
                    ),
                ],
                if (vm.savedCommandUncertain)
                  TextButton(
                    onPressed: vm.isSavingOrder
                        ? null
                        : () async {
                            await vm.retrySavedCommand();
                          },
                    child: const Text('Coba ulang simpan yang sama'),
                  ),
                if (vm.paymentUncertain)
                  FilledButton(
                    onPressed: _reconcile,
                    child: const Text('Periksa Daftar Order'),
                  ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: vm.isPaying || vm.draftLocked
                ? null
                : () => Navigator.pop(context),
            child: const Text('Kembali'),
          ),
          FilledButton(
            onPressed:
                !_ready ||
                    _loading ||
                    vm.isPaying ||
                    vm.paymentUncertain ||
                    vm.draftLocked
                ? null
                : _confirm,
            child: Text(vm.isPaying ? 'Menyimpan…' : 'Proses Bayar'),
          ),
        ],
      ),
    ),
  );
}
