import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_remote_image.dart';
import 'package:mobile_dikasa/data/models/user.dart';
import 'browser_design.dart';

class BrowserPageHeader extends StatelessWidget implements PreferredSizeWidget {
  const BrowserPageHeader({
    super.key,
    required this.title,
    required this.user,
    required this.onBack,
    this.onLock,
  });
  final String title;
  final User? user;
  final VoidCallback? onBack, onLock;
  @override
  Size get preferredSize => const Size.fromHeight(88);
  @override
  Widget build(BuildContext c) => LayoutBuilder(
    builder: (c, s) {
      final wide = s.maxWidth >= 1000;
      return Container(
        height: 88.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xfff6f6f6), Colors.white],
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: wide ? 52 : 12,
              top: 20.h,
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Kembali ke kasir',
                    onPressed: onBack,
                    icon: const BrowserDesignIcon('menu'),
                  ),
                  SizedBox(width: wide ? 52 : 12),
                  Container(
                    width: wide ? 158 : 145,
                    height: 46.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: browserAction,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (wide)
                    Container(
                      width: 158.w,
                      height: 46.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: browserAction, width: 2.w),
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10.r),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => ScaffoldMessenger.of(c).showSnackBar(
                          const SnackBar(
                            content: Text('Notifikasi belum tersedia.'),
                          ),
                        ),
                        child: Text(
                          'Notifikasi',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: browserAction,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (onLock != null)
              Positioned(
                left: wide ? s.maxWidth * .59 : null,
                right: wide ? null : 80,
                top: 17.h,
                child: Tooltip(
                  message: 'Kunci layar',
                  child: InkWell(
                    onTap: onLock,
                    child: SizedBox(
                      width: 54.w,
                      height: 54.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          BrowserDesignIcon('lock-background'),
                          BrowserDesignIcon('lock'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              right: wide ? 32 : 12,
              top: 17.h,
              child: Row(
                children: [
                  if (wide) ...[
                    SizedBox(
                      width: 240.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            user?.outletName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: browserInk,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            user?.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: browserInk,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 18.w),
                  ],
                  Container(
                    width: 60.w,
                    height: 55.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xffdddddd)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: _avatar(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
  Widget _avatar() {
    final url = user?.avatarUrl;
    final fallback = Center(
      child: Text(
        user?.initials ?? '?',
        style: TextStyle(color: browserAction, fontSize: 22.sp),
      ),
    );
    if (url == null) return fallback;
    return AppRemoteImage(url: url, fit: BoxFit.cover, fallback: fallback);
  }
}
