import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_dikasa/components/text_field/main.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';
import 'package:mobile_dikasa/data/services/catalog_service.dart';
import 'widgets.dart';

String stockRequestId() {
  final r = Random.secure();
  final b = List<int>.generate(16, (_) => r.nextInt(256));
  b[6] = (b[6] & 15) | 64;
  b[8] = (b[8] & 63) | 128;
  final h = b.map((v) => v.toRadixString(16).padLeft(2, '0')).join();
  return '${h.substring(0, 8)}-${h.substring(8, 12)}-${h.substring(12, 16)}-${h.substring(16, 20)}-${h.substring(20)}';
}

class StockPanel extends StatelessWidget {
  const StockPanel({
    super.key,
    required this.service,
    required this.product,
    required this.onChanged,
    this.enabled = true,
  });
  final CatalogService service;
  final CatalogProduct? product;
  final Future<void> Function() onChanged;
  final bool enabled;
  Future<void> _edit(BuildContext context, {bool adjust = false}) async {
    final changed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          _StockDialog(service: service, product: product!, adjust: adjust),
    );
    if (changed == true) await onChanged();
  }

  @override
  Widget build(BuildContext context) => CatalogSection(
    title: 'Persediaan Bersama',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product == null)
          Text(
            'Simpan produk terlebih dahulu, lalu buka Ubah Produk untuk mengatur stok.',
            style: catalogText(15),
          )
        else ...[
          Text(
            product!.trackStock
                ? '${product!.stockQuantity} unit'
                : 'Stok tidak dilacak',
            style: catalogText(26, weight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Semua variasi memakai satu saldo produk. Batas menipis: ${product!.lowStockThreshold} unit.',
            style: catalogText(14),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              CatalogButton(
                'Atur Pelacakan',
                onPressed: enabled ? () => _edit(context) : null,
              ),
              CatalogButton(
                'Sesuaikan Stok',
                color: catalogAccent,
                onPressed: enabled && product!.trackStock
                    ? () => _edit(context, adjust: true)
                    : null,
              ),
              TextButton(
                onPressed: enabled
                    ? () => showDialog<void>(
                        context: context,
                        builder: (_) =>
                            _StockHistory(service: service, id: product!.id),
                      )
                    : null,
                child: const Text('Riwayat Stok'),
              ),
            ],
          ),
        ],
      ],
    ),
  );
}

class _StockDialog extends StatefulWidget {
  const _StockDialog({
    required this.service,
    required this.product,
    required this.adjust,
  });
  final CatalogService service;
  final CatalogProduct product;
  final bool adjust;
  @override
  State<_StockDialog> createState() => _StockDialogState();
}

class _StockDialogState extends State<_StockDialog> {
  final form = GlobalKey<FormState>();
  final amount = TextEditingController();
  final threshold = TextEditingController();
  final reason = TextEditingController();
  late bool track;
  bool saving = false;
  String? error;
  Map<String, dynamic>? uncertainCommand;
  @override
  void initState() {
    super.initState();
    track = widget.product.trackStock;
    amount.text = widget.adjust ? '' : widget.product.stockQuantity.toString();
    threshold.text = widget.product.lowStockThreshold.toString();
  }

  @override
  void dispose() {
    amount.dispose();
    threshold.dispose();
    reason.dispose();
    super.dispose();
  }

  String? number(String? text, {bool signed = false}) {
    final s = text?.trim() ?? '';
    final n = int.tryParse(s);
    if (n == null ||
        !(signed ? RegExp(r'^-?\d+$') : RegExp(r'^\d+$')).hasMatch(s) ||
        n.abs() > 1000000000 ||
        (signed && n == 0)) {
      return signed
          ? 'Masukkan perubahan bukan nol, maksimal +/-1 miliar.'
          : 'Masukkan angka 0 sampai 1 miliar.';
    }
    return null;
  }

