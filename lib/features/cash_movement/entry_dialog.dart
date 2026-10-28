import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_loading_indicator.dart';
import 'package:flutter/services.dart';
import '../../data/services/account_files.dart';
import 'controller.dart';
import 'design.dart';

class CashMovementEntry extends StatefulWidget {
  const CashMovementEntry({
    super.key,
    required this.controller,
    this.files = const AccountFiles(),
  });
  final CashMovementController controller;
  final AccountFiles files;
  @override
  State<CashMovementEntry> createState() => _EntryState();
}

class _EntryState extends State<CashMovementEntry> {
  final form = GlobalKey<FormState>();
  final name = TextEditingController(),
      amount = TextEditingController(),
      reason = TextEditingController();
  String? kind, filename;
  Uint8List? bytes;
  bool dirty = false;
  CashMovementController get c => widget.controller;
  @override
  void dispose() {
    name.dispose();
    amount.dispose();
    reason.dispose();
    bytes = null;
    super.dispose();
  }

  Future<void> cancel() async {
    if (c.busy) return;
    if (c.uncertain) {
      Navigator.pop(context, false);
      return;
    }
    if (dirty) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (x) => AlertDialog(
          title: const Text('Buang perubahan?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(x, false),
              child: const Text('Lanjut Edit'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(x, true),
              child: const Text('Buang'),
            ),
          ],
        ),
      );
      if (ok != true) return;
    }
    if (mounted) Navigator.pop(context, false);
  }

  Future<void> pick() async {
    try {
      final f = await widget.files.pickImage();
      if (!mounted || !c.current || f == null) return;
      setState(() {
        bytes = f.bytes;
        filename = f.name;
        dirty = true;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pilih PNG/JPEG valid maksimal3 MiB,4096 px/16 MP.'),
          ),
        );
      }
    }
  }

  Widget field(
    String label,
    String icon,
    TextEditingController controller, {
    bool money = false,
  }) => TextFormField(
    controller: controller,
    enabled: !c.locked,
    onChanged: (_) => dirty = true,
    keyboardType: money ? TextInputType.number : TextInputType.text,
    inputFormatters: money ? [FilteringTextInputFormatter.digitsOnly] : null,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Padding(padding: EdgeInsets.all(12.r), child: CashIcon(icon)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Color(0xffe6e6e6)),
      ),
    ),
    validator: (v) {
      final text = (v ?? '').trim();
      if (text.isEmpty) return 'Wajib diisi';
      if (money) {
        final n = int.tryParse(text);
        if (n == null || n < 1 || n > 9007199254740991) {
          return 'Nominal Rupiah bulat positif tidak valid';
        }
      } else if (text.runes.length > (controller == name ? 120 : 500)) {
        return 'Teks terlalu panjang';
      }
      return null;
    },
  );
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: c,
    builder: (context, _) => !c.current
        ? AlertDialog(
            title: const Text('Sesi akun berubah'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali'),
              ),
            ],
          )
        : PopScope(
            canPop: !c.locked && !dirty,
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) cancel();
            },
            child: Theme(
              data: Theme.of(context).copyWith(
                textTheme: Theme.of(
                  context,
                ).textTheme.apply(fontFamily: 'Poppins'),
              ),
              child: Dialog(
                backgroundColor: const Color(0xfff8f8f8),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: SizedBox(
                  width: 986.w,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.sizeOf(context).height * .90,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: const Color(0xff367aa0),
                          padding: EdgeInsets.symmetric(
                            horizontal: 28.w,
                            vertical: 12.h,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Tambah Transaksi Kas Kasir',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: c.busy ? null : cancel,
                                icon: const CashIcon('close'),
                              ),
                            ],
                          ),
                        ),
                        if (c.busy) const AppLinearLoadingIndicator(),
                        Flexible(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(28.r),
                            child: Form(
                              key: form,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (c.error != null)
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 18.h),
                                      child: Text(
                                        c.error!,
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  LayoutBuilder(
                                    builder: (context, s) {
                                      final left = Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Informasi Transaksi Kas',
                                            style: TextStyle(fontSize: 18.sp),
                                          ),
                                          SizedBox(height: 22.h),
                                          field('Nama Transaksi', 'name', name),
                                          SizedBox(height: 16.h),
                                          field(
                                            'Nominal',
                                            'amount',
                                            amount,
                                            money: true,
                                          ),
                                          SizedBox(height: 16.h),
                                          DropdownButtonFormField<String>(
                                            isExpanded: true,
                                            initialValue: kind,
                                            hint: const Text(
                                              '-- Pilih Jenis Transaksi --',
                                            ),
                                            icon: const CashIcon('down'),
                                            decoration: InputDecoration(
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.all(12.r),
                                                child: CashIcon('type'),
                                              ),
                                              filled: true,
                                              fillColor: const Color(
                                                0xffeeeeee,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                            ),
                                            items: const [
                                              DropdownMenuItem(
                                                value: 'in',
                                                child: Text('Uang Masuk'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'out',
                                                child: Text('Uang Keluar'),
                                              ),
                                            ],
                                            onChanged: c.locked
                                                ? null
                                                : (v) {
                                                    kind = v;
                                                    dirty = true;
                                                  },
                                            validator: (v) => v == null
                                                ? 'Pilih jenis transaksi'
                                                : null,
                                          ),
                                          SizedBox(height: 16.h),
                                          field(
                                            'Alasan / Catatan',
                                            'note',
                                            reason,
                                          ),
                                        ],
                                      );
                                      final right = Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          if (c.activity?.canUploadProof ==
                                              true)
                                            InkWell(
                                              onTap: c.locked ? null : pick,
                                              child: Container(
                                                height: 240.h,
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xffe6e6e6,
                                                  ),
                                                  border: Border.all(
                                                    color: const Color(
                                                      0xffbbbbbb,
                                                    ),
                                                    width: 2.w,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        10.r,
                                                      ),
                                                ),
                                                child: bytes == null
                                                    ? Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          CashIcon('camera'),
                                                          SizedBox(
                                                            height: 18.h,
                                                          ),
                                                          Text(
                                                            'Upload Foto Bukti',
                                                          ),
                                                        ],
                                                      )
                                                    : Image.memory(
                                                        bytes!,
                                                        fit: BoxFit.contain,
                                                      ),
                                              ),
                                            ),
                                          if (bytes != null)
                                            TextButton(
                                              onPressed: c.locked
                                                  ? null
                                                  : () => setState(() {
                                                      bytes = null;
                                                      dirty = true;
                                                    }),
                                              child: const Text('Hapus Foto'),
                                            ),
                                          SizedBox(height: 20.h),
                                          Wrap(
                                            alignment: WrapAlignment.end,
                                            spacing: 16,
                                            runSpacing: 12,
                                            children: [
                                              OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  foregroundColor: const Color(
                                                    0xff9d1414,
                                                  ),
                                                  side: BorderSide(
                                                    color: Color(0xff9d1414),
                                                    width: 2.w,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 30.w,
                                                    vertical: 18.h,
                                                  ),
                                                ),
                                                onPressed: c.busy
                                                    ? null
                                                    : cancel,
                                                child: Text(
                                                  c.uncertain
                                                      ? 'Kembali'
                                                      : 'Batal',
                                                ),
                                              ),
                                              FilledButton(
                                                style: FilledButton.styleFrom(
                                                  backgroundColor: cashOrange,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 32.w,
                                                    vertical: 20.h,
                                                  ),
                                                ),
                                                onPressed: c.locked
                                                    ? null
                                                    : () async {
                                                        if (!form.currentState!
                                                            .validate()) {
                                                          return;
                                                        }
                                                        final ok = await c
                                                            .create(
                                                              kind: kind!,
                                                              name: name.text,
                                                              amount: int.parse(
                                                                amount.text,
                                                              ),
                                                              reason:
                                                                  reason.text,
                                                              bytes: bytes,
                                                              filename:
                                                                  filename,
                                                            );
                                                        if (ok &&
                                                            context.mounted) {
                                                          Navigator.pop(
                                                            context,
                                                            true,
                                                          );
                                                        }
                                                      },
                                                child: const Text('Simpan'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                      return s.maxWidth >= 760
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(child: left),
                                                SizedBox(width: 48.w),
                                                Expanded(child: right),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                left,
                                                SizedBox(height: 24.h),
                                                right,
                                              ],
                                            );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
  );
}
