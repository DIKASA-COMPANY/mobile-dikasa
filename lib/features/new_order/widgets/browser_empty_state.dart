import 'package:flutter/material.dart';
import 'browser_design.dart';

class BrowserEmptyState extends StatelessWidget {
  const BrowserEmptyState({
    super.key,
    required this.customers,
    required this.searching,
  });
  final bool customers, searching;
  @override
  Widget build(BuildContext c) => LayoutBuilder(
    builder: (c, s) {
      final wide = s.maxWidth >= 950;
      final picture = Image.asset(
        'assets/images/batch_one_empty.png',
        width: wide ? 376 : 220,
        height: wide ? 346 : 202,
        fit: BoxFit.cover,
      );
      final message = SizedBox(
        width: wide ? 394 : 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: wide
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Text(
              searching
                  ? 'Tidak ada hasil pencarian'
                  : customers
                  ? 'Daftar Pelanggan\nMasih Kosong ..'
                  : 'Daftar Order\nMasih Kosong ..',
              textAlign: wide ? TextAlign.left : TextAlign.center,
              style: TextStyle(
                fontSize: wide ? 40 : 26,
                color: browserInk,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              searching
                  ? 'Coba kata kunci atau filter lain.'
                  : customers
                  ? 'Pelanggan yang telah terdaftar ditampilkan di halaman ini. Namun, saat ini belum ada pelanggan yang terdaftar.'
                  : 'Order ditampilkan di halaman ini. Namun, saat ini belum ada order yang sesuai.',
              textAlign: wide ? TextAlign.left : TextAlign.center,
              style: TextStyle(
                fontSize: wide ? 22 : 16,
                color: const Color(0xff8f8f8f),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      );
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: wide
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [picture, const SizedBox(width: 72), message],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [picture, const SizedBox(height: 20), message],
                ),
        ),
      );
    },
  );
}
