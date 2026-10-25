import '../../cash_movement/view.dart';
import 'package:flutter/material.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/cash_reconciliation.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'cash_closing_dialog.dart';

class CashSessionsDialog extends StatefulWidget {
  const CashSessionsDialog({super.key, required this.viewModel});
  final NewOrderViewModel viewModel;
  static Future<void> show(BuildContext context, NewOrderViewModel vm) =>
      showDialog<void>(
        context: context,
        builder: (_) => CashSessionsDialog(viewModel: vm),
      );
  @override
  State<CashSessionsDialog> createState() => _CashSessionsState();
}

class _CashSessionsState extends State<CashSessionsDialog> {
  late final _account = widget.viewModel.currentUser?.id;
  CashSessionPage? _data;
  bool _busy = false;
  String? _error;
  int _page = 1;
  bool get current => mounted && widget.viewModel.currentUser?.id == _account;
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (!mounted || !current) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final d = await widget.viewModel.posService.cashReconciliation.sessions(
        page: _page,
      );
      if (current) setState(() => _data = d);
    } on ApiException catch (e) {
      if (current) setState(() => _error = e.message);
    } finally {
      if (current) setState(() => _busy = false);
    }
  }

  Future<void> _closed(CashClosedRecord c) => showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Sesi Kas Ditutup'),
      content: SizedBox(
        width: 640,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CashSummaryView(summary: c.summary),
              const Divider(),
              Text('Dihitung: ${cashText(c.counted)}'),
              Text('Selisih: ${cashText(c.difference)}'),
              Text('Catatan: ${c.reason}'),
              Text('Ditutup oleh ${c.closer}'),
              Text(c.closedAt),
              const Text(
                'Sesi berikutnya dibuka melalui Kas Awal saat akan membayar. Keranjang tidak dihapus.',
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Selesai'),
        ),
      ],
    ),
  );
  Future<void> _open(String id) async {
    if (!current || _busy) return;
    setState(() => _busy = true);
    try {
      final d = await widget.viewModel.posService.cashReconciliation.detail(id);
      if (!mounted || !current) return;
      final close = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            d.status == 'open' ? 'Sesi Kas Aktif' : 'Ringkasan Sesi Kas',
          ),
          content: SizedBox(
            width: 640,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (d.summary != null)
                    CashSummaryView(summary: d.summary!)
                  else ...[
                    Text('Kas awal: ${cashText(d.opening)}'),
                    Text(d.unsupportedReason),
                  ],
                  if (d.closing != null) ...[
                    const Divider(),
                    Text('Dihitung: ${cashText(d.closing!.counted)}'),
                    Text('Selisih: ${cashText(d.closing!.difference)}'),
                    Text('Catatan: ${d.closing!.reason}'),
                    Text('Ditutup oleh ${d.closing!.closer}'),
                    Text(d.closing!.closedAt),
                  ],
                  if (d.status == 'open' && !d.canClose)
                    const Text(
                      'Hanya kasir pembuka atau manager dapat menutup sesi yang dapat diverifikasi.',
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx, false);
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CashMovementView(
                      viewModel: widget.viewModel,
                      initialSessionId: id,
                    ),
                  ),
                );
              },
              child: const Text('Aktivitas Kas'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Kembali'),
            ),
            if (d.canClose)
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Hitung / Tutup Kas'),
              ),
          ],
        ),
      );
      if (!mounted || !current) return;
      if (close == true) {
        final r = await CashClosingDialog.show(context, widget.viewModel, id);
        if (!mounted || !current) return;
        await _load();
        if (!mounted || !current) return;
        if (r != null) await _closed(r);
      }
    } on ApiException catch (e) {
      if (current) setState(() => _error = e.message);
    } finally {
      if (current) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Sesi Kas'),
    content: SizedBox(
      width: 720,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * .7,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_busy) const LinearProgressIndicator(),
              if (_error != null) Text(_error!),
              if (_data?.items.isEmpty == true)
                const Text('Belum ada sesi kas.'),
              for (final d in _data?.items ?? <CashSessionRecord>[])
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    d.status == 'open'
                        ? 'Aktif • ${cashText(d.opening)}'
                        : 'Ditutup • ${cashText(d.opening)}',
                  ),
                  subtitle: Text('${d.opener} • ${d.openedAt}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _busy ? null : () => _open(d.id),
                ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Kembali'),
      ),
      TextButton(
        onPressed: _busy ? null : _load,
        child: const Text('Muat Ulang'),
      ),
      TextButton(
        onPressed: _page > 1 && !_busy
            ? () {
                _page--;
                _load();
              }
            : null,
        child: const Text('Sebelumnya'),
      ),
      Text('Halaman $_page'),
      TextButton(
        onPressed: !_busy && _page * 20 < (_data?.total ?? 0)
            ? () {
                _page++;
                _load();
              }
            : null,
        child: const Text('Berikutnya'),
      ),
    ],
  );
}
