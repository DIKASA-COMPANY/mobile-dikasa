import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_dikasa/core/routing/app_routes.dart';
import 'package:mobile_dikasa/data/models/user.dart';

const catalogBlue = Color(0xFF529DC8);
const catalogBar = Color(0xFF367AA0);
const catalogAccent = Color(0xFF077CD3);
const catalogOrange = Color(0xFFFF8227);
const catalogGrey = Color(0xFF656565);

class CatalogPhotoBorder extends CustomPainter {
  const CatalogPhotoBorder();
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          (Offset.zero & size).deflate(1),
          Radius.circular(10.r),
        ),
      );
    final paint = Paint()
      ..color = const Color(0xFFBBBBBB)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    for (final metric in path.computeMetrics()) {
      for (double start = 0; start < metric.length; start += 18) {
        canvas.drawPath(
          metric.extractPath(start, (start + 10).clamp(0, metric.length)),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CatalogPhotoBorder oldDelegate) => false;
}

Widget catalogIcon(String name) {
  const sizes = <String, Size>{
    'add': Size(28.9726, 28),
    'category_add': Size(28.9726, 28),
    'edit': Size(22, 22.3025),
    'back': Size(32, 25),
    'menu': Size(34.4, 26),
    'lock': Size(46, 46),
    'filter': Size(20, 20),
    'search': Size(19, 19),
    'category': Size(24, 24.0001),
    'stock': Size(23.8, 23.8),
    'name': Size(23.5, 23.5),
    'note': Size(22.5439, 23.496),
    'type': Size(20.5548, 21.9996),
    'camera': Size(122.002, 114),
    'wallet': Size(23.8, 22.0874),
    'price': Size(23.7998, 21.7384),
    'down': Size(15.9199, 9.13601),
  };
  final size = sizes[name]!;
  return Center(
    widthFactor: 1,
    heightFactor: 1,
    child: SizedBox(
      width: size.width,
      height: size.height,
      child: SvgPicture.asset('assets/icons/catalog_$name.svg'),
    ),
  );
}

TextStyle catalogText(
  double size, {
  Color color = catalogGrey,
  FontWeight weight = FontWeight.w500,
  bool italic = false,
}) => TextStyle(
  fontFamily: 'Poppins',
  fontSize: size,
  color: color,
  fontWeight: weight,
  fontStyle: italic ? FontStyle.italic : FontStyle.normal,
);

class CatalogButton extends StatelessWidget {
  const CatalogButton(
    this.label, {
    super.key,
    this.onPressed,
    this.color = Colors.white,
    this.icon,
    this.height = 46,
  });
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final String? icon;
  final double height;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: color == Colors.white ? catalogGrey : Colors.white,
        disabledBackgroundColor: color.withValues(alpha: .8),
        disabledForegroundColor: catalogGrey,
        elevation: 2,
        shadowColor: color.withValues(alpha: .2),
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[catalogIcon(icon!), SizedBox(width: 20.w)],
          Flexible(
            child: Text(
              label,
              style: catalogText(
                17,
                color: color == Colors.white ? catalogGrey : Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

class CatalogShell extends StatelessWidget {
  const CatalogShell({
    super.key,
    required this.title,
    required this.actions,
    required this.child,
    this.user,
    this.onBack,
    this.canLeave,
  });
  final String title;
  final List<Widget> actions;
  final Widget child;
  final User? user;
  final VoidCallback? onBack;
  final Future<bool> Function()? canLeave;

  @override
  Widget build(BuildContext context) => Theme(
    data: Theme.of(context).copyWith(
      textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Poppins'),
    ),
    child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, c) => Container(
                height: 88.h,
                color: const Color(0xFFF6F6F6),
                padding: EdgeInsets.symmetric(
                  horizontal: c.maxWidth < 700 ? 16 : 46,
                ),
                child: Row(
                  children: [
                    IconButton(
                      tooltip: 'Kembali ke kasir',
                      onPressed: onBack ?? () => Navigator.maybePop(context),
                      icon: catalogIcon('menu'),
                    ),
                    SizedBox(width: c.maxWidth < 700 ? 12 : 58),
                    Container(
                      height: 46.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: catalogAccent, width: 2.w),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: c.maxWidth < 700 ? 110 : 156,
                            alignment: Alignment.center,
                            color: catalogAccent,
                            child: Text(
                              'Produk',
                              style: catalogText(
                                18,
                                color: Colors.white,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (c.maxWidth > 700)
                            Tooltip(
                              message: 'Belum ada halaman notifikasi produk.',
                              child: SizedBox(
                                width: 156.w,
                                child: Center(
                                  child: Text(
                                    'Notifikasi',
                                    style: catalogText(
                                      18,
                                      color: catalogAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: 'Kunci layar',
                      onPressed: () async {
                        if (canLeave != null && !await canLeave!()) return;
                        if (context.mounted) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.login,
                            (_) => false,
                          );
                        }
                      },
                      icon: catalogIcon('lock'),
                    ),
                    if (c.maxWidth > 850) ...[
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            user?.outletName.isNotEmpty == true
                                ? user!.outletName
                                : 'DIKASA',
                            style: catalogText(18),
                          ),
                          Text(
                            user?.name ?? '',
                            style: catalogText(15, italic: true),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.w),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.asset(
                          'assets/images/avatar_profile_men.png',
                          width: 60.w,
                          height: 60.h,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, c) {
                final small = c.maxWidth < 1320;
                final heading = Row(
                  children: [
                    IconButton(
                      tooltip: 'Kembali',
                      onPressed: onBack ?? () => Navigator.maybePop(context),
                      icon: catalogIcon('back'),
                    ),
                    SizedBox(width: small ? 14 : 58),
                    Text(
                      title,
                      style: catalogText(
                        22,
                        color: Colors.white,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
                return Container(
                  color: catalogBar,
                  padding: EdgeInsets.symmetric(
                    horizontal: small ? 16 : 46,
                    vertical: 20.h,
                  ),
                  child: small
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            heading,
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: actions,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            heading,
                            const Spacer(),
                            ...actions.expand(
                              (w) => [SizedBox(width: 20.w), w],
                            ),
                          ],
                        ),
                );
              },
            ),
            Expanded(child: child),
          ],
        ),
      ),
    ),
  );
}

class CatalogSection extends StatelessWidget {
  const CatalogSection({
    super.key,
    required this.title,
    required this.child,
    this.padding,
  });
  final String title;
  final Widget child;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(10.r),
    child: Container(
      color: const Color(0xFFF8F8F8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 73.h,
            color: catalogBlue,
            padding: EdgeInsets.symmetric(horizontal: 34.w),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: catalogText(
                21,
                color: Colors.white,
                weight: FontWeight.w600,
              ),
            ),
          ),
          Padding(padding: padding ?? EdgeInsets.all(34.r), child: child),
        ],
      ),
    ),
  );
}

Widget catalogError(String message, {VoidCallback? retry}) => Container(
  padding: EdgeInsets.all(16.r),
  margin: EdgeInsets.only(bottom: 16.h),
  decoration: BoxDecoration(
    color: const Color(0xFFFFF0EC),
    borderRadius: BorderRadius.circular(10.r),
  ),
  child: Row(
    children: [
      Expanded(
        child: Text(
          message,
          style: catalogText(15, color: const Color(0xFF9D1414)),
        ),
      ),
      if (retry != null)
        TextButton(onPressed: retry, child: const Text('Coba lagi')),
    ],
  ),
);

Future<bool> catalogConfirm(
  BuildContext context,
  String title,
  String message,
) async =>
    await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(c, true),
            child: const Text('Lanjutkan'),
          ),
        ],
      ),
    ) ??
    false;
