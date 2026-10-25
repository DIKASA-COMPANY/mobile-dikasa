import 'dart:convert';
import 'package:flutter/material.dart';
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
                    tooltip: 'Kembali ke kasir',
                    onPressed: onBack,
                    icon: const BrowserDesignIcon('menu'),
                  ),
                  SizedBox(width: wide ? 52 : 12),
                  Container(
                    width: wide ? 158 : 145,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: browserAction,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (wide)
                    Container(
                      width: 158,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: browserAction, width: 2),
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(10),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => ScaffoldMessenger.of(c).showSnackBar(
                          const SnackBar(
                            content: Text('Notifikasi belum tersedia.'),
                          ),
                        ),
                        child: const Text(
                          'Notifikasi',
                          style: TextStyle(fontSize: 18, color: browserAction),
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
              top: 17,
              child: Row(
                children: [
                  if (wide) ...[
                    SizedBox(
                      width: 240,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            user?.outletName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              color: browserInk,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            user?.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              color: browserInk,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 18),
                  ],
                  Container(
                    width: 60,
                    height: 55,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xffdddddd)),
                      borderRadius: BorderRadius.circular(8),
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
        style: const TextStyle(color: browserAction, fontSize: 22),
      ),
    );
    if (url == null) return fallback;
    if (url.startsWith('data:image/')) {
      try {
        return Image.memory(
          base64Decode(url.split(',').last),
          fit: BoxFit.cover,
          errorBuilder: (_, e, s) => fallback,
        );
      } catch (_) {
        return fallback;
      }
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, e, s) => fallback,
    );
  }
}
