import 'package:flutter/material.dart';
import '../../data/models/sales_report.dart';
import '../../data/models/cash_reconciliation.dart';
import '../new_order/view_model.dart';
import '../new_order/widgets/cash_closing_dialog.dart';
import '../report/main.dart';
import '../report/widgets/report_header.dart';
import '../report/widgets/report_selector.dart';
import 'controller.dart';
import 'entry_dialog.dart';
import 'activity_table.dart';
import 'detail_dialog.dart';
import 'design.dart';

class CashMovementView extends StatefulWidget {
  const CashMovementView({
    super.key,
    required this.viewModel,
    this.initialSessionId,
    this.onLock,
  });
  final NewOrderViewModel viewModel;
  final String? initialSessionId;
  final VoidCallback? onLock;
  @override
  State<CashMovementView> createState() => _CashMovementState();
}

class _CashMovementState extends State<CashMovementView> {
  late final CashMovementController c;
  List<CashSessionRecord> sessions = [];
  String? initialError;
  bool starting = true;
  @override
  void initState() {
    super.initState();
    c = widget.viewModel.cashMovements;
    c.addListener(changed);
    start();
  }

  void changed() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    c.removeListener(changed);
    super.dispose();
  }

  Future<void> start() async {
    try {
      final history = await widget.viewModel.posService.cashReconciliation
          .sessions();
      if (!mounted || !c.current) return;
      sessions = history.items;
      String? id = c.pending?.sessionId ?? widget.initialSessionId;
      id ??= (await widget.viewModel.posService.currentCash())?.id;
      id ??= sessions.firstOrNull?.id;
      if (id != null && !c.locked) await c.load(id);
    } catch (e) {
      if (mounted && c.current) initialError = 'Sesi kas belum dapat dimuat.';
    } finally {
      if (mounted) setState(() => starting = false);
    }
  }

  Future<void> refresh() async {
    if (c.sessionId != null && !c.locked) await c.load(c.sessionId!);
  }

  Future<void> entry() async {
    await showDialog<bool>(
      context: context,
      builder: (_) => CashMovementEntry(controller: c),
    );
    if (mounted && !c.locked) await refresh();
  }

  Future<void> close() async {
    final id = c.sessionId;
    if (id == null || c.locked) return;
    await CashClosingDialog.show(context, widget.viewModel, id);
    if (mounted) await refresh();
  }

  Future<void> reports(ReportKind k) async {
    if (c.locked) return;
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => SalesReportsView(
          service: widget.viewModel.posService.reports,
          accountId: () => widget.viewModel.currentUser?.id,
          user: widget.viewModel.currentUser,
          initialKind: k,
          onLock: widget.onLock,
          onCashDrawer: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget card(String title, int? value) => Container(
    height: 110,
 width:double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xfff4f4f4),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 12)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Color(0xff979797), fontSize: 17),
        ),
        const SizedBox(height: 8),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value == null ? 'Tidak tersedia' : movementMoney(value),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xff979797),
            ),
          ),
        ),
      ],
    ),
  );
  Widget content() {
    final a = c.activity;
    final t = a?.totals;
    final narrow = MediaQuery.sizeOf(context).width < 700;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: narrow ? 16 : 52, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (c.uncertain)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              color: const Color(0xfffff0d6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c.error ?? 'Transaksi kas belum pasti.'),
                  Text('Sesi asli: ${c.pending?.sessionId}'),
                  Wrap(
                    spacing: 12,
                    children: [
                      FilledButton(
                        onPressed: c.busy
                            ? null
                            : () async {
                                if (await c.recover() && mounted) {
                                  await refresh();
                                }
                              },
                        child: const Text('Pulihkan Hasil'),
                      ),
                      OutlinedButton(
                        onPressed: c.busy
                            ? null
                            : () async {
                                if (await c.retry() && mounted) await refresh();
                              },
                        child: const Text('Kirim Ulang yang Sama'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (c.error != null && !c.uncertain)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(c.error!, style: const TextStyle(color: Colors.red)),
            ),
          if (initialError != null) Text(initialError!),
          if (a == null && !starting && !c.busy) ...[
            const Text(
              'Belum ada sesi kas. Buka sesi melalui Kas Awal untuk mencatat kas masuk/keluar.',
            ),
            TextButton(onPressed: start, child: const Text('Muat Ulang')),
          ],
          if (a != null) ...[
            LayoutBuilder(
              builder: (ctx, s) {
                final cards = [
                  card(
                    'Total Kas Kasir',
                    (t?['expected_cash'] as num?)?.toInt(),
                  ),
                  card('Total Uang Masuk', (t?['total_in'] as num?)?.toInt()),
                  card('Total Uang Keluar', (t?['total_out'] as num?)?.toInt()),
                ];
                return s.maxWidth >= 700
                    ? Row(
                        children: [
                          for (var i = 0; i < cards.length; i++)
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: i == cards.length - 1 ? 0 : 18,
                                ),
                                child: cards[i],
                              ),
                            ),
                        ],
                      )
                    : Column(
                        children: [
                          for (final v in cards)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: v,
                            ),
                        ],
                      );
              },
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  'Dibuka ${cashWIB(a.session.openedAt)}',
                  style: const TextStyle(color: cashOrange),
                ),
                Text(
                  'Sesi ${a.session.status == 'open' ? 'Terbuka' : 'Ditutup'} • ${a.session.opener}',
                  style: const TextStyle(color: cashOrange),
                ),
              ],
            ),
            if (sessions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: DropdownButtonFormField<String>(
                  key: ValueKey(c.sessionId),
                  initialValue: sessions.any((s) => s.id == c.sessionId)
                      ? c.sessionId
                      : null,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Pilih Sesi Kas',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (final s in sessions)
                      DropdownMenuItem(
                        value: s.id,
                        child: Text(
                          '${cashWIB(s.openedAt)} • ${s.status}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: c.locked
                      ? null
                      : (id) {
                          if (id != null) c.load(id);
                        },
                ),
              ),
            if (t == null) Text(a.session.unsupportedReason),
            const SizedBox(height: 18),
            CashActivityTable(
              events: a.events,
              onDetail: (event) async {
                if (c.locked) return;
                await showCashMovementDetail(context, c, event);
                if (mounted && !c.locked) await refresh();
              },
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('${a.total} aktivitas • Halaman ${a.page}'),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Halaman sebelumnya',
                      onPressed: c.locked || c.page <= 1
                          ? null
                          : () =>
                                c.load(c.sessionId!, requestedPage: c.page - 1),
                      icon: const Icon(Icons.chevron_left),
                    ),
                    IconButton(
                      tooltip: 'Halaman berikutnya',
                      onPressed: c.locked || c.page * 20 >= a.total
                          ? null
                          : () =>
                                c.load(c.sessionId!, requestedPage: c.page + 1),
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ],
            ),
            const Text(
              'Total mencakup seluruh sesi dan entri koreksi tercatat. Transaksi non-tunai ada pada rincian sesi.',
              style: TextStyle(fontSize: 12, color: Color(0xff999999)),
            ),
          ],
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'Powered By Dikasa',
              style: TextStyle(
                color: Color(0xffb5b5b5),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 1100;
    final a = c.activity;
    final main = Column(
      children: [
        Container(
          color: cashDark,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: MediaQuery.sizeOf(context).width < 600
              ? Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: c.busy
                              ? null
                              : () => Navigator.pop(context),
                          icon: const CashIcon('back'),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Kas Kasir',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                          ),
                          onPressed: c.locked || a?.session.canClose != true
                              ? null
                              : close,
                          child: const Text('Tutup Kas'),
                        ),
                        const SizedBox(width: 12),
                        FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xff656565),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: c.locked || a?.canCreate != true
                              ? null
                              : entry,
                          icon: const CashIcon('add'),
                          label: const Text('Tambah'),
                        ),
                      ],
                    ),
                  ],
                )
              : SizedBox(
                  height: 64,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: c.busy ? null : () => Navigator.pop(context),
                        icon: const CashIcon('back'),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Kas Kasir',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                        ),
                        onPressed: c.locked || a?.session.canClose != true
                            ? null
                            : close,
                        child: const Text('Tutup Kas'),
                      ),
                      const SizedBox(width: 12),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xff656565),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: c.locked || a?.canCreate != true
                            ? null
                            : entry,
                        icon: const CashIcon('add'),
                        label: const Text('Tambah'),
                      ),
                    ],
                  ),
                ),
        ),
        if (c.busy || starting) const LinearProgressIndicator(),
        if (!wide)
          TextButton(
            onPressed: c.locked ? null : () => reports(ReportKind.summary),
            child: const Text('Laporan Penjualan'),
          ),
        Expanded(
          child: !c.current
              ? const Center(
                  child: Text('Sesi akun berubah. Kembali dan login ulang.'),
                )
              : content(),
        ),
      ],
    );
    return PopScope(
      canPop: !c.busy,
      child: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Poppins'),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                ReportHeader(
                  user: widget.viewModel.currentUser,
                  onBack: () => Navigator.pop(context),
                  onLock: c.locked ? null : widget.onLock,
                ),
                Expanded(
                  child: wide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: main),
                            SizedBox(
                              width: 451,
                              child: ReportSelector(
                                kind: null,
                                onChanged: reports,
                                onCashDrawer: refresh,
                              ),
                            ),
                          ],
                        )
                      : main,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
