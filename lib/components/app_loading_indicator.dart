import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.label,
    this.compact = false,
    this.color,
  });

  final String? label;
  final bool compact;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final indicator = SizedBox.square(
      dimension: compact ? 20.r : 32.r,
      child: CircularProgressIndicator(strokeWidth: 2.5.w, color: color),
    );
    if (label == null) return indicator;
    return Semantics(
      label: label,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          indicator,
          SizedBox(width: 12.w),
          Flexible(
            child: Text(label!, style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}

class AppLinearLoadingIndicator extends StatelessWidget {
  const AppLinearLoadingIndicator({super.key, this.minHeight = 4});

  final double minHeight;

  @override
  Widget build(BuildContext context) =>
      LinearProgressIndicator(minHeight: minHeight.h, semanticsLabel: 'Memuat');
}
