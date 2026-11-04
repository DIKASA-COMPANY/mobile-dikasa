import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';

/// Explicitly parks a cart; uncertain writes can only retry the original command.
class SaveOrderDialog extends StatefulWidget {
  const SaveOrderDialog({super.key, required this.viewModel});
  final NewOrderViewModel viewModel;
  static Future<void> show(BuildContext context, NewOrderViewModel vm) =>
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => SaveOrderDialog(viewModel: vm),
      );
  @override
  State<SaveOrderDialog> createState() => _SaveOrderDialogState();
}

class _SaveOrderDialogState extends State<SaveOrderDialog> {
  late final TextEditingController _label = TextEditingController(
    text: widget.viewModel.savedOrderLabel ?? '',
  );
  @override
  void dispose() {
    _label.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Observer(
    builder: (_) {
      final vm = widget.viewModel;
      return PopScope(
        canPop: !vm.draftLocked,
        child: AlertDialog(
          title: const Text('Simpan Pesanan'),
          content: SizedBox(
            width: 440.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Pesanan tersimpan di outlet. Stok berkurang setelah pembayaran berhasil.',
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: _label,
                  maxLength: 100,
                  enabled: !vm.draftLocked,
                  decoration: const InputDecoration(
                    labelText: 'Nama order (opsional)',
                    hintText: 'Contoh: Meja 3 / Budi',
                  ),
                ),
                if (vm.checkoutError != null)
                  Text(
                    vm.checkoutError!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: vm.draftLocked ? null : () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: vm.isSavingOrder
                  ? null
                  : () async {
                      final saved = await vm.saveOrder(label: _label.text);
                      if (context.mounted && saved) Navigator.pop(context);
                    },
              child: Text(
                vm.isSavingOrder
                    ? 'Menyimpan…'
                    : vm.savedCommandUncertain
                    ? 'Coba ulang permintaan yang sama'
                    : 'Simpan Order',
              ),
            ),
          ],
        ),
      );
    },
  );
}
