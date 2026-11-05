import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable left navigation shell that retains each existing destination.
class NavigationSidebar extends StatelessWidget {
  const NavigationSidebar({super.key, required this.destinations});
  final List<Widget> destinations;
  @override
  Widget build(BuildContext context) => Drawer(
    width: 310.w.clamp(260, 350).toDouble(),
    backgroundColor: Colors.white,
    child: SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Image.asset(
              'assets/images/dikasa_logo.png',
              height: 44.h,
              alignment: Alignment.centerLeft,
            ),
          ),
          const Divider(),
          ...destinations,
        ],
      ),
    ),
  );
}
