import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/utils/screen_utils.dart';

class _ScreenUtilTestObserver with WidgetsBindingObserver {
  _ScreenUtilTestObserver(this.binding);

  final TestWidgetsFlutterBinding binding;

  void configure() {
    final view = binding.platformDispatcher.implicitView;
    if (view == null || view.physicalSize.isEmpty) return;
    ScreenUtil.configure(
      data: MediaQueryData.fromView(view),
      designSize: ScreenConfig.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
    );
  }

  @override
  void didChangeMetrics() => configure();
}

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  final observer = _ScreenUtilTestObserver(binding)..configure();
  binding.addObserver(observer);
  await testMain();
}
