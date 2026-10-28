import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_loading_indicator.dart';

class AsyncStateView extends StatelessWidget {
  const AsyncStateView({
    super.key,
    required this.loading,
    required this.child,
    this.error,
    this.empty = false,
    this.loadingLabel,
    this.emptyMessage = 'Belum ada data.',
    this.onRetry,
  });

  final bool loading;
  final String? error;
  final bool empty;
  final String? loadingLabel;
  final String emptyMessage;
  final VoidCallback? onRetry;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: AppLoadingIndicator(label: loadingLabel));
    }
    if (error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_off_outlined, size: 44.r),
              SizedBox(height: 12.h),
              Text(
                error!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp),
              ),
              if (onRetry != null) ...[
                SizedBox(height: 16.h),
                FilledButton(
                  onPressed: onRetry,
                  child: const Text('Coba lagi'),
                ),
              ],
            ],
          ),
        ),
      );
    }
    if (empty) {
      return Center(
        child: Text(
          emptyMessage,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sp),
        ),
      );
    }
    return child;
  }
}
