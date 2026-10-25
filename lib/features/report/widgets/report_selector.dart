import 'package:flutter/material.dart';
import 'package:mobile_dikasa/data/models/sales_report.dart';
import 'report_header.dart';

class ReportSelector extends StatelessWidget {
  const ReportSelector({
    super.key,
    required this.kind,
    required this.onChanged,
    this.compact = false,
    this.onCashDrawer,
  });
  final ReportKind? kind;
  final VoidCallback? onCashDrawer;
  final ValueChanged<ReportKind> onChanged;
  final bool compact;
  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: DropdownButtonFormField<ReportKind>(
              key: ValueKey(kind),
              initialValue: kind,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Pilih Jenis Laporan',
                border: OutlineInputBorder(),
              ),
              items: [
                for (final k in ReportKind.values)
                  DropdownMenuItem(value: k, child: Text(k.label)),
              ],
              onChanged: (k) {
                if (k != null) onChanged(k);
              },
            ),
          ),
          if (onCashDrawer != null)
            TextButton(onPressed: onCashDrawer, child: const Text('Kas Kasir')),
        ],
      );
    }
    return ColoredBox(
      color: const Color(0xfff9f9f9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 88,
            color: reportSide,
            alignment: Alignment.center,
            child: const Text(
              'Pilih Jenis Laporan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
            child: Column(
              children: [
                for (final k in ReportKind.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 17),
                    child: SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: k == kind
                              ? reportSelected
                              : Colors.transparent,
                          foregroundColor: k == kind
                              ? Colors.white
                              : const Color(0xff656565),
                          side: BorderSide(
                            color: k == kind
                                ? reportSelected
                                : const Color(0xffc0c0c0),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => onChanged(k),
                        child: Text(
                          k.label,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (onCashDrawer != null)
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: kind == null ? reportSelected : null,
                        foregroundColor: kind == null
                            ? Colors.white
                            : const Color(0xff656565),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: onCashDrawer,
                      child: const Text(
                        'Kas Kasir',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
