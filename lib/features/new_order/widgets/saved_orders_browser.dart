import 'browser_design.dart';
import 'browser_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';
import 'package:mobile_dikasa/data/models/saved_order.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';

/// Open outlet drafts, with explicit reopen/delete and revision-conflict recovery.
class SavedOrdersBrowser extends StatefulWidget {
  const SavedOrdersBrowser({
    super.key,
    required this.viewModel,
    this.navigation,
  });
  final NewOrderViewModel viewModel;
  final Widget? navigation;
  @override
  State<SavedOrdersBrowser> createState() => _SavedOrdersBrowserState();
}

class _SavedOrdersBrowserState extends State<SavedOrdersBrowser> {
  final _search = TextEditingController();
  late Future<SavedOrderPage> _result;
  int _page = 1;
  NewOrderViewModel get vm => widget.viewModel;
  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _fetch() {
    _result = vm.posService.savedOrders(search: _search.text, page: _page);
  }

  void _reload({bool reset = false}) => setState(() {
    if (reset) _page = 1;
    _fetch();
  });
  Future<void> _open(SavedOrder order) async {
    var opened = await vm.openSavedOrder(order.id);
    if (!mounted) return;
    if (!opened && vm.reopenWarnings.isNotEmpty) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Periksa perubahan pesanan'),
          content: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Text(vm.reopenWarnings.join('\n\n')),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Terapkan perubahan'),
            ),
          ],
        ),
      );
      if (!mounted) return;
      if (confirm == true) {
        opened = await vm.openSavedOrder(order.id, acceptChanges: true);
      } else {
        vm.cancelSavedReview();
      }
    }
    if (!mounted) return;
    if (opened) {
      Navigator.pop(context);
    } else {
      _reload();
    }
  }

  Future<void> _delete(SavedOrder order) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus pesanan tersimpan?'),
        content: Text(order.label),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus Pesanan'),
          ),
        ],
      ),
    );
    if (confirm != true || !mounted) return;
    await vm.deleteSavedOrder(order);
    if (mounted) _reload();
  }

  @override
  Widget build(BuildContext context) => Observer(
    builder: (_) => Column(
      children: [
        BrowserToolbar(
          title: 'Daftar Order',
          search: BrowserSearch(
            controller: _search,
            hint: 'Cari nama order tersimpan',
            onSearch: vm.draftLocked || vm.isPaying
                ? null
                : () => _reload(reset: true),
          ),
          actions: const [],
          onBack: vm.draftLocked || vm.isPaying
              ? null
              : () => Navigator.pop(context),
        ),
        if (widget.navigation != null) widget.navigation!,
        if (vm.checkoutError != null)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              vm.checkoutError!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        if (vm.savedCommandUncertain)
          FilledButton(
            onPressed: vm.isSavingOrder
                ? null
                : () async {
                    await vm.retrySavedCommand();
                    if (mounted) _reload();
                  },
            child: const Text('Coba ulang permintaan yang sama'),
          ),
        if (vm.isSavingOrder) const LinearProgressIndicator(),
        Expanded(
          child: FutureBuilder<SavedOrderPage>(
            future: _result,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        snapshot.error is ApiException
                            ? (snapshot.error as ApiException).message
                            : 'Pesanan gagal dimuat.',
                      ),
                      TextButton(
                        onPressed: _reload,
                        child: const Text('Muat ulang'),
                      ),
                    ],
                  ),
                );
              }
              final page = snapshot.requireData;
              final blocked =
                  vm.draftLocked || vm.isPaying || vm.paymentUncertain;
              return Padding(
                padding: const EdgeInsets.fromLTRB(46, 24, 46, 0),
                child: Column(
                  children: [
                    Expanded(
                      child: page.items.isEmpty
                          ? BrowserEmptyState(
                              customers: false,
                              searching: _search.text.trim().isNotEmpty,
                            )
                          : BrowserTable(
                              headers: const [
                                'Nama Order',
                                'Pegawai',
                                'Tanggal Order',
                                'Jenis Order',
                                'Jumlah',
                                'Estimasi',
                                'Tindakan',
                              ],
                              fractions: const [
                                .17,
                                .15,
                                .18,
                                .13,
                                .1,
                                .16,
                                .11,
                              ],
                              rows: page.items
                                  .map(
                                    (o) => [
                                      Text(o.label),
                                      Text(o.creator),
                                      Text(browserDate(o.updatedAt)),
                                      Text(
                                        vm.orderTypes
                                                .where(
                                                  (t) => t.id == o.orderTypeId,
                                                )
                                                .firstOrNull
                                                ?.label ??
                                            '—',
                                      ),
                                      Text('${o.quantity} Produk'),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            formatRupiah(
                                              o.subtotal,
                                              prefix: 'Rp ',
                                            ),
                                          ),
                                          const Text(
                                            'sebelum pajak',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Wrap(
                                        children: [
                                          TextButton(
                                            onPressed: blocked
                                                ? null
                                                : () => _open(o),
                                            child: const Text('Buka'),
                                          ),
                                          IconButton(
                                            tooltip: 'Hapus pesanan',
                                            onPressed: blocked
                                                ? null
                                                : () => _delete(o),
                                            icon: const Icon(
                                              Icons.delete_outline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                  .toList(),
                            ),
                    ),
                    BrowserFooter(
                      page: _page,
                      total: page.total,
                      onPrevious: !blocked && _page > 1
                          ? () {
                              _page--;
                              _reload();
                            }
                          : null,
                      onNext: !blocked && _page * 20 < page.total
                          ? () {
                              _page++;
                              _reload();
                            }
                          : null,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
