import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Masked six-digit input shared by attendance and fingerprint enrollment.
class AttendancePinKeypad extends StatelessWidget {
  const AttendancePinKeypad({
    super.key,
    required this.length,
    required this.enabled,
    required this.onDigit,
    required this.onClear,
    required this.onBackspace,
  });
  final int length;
  final bool enabled;
  final ValueChanged<String> onDigit;
  final VoidCallback onClear, onBackspace;
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Semantics(
        label: 'PIN absensi, $length dari 6 digit terisi',
        child: ExcludeSemantics(
          child: Row(
            children: List.generate(
              6,
              (i) => Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 58.h.clamp(40, 64).toDouble(),
                  decoration: BoxDecoration(
                    color: const Color(0xffeeeeee),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: const Color(0xffd9d9d9)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    i < length ? '●' : '',
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 24.h),
      for (final row in [
        ['1', '2', '3'],
        ['4', '5', '6'],
        ['7', '8', '9'],
        ['C', '0', '⌫'],
      ])
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [
              for (final value in row)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: SizedBox(
                      height: 48.h.clamp(42, 58).toDouble(),
                      child: OutlinedButton(
                        onPressed: !enabled
                            ? null
                            : () {
                                if (value == 'C') {
                                  onClear();
                                } else if (value == '⌫') {
                                  onBackspace();
                                } else {
                                  onDigit(value);
                                }
                              },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: const Color(0xffeeeeee),
                          foregroundColor: value == 'C'
                              ? Colors.red
                              : const Color(0xff666666),
                          side: BorderSide(
                            color: value == 'C'
                                ? Colors.red
                                : Colors.transparent,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: value == '⌫'
                            ? Icon(
                                Icons.backspace_outlined,
                                size: 20.r,
                                semanticLabel: 'Hapus digit terakhir',
                              )
                            : Text(
                                value,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
    ],
  );
}
