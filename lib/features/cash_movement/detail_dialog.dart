import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_loading_indicator.dart';
import '../../components/app_remote_image.dart';
import '../../data/models/cash_movement.dart';
import 'controller.dart';
import 'design.dart';

Future<void> showCashMovementDetail(
  BuildContext context,
  CashMovementController c,
  Map<String, dynamic> event,
) async {
  if (!['movement', 'reversal'].contains(event['kind'])) {
    await showDialog<void>(
      context: context,
      builder: (x) => AlertDialog(
        title: Text(event['name'] as String),
        content: Text(
          '${movementMoney((event['amount'] as num).toInt())}\n${cashWIB(event['occurred_at'] as String?)}\n${event['created_by_name'] ?? ''}\n${event['reason'] ?? ''}\nReferensi: ${event['source_id']}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(x),
            child: const Text('Kembali'),
          ),
        ],
      ),
    );
    return;
  }
  try {
    final d = await c.service.detail(
      c.sessionId!,
      event['source_id'] as String,
    );
    if (!context.mounted || !c.current) return;
    await showDialog<void>(
      context: context,
      builder: (x) => _MovementDetail(controller: c, detail: d),
    );
  } catch (e) {
    if (context.mounted && c.current) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rincian kas belum dapat dimuat.')),
      );
    }
  }
}

class _MovementDetail extends StatefulWidget {
  const _MovementDetail({required this.controller, required this.detail});
  final CashMovementController controller;
  final CashMovementDetail detail;
  @override
  State<_MovementDetail> createState() => _DetailState();
}

class _DetailState extends State<_MovementDetail> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(accountChanged);
  }

  void accountChanged() {
    if (mounted && !widget.controller.current) setState(() => proof = null);
  }

  String? proof;
  String? error;
  bool busy = false;
  final reason = TextEditingController();
  @override
  void dispose() {
    widget.controller.removeListener(accountChanged);
    proof = null;
    reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.detail, c = widget.controller, m = d.record;
    if (!c.current) {
      return AlertDialog(
        title: const Text('Sesi akun berubah'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kembali'),
          ),
        ],
      );
    }
    return AlertDialog(
      title: Text(m.json['name'] as String),
      content: SizedBox(
        width: 560.w,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${m.kind == 'in' ? 'Uang Masuk' : 'Uang Keluar'}: ${movementMoney(m.amount)}',
              ),
              Text(cashWIB(m.json['created_at'] as String?)),
              Text('Oleh: ${m.json['created_by_name']}'),
              Text('Alasan: ${m.json['reason']}'),
              if (m.json['reverses_id'] != null)
                Text('Koreksi untuk: ${m.json['reverses_id']}'),
              if (d.reversedById != null)
                Text('Dikoreksi oleh entri: ${d.reversedById}'),
              if (error != null)
                Text(error!, style: const TextStyle(color: Colors.red)),
              if (busy) const AppLinearLoadingIndicator(),
              if (proof != null)
                AppRemoteImage(url: proof!, height: 240.h, fit: BoxFit.contain),
              if (m.hasProof && proof == null)
                TextButton(
                  onPressed: busy
                      ? null
                      : () async {
                          setState(() => busy = true);
                          try {
                            final b = await c.service.proof(m.sessionId, m.id);
                            if (mounted && c.current) setState(() => proof = b);
                          } catch (e) {
                            if (mounted) {
                              setState(
                                () => error = 'Bukti belum dapat dimuat.',
                              );
                            }
                          } finally {
                            if (mounted) setState(() => busy = false);
                          }
                        },
                  child: const Text('Lihat Foto Bukti'),
                ),
              if (d.canReverse) ...[
                SizedBox(height: 18.h),
                TextField(
                  controller: reason,
                  maxLength: 500,
                  decoration: const InputDecoration(
                    labelText: 'Alasan Koreksi',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: busy ? null : () => Navigator.pop(context),
          child: const Text('Kembali'),
        ),
        if (d.canReverse)
          FilledButton(
            onPressed: busy || c.locked
                ? null
                : () async {
                    if (reason.text.trim().isEmpty) {
                      setState(() => error = 'Alasan koreksi wajib diisi.');
                      return;
                    }
                    setState(() => busy = true);
                    final ok = await c.reverse(m, reason.text);
                    if (!context.mounted) return;
                    if (ok || c.uncertain) {
                      Navigator.pop(context);
                      return;
                    }
                    setState(() {
                      busy = false;
                      error = c.error;
                    });
                  },
            child: const Text('Koreksi dengan Entri Lawan'),
          ),
      ],
    );
  }
}
