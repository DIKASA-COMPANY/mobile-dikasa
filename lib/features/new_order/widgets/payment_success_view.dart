import 'package:flutter/material.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';
import 'package:mobile_dikasa/data/models/pos.dart';
import 'package:mobile_dikasa/data/models/user.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'browser_design.dart';
import 'browser_page_header.dart';

/// Confirmed local payment presentation, never a new payment command.
class PaymentSuccessView extends StatefulWidget {
  const PaymentSuccessView({
    super.key,
    required this.receipt,
    required this.user,
    this.auth,
    this.onLock,
  });
  final PaymentReceipt receipt;
  final User? user;
  final AuthRepository? auth;
  final VoidCallback? onLock;
  static Future<bool?> show(
    BuildContext c,
    PaymentReceipt receipt,
    User? user, {
    AuthRepository? auth,
    VoidCallback? onLock,
  }) => Navigator.push<bool>(
    c,
    MaterialPageRoute(
      builder: (_) => PaymentSuccessView(
        receipt: receipt,
        user: user,
        auth: auth,
        onLock: onLock,
      ),
    ),
  );
  @override
  State<PaymentSuccessView> createState() => _PaymentSuccessViewState();
}

class _PaymentSuccessViewState extends State<PaymentSuccessView> {
  late final generation = widget.auth?.sessionGeneration;
  bool get current =>
      widget.auth == null ||
      (generation == widget.auth!.sessionGeneration &&
          widget.user?.id == widget.auth!.currentUser?.id);
  @override
  void initState() {
    super.initState();
    widget.auth?.addListener(_changed);
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.auth?.removeListener(_changed);
    super.dispose();
  }

  String money(int n) => formatRupiah(n, prefix: 'Rp. ');
  @override
  Widget build(BuildContext c) {
    if (!current) {
      return Scaffold(
        appBar: AppBar(title: const Text('Sesi berubah')),
        body: const Center(
          child: Text('Masuk kembali untuk melihat transaksi.'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: BrowserPageHeader(
        title: 'Pembayaran',
        user: widget.auth?.currentUser ?? widget.user,
        onBack: () => Navigator.pop(c, false),
        onLock: widget.onLock,
      ),
      body: LayoutBuilder(
        builder: (c, s) {
          if (s.maxWidth < 1000) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 620, child: _summary()),
                  _result(narrow: true),
                ],
              ),
            );
          }
          return Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(width: 446, child: _summary()),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 714),
                        child: Container(
                          color: Colors.white,
                          height: s.maxHeight,
                          child: SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: s.maxHeight,
                              ),
                              child: _result(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Positioned(
                left: 445,
                top: 88,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: BrowserDesignIcon('panel-line'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _summary() {
    final p = widget.receipt.snapshot;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 88,
            color: const Color(0xff2c5e7a),
            alignment: Alignment.center,
            child: const Text(
              'Rincian Pesanan',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: p == null
                ? const Center(child: Text('Rincian tersedia di Daftar Order.'))
                : ListView.separated(
                    itemCount: p.items.length,
                    separatorBuilder: (_, i) => const SizedBox(
                      height: 1,
                      child: ClipRect(
                        child: OverflowBox(
                          minWidth: 450.01,
                          maxWidth: 450.01,
                          alignment: Alignment.centerLeft,
                          child: BrowserDesignIcon('summary-line'),
                        ),
                      ),
                    ),
                    itemBuilder: (c, i) {
                      final line = p.items[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 23,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 44,
                              child: Text(
                                '${line.quantity}x',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: browserInk,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    line.label,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: browserInk,
                                    ),
                                  ),
                                  if (line.note.isNotEmpty)
                                    Text(
                                      'Notes : ${line.note}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        color: browserInk,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              money(line.total),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: browserInk,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          if (p != null) ...[
            _summaryRow('Jenis Pesanan', p.orderTypeLabel),
            _summaryRow('Jumlah Pesanan', '${p.quantity} Produk'),
            Container(
              color: const Color(0xffdbdada),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              child: Column(
                children: [
                  _pair('Total Harga', money(p.subtotal)),
                  _pair(
                    '+ Pajak (${p.taxPercentage.toStringAsFixed(p.taxPercentage == p.taxPercentage.roundToDouble() ? 0 : 2)}%)',
                    money(p.tax),
                  ),
                ],
              ),
            ),
          ],
          Container(
            height: 62,
            color: const Color(0xffe6e6e6),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: _pair(
              'TOTAL',
              money(widget.receipt.total),
              strong: true,
              color: const Color(0xff218831),
            ),
          ),
          Container(
            height: 100,
            alignment: Alignment.center,
            color: const Color(0xfff8f8f8),
            child: const Text(
              'LUNAS',
              style: TextStyle(
                fontSize: 62,
                color: Color(0xff218831),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String a, String b) => Container(
    color: const Color(0xffededed),
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: _pair(a, b),
  );
  Widget _pair(String a, String b, {bool strong = false, Color? color}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                a,
                style: TextStyle(
                  fontSize: strong ? 20 : 16,
                  color: browserInk,
                  fontWeight: strong ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                b,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: strong ? 20 : 16,
                  color: color ?? browserInk,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
  Widget _line() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 14),
    child: SizedBox(
      height: 2,
      child: ClipRect(
        child: OverflowBox(
          minWidth: 446,
          maxWidth: 446,
          alignment: Alignment.centerLeft,
          child: BrowserDesignIcon('success-line'),
        ),
      ),
    ),
  );
  Widget _result({bool narrow = false}) {
    final p = widget.receipt.snapshot;
    return Container(
      color: Colors.white,
      width: 714,
      padding: EdgeInsets.symmetric(horizontal: narrow ? 20 : 54, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const BrowserDesignIcon('check'),
              const SizedBox(width: 18),
              Flexible(
                child: Text(
                  'Transaksi Berhasil',
                  style: TextStyle(
                    color: browserInk,
                    fontSize: narrow ? 28 : 38,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'No Transaksi : ${widget.receipt.number}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xff8e8e8e), fontSize: 18),
          ),
          const SizedBox(height: 28),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: narrow ? 0 : 40),
            child: Column(
              children: [
                _pair('Tagihan', money(widget.receipt.total)),
                if (p != null) ...[
                  _pair('Pembayaran', money(p.paid)),
                  _line(),
                  _pair('Sisa', money(0)),
                  _pair('Kembalian', money(p.change)),
                  _pair('Pembulatan', money(p.rounding)),
                  _pair('Sisa Pembulatan', money(0)),
                  _line(),
                  _pair('Tips', money(p.tips), color: const Color(0xff218831)),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffc6c6c6),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _pair(
                      'Kembalian',
                      money(p.change),
                      strong: true,
                      color: const Color(0xff9d1414),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 38),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 18,
            runSpacing: 12,
            children: [
              _disabled('Share via WA', 'Berbagi struk belum tersedia.'),
              _disabled('Cetak Struk', 'Pencetakan struk belum tersedia.'),
              SizedBox(
                width: narrow ? 160 : 174,
                height: 57,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xffff8227),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Selesai', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Daftar Order'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _disabled(String title, String hint) => Tooltip(
    message: hint,
    child: Semantics(
      label: '$title. $hint',
      child: SizedBox(
        width: 174,
        height: 57,
        child: FilledButton(
          style: FilledButton.styleFrom(
            disabledBackgroundColor: browserAction.withValues(alpha: .5),
            disabledForegroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: null,
          child: Text(title, style: const TextStyle(fontSize: 18)),
        ),
      ),
    ),
  );
}