  Future<void> save() async {
    if (saving ||
        (uncertainCommand == null && !form.currentState!.validate())) {
      return;
    }
    final command =
        uncertainCommand ??
        <String, dynamic>{
          'request_id': stockRequestId(),
          'reason': reason.text.trim(),
          if (widget.adjust)
            'quantity_delta': int.parse(amount.text.trim())
          else ...{
            'track_stock': track,
            'low_stock_threshold': int.parse(threshold.text.trim()),
            if (track && !widget.product.trackStock)
              'initial_quantity': int.parse(amount.text.trim()),
          },
        };
    setState(() {
      saving = true;
      error = null;
    });
    try {
      await widget.service.stockCommand(
        widget.product.id,
        command,
        adjust: widget.adjust,
      );
      if (mounted) Navigator.pop(context, true);
    } on ApiException catch (e) {
      if (mounted) {
        setState(() {
          error = e.message;
          if (e is CatalogWriteUncertain) {
            uncertainCommand = command;
            error =
                "Status belum pasti. Periksa/simpan ulang perintah yang sama; jangan memuat ulang aplikasi.";
          }
        });
      }
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !saving && uncertainCommand == null,
    child: AlertDialog(
      title: Text(widget.adjust ? 'Sesuaikan Stok' : 'Atur Pelacakan Stok'),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Form(
            key: form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (error != null) catalogError(error!),
                if (uncertainCommand != null)
                  const Text(
                    'Perintah yang sama dapat diperiksa/disimpan ulang dengan aman menggunakan ID yang sama. Isian dikunci sampai hasil terkonfirmasi.',
                  ),
                if (!widget.adjust)
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Lacak stok produk ini'),
                    value: track,
                    onChanged: saving || uncertainCommand != null
                        ? null
                        : (v) => setState(() => track = v),
                  ),
                if (widget.adjust || (track && !widget.product.trackStock))
                  AppTextField(
                    controller: amount,
                    label: widget.adjust
                        ? 'Perubahan jumlah (+/-)'
                        : 'Jumlah awal',
                    enabled: !saving && uncertainCommand == null,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                    ),
                    validator: (v) => number(v, signed: widget.adjust),
                  ),
                if (!widget.adjust) ...[
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: threshold,
                    label: 'Batas stok menipis',
                    enabled: !saving && uncertainCommand == null,
                    keyboardType: TextInputType.number,
                    validator: number,
                  ),
                ],
                const SizedBox(height: 16),
                AppTextField(
                  controller: reason,
                  label: 'Alasan perubahan',
                  enabled: !saving && uncertainCommand == null,
                  maxLines: 2,
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Alasan wajib diisi.'
                      : v.trim().length > 500
                      ? 'Maksimal 500 karakter.'
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: saving || uncertainCommand != null
              ? null
              : () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: saving ? null : save,
          child: Text(
            saving
                ? 'Menyimpan…'
                : uncertainCommand == null
                ? 'Simpan Stok'
                : 'Periksa / Simpan ulang',
          ),
        ),
      ],
    ),
  );
}

class _StockHistory extends StatefulWidget {
  const _StockHistory({required this.service, required this.id});
  final CatalogService service;
  final String id;
  @override
  State<_StockHistory> createState() => _StockHistoryState();
}

class _StockHistoryState extends State<_StockHistory> {
  int page = 1, total = 0;
  bool loading = true;
  String? error;
  List<Map<String, dynamic>> rows = [];
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final body = await widget.service.stockMovements(widget.id, page: page);
      if (mounted) {
        setState(() {
          rows = (body['data'] as List).cast<Map<String, dynamic>>();
          total = ((body['meta'] as Map)['total'] as num).toInt();
          loading = false;
        });
      }
    } on ApiException catch (e) {
      if (mounted) {
        setState(() {
          error = e.message;
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Riwayat Stok'),
    content: SizedBox(
      width: 600,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (loading) const LinearProgressIndicator(),
            if (error != null) catalogError(error!, retry: load),
            if (!loading && rows.isEmpty && error == null)
              const Text('Belum ada perubahan stok.'),
            ...rows.map(
              (r) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  '${r['quantity_delta']} unit → ${r['balance_after']} unit',
                ),
                subtitle: Text(
                  '${r['reason']}\n${r['created_at']} • ${r['kind']}',
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    actions: [
      IconButton(
        onPressed: loading || page == 1
            ? null
            : () {
                page--;
                load();
              },
        icon: const Icon(Icons.chevron_left),
      ),
      Text('$page / ${(total / 20).ceil().clamp(1, 999999)}'),
      IconButton(
        onPressed: loading || page * 20 >= total
            ? null
            : () {
                page++;
                load();
              },
        icon: const Icon(Icons.chevron_right),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Tutup'),
      ),
    ],
  );
}
