import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:mobile_dikasa/core/constants/colors.dart';
import 'package:mobile_dikasa/core/themes/text_styles.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';
import 'package:mobile_dikasa/core/utils/rupiah_input_formatter.dart';

/// Dialog "Kas Awal" yang muncul saat kasir membuka halaman Order.
///
/// Mengembalikan nominal kas yang diisi, atau `null` bila kasir memilih
/// "Lewati" maupun menutup dialog.
class OpeningCashDialog extends StatefulWidget {
  const OpeningCashDialog({super.key, this.onConfirm});
  final Future<String?> Function(int amount)? onConfirm;

  /// Menampilkan dialog dan menunggu jawaban kasir.
  static Future<int?> show(
    BuildContext context, {
    Future<String?> Function(int amount)? onConfirm,
  }) {
    return showDialog<int>(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.c0F0F0F.withAlpha(90),
      builder: (_) => OpeningCashDialog(onConfirm: onConfirm),
    );
  }

  @override
  State<OpeningCashDialog> createState() => _OpeningCashDialogState();
}

class _OpeningCashDialogState extends State<OpeningCashDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Membaca angka yang diketik, mengabaikan titik pemisah ribuan.
  int? get _amount {
    final String digits = _controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    return digits.isEmpty ? null : int.parse(digits);
  }

  Future<void> _submit() async {
    if (_saving) return;
    final amount = _amount;
    if (amount == null) {
      setState(
        () => _error = 'Masukkan nominal kas, termasuk 0 bila tanpa modal.',
      );
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final error = await widget.onConfirm?.call(amount);
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(amount);
      return;
    }
    setState(() {
      _saving = false;
      _error = error;
    });
  }

  void _skip() {
    if (!_saving) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_saving,
      child: Dialog(
        backgroundColor: AppColors.cFFFFFF,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 560.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _DialogHeader(onClose: _skip),
              Padding(
                padding: EdgeInsets.fromLTRB(28.w, 26.h, 28.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _AmountField(controller: _controller, onSubmitted: _submit),
                    if (_error != null)
                      Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(height: 14.h),
                    Text(
                      '**Uang Kas yang dipegang kasir sebagai modal kembalian',
                      style: AppTextStyles.caption.copyWith(
                        fontStyle: FontStyle.italic,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 26.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: _skip,
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.c097BC2,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            minimumSize: const Size(0, 52),
                            textStyle: AppTextStyles.button.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: const Text('Lewati'),
                        ),
                        SizedBox(width: 12.w),
                        SizedBox(
                          height: 52.h,
                          width: 196.w,
                          child: ElevatedButton(
                            onPressed: _saving ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.cFF8227,
                              foregroundColor: AppColors.cFFFFFF,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              textStyle: AppTextStyles.button.copyWith(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            child: Text(_saving ? 'Menyimpan…' : 'Masuk'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.c367AA0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(28.w, 16.h, 16.w, 16.h),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Kas Awal',
                style: AppTextStyles.heading.copyWith(
                  color: AppColors.cFFFFFF,
                  fontSize: 21.sp,
                ),
              ),
            ),
            IconButton(
              onPressed: onClose,
              tooltip: 'Tutup',
              icon: Icon(
                Icons.cancel_outlined,
                color: AppColors.cFFFFFF,
                size: 30.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmountField extends StatelessWidget {
  const _AmountField({required this.controller, required this.onSubmitted});

  final TextEditingController controller;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      keyboardType: TextInputType.number,
      inputFormatters: const <TextInputFormatter>[RupiahInputFormatter()],
      onSubmitted: (_) => onSubmitted(),
      style: AppTextStyles.body.copyWith(fontSize: 18.sp),
      decoration: InputDecoration(
        hintText: formatRupiah(0),
        hintStyle: AppTextStyles.body.copyWith(
          fontSize: 18.sp,
          color: AppColors.cA4A4A4,
        ),
        filled: true,
        fillColor: AppColors.cFFFFFF,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        enabledBorder: _border(AppColors.cD1D1D1),
        focusedBorder: _border(AppColors.c097BC2),
      ),
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(color: color),
  );
}
