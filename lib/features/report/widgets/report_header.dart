import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_dikasa/data/models/user.dart';

const reportBlue = Color(0xff529dc8),
    reportDark = Color(0xff2c5e7a),
    reportSide = Color(0xff367aa0),
    reportSelected = Color(0xff27a7ef);

/// Exact local Figma SVGs retain natural root geometry; wrappers do not stretch them.
class ReportIcon extends StatelessWidget {
  const ReportIcon(this.name, {super.key});
  final String name;
  @override
  Widget build(BuildContext c) {
    final sizes = <String, Size>{
      'menu': const Size(34.4, 26),
      'lock': const Size(46, 46),
      'lock-background': const Size(54, 54),
      'back': const Size(32, 25),
      'calendar': const Size(19.5724, 18.8023),
      'export': const Size(20, 20),
      'search': const Size(19, 19),
      'down': const Size(20.2314, 10.0653),
      'legend-transactions': const Size(11.9543, 12),
      'legend-money': const Size(11.9543, 12),
    };
    final size = sizes[name]!;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: SvgPicture.asset('assets/icons/report_design_$name.svg'),
    );
  }
}

class ReportHeader extends StatelessWidget implements PreferredSizeWidget {
  const ReportHeader({super.key, this.user, required this.onBack, this.onLock});
  final User? user;
  final VoidCallback onBack;
  final VoidCallback? onLock;
  @override
  Size get preferredSize => const Size.fromHeight(88);
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (c, size) {
      final wide = size.maxWidth >= 1000;
      return Container(
        height: 88,
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
              top: 20,
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBack,
                    tooltip: 'Kembali ke kasir',
                    icon: const ReportIcon('menu'),
                  ),
                  SizedBox(width: wide ? 52 : 12),
                  Container(
                    width: wide ? 158 : 110,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xff077cd3),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Laporan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  if (wide)
                    Container(
                      width: 158,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xff077cd3),
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(10),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Notifikasi belum tersedia.'),
                              ),
                            ),
                        child: const Text(
                          'Notifikasi',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (onLock != null)
              Positioned(
                left: wide ? size.maxWidth * .59 : null,
                right: wide ? null : 70,
                top: 17,
                child: Tooltip(
                  message: 'Kunci layar',
                  child: InkWell(
                    onTap: onLock,
                    child: const SizedBox(
                      width: 54,
                      height: 54,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ReportIcon('lock-background'),
                          ReportIcon('lock'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              right: wide ? 32 : 12,
              top: 17,
              child: Row(
                children: [
                  if (wide) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          user?.outletName ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff656565),
                          ),
                        ),
                        Text(
                          user?.name ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            color: Color(0xff656565),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 18),
                  ],
                  Container(
                    width: 60,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xffdddddd)),
                    ),
                    child: Text(
                      user?.initials ?? '?',
                      style: const TextStyle(
                        fontSize: 22,
                        color: reportSide,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
