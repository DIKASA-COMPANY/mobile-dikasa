import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const browserBlue = Color(0xff529dc8),
    browserSide = Color(0xff367aa0),
    browserInk = Color(0xff656565),
    browserAction = Color(0xff077cd3);

/// Original exported SVGs, displayed at their natural root dimensions.
class BrowserDesignIcon extends StatelessWidget {
  const BrowserDesignIcon(this.name, {super.key});
  final String name;
  @override
  Widget build(BuildContext context) {
    final size = <String, Size>{
      'back': const Size(32, 25),
      'menu': const Size(34.4, 26),
      'lock': const Size(46, 46),
      'lock-background': const Size(54, 54),
      'search': const Size(19, 19),
      'add': const Size(24, 24),
      'down': const Size(18.093, 10.0653),
      'edit': const Size(22, 22.0007),
      'check': const Size(53, 51),
      'success-line': const Size(446, 2),
      'row-line': const Size(1248, 1),
      'panel-line': const Size(624, 1),
      'summary-line': const Size(450.01, 1),
    }[name]!;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: SvgPicture.asset(
        {
              'back': 'assets/icons/catalog_back.svg',
              'menu': 'assets/icons/catalog_menu.svg',
              'lock': 'assets/icons/catalog_lock.svg',
              'lock-background':
                  'assets/icons/report_design_lock-background.svg',
              'search': 'assets/icons/catalog_search.svg',
            }[name] ??
            'assets/icons/batch_one_$name.svg',
      ),
    );
  }
}

String browserDate(dynamic value) {
  final d = DateTime.tryParse(
    value?.toString() ?? '',
  )?.toUtc().add(const Duration(hours: 7));
  if (d == null) return '—';
  return '${d.day}/${d.month}/${d.year}  ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}

class BrowserToolbar extends StatelessWidget {
  const BrowserToolbar({
    super.key,
    required this.title,
    required this.search,
    required this.actions,
    required this.onBack,
  });
  final String title;
  final Widget search;
  final List<Widget> actions;
  final VoidCallback? onBack;
  @override
  Widget build(BuildContext c) => LayoutBuilder(
    builder: (c, s) {
      final wide = s.maxWidth >= 1150;
      final heading = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Kembali',
            onPressed: onBack,
            icon: const BrowserDesignIcon('back'),
          ),
          SizedBox(width: wide ? 58 : 12),
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
      return Container(
        color: browserSide,
        padding: EdgeInsets.symmetric(horizontal: wide ? 46 : 12, vertical: 20),
        child: wide
            ? Row(
                children: [
                  SizedBox(
                    width: title == 'Daftar Order' ? 373 : 479,
                    child: heading,
                  ),
                  Expanded(child: search),
                  const SizedBox(width: 24),
                  ...actions.expand((w) => [w, const SizedBox(width: 24)]),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  heading,
                  const SizedBox(height: 12),
                  search,
                  const SizedBox(height: 12),
                  Wrap(spacing: 12, runSpacing: 8, children: actions),
                ],
              ),
      );
    },
  );
}

class BrowserSearch extends StatelessWidget {
  const BrowserSearch({
    super.key,
    required this.controller,
    required this.hint,
    required this.onSearch,
  });
  final TextEditingController controller;
  final String hint;
  final VoidCallback? onSearch;
  @override
  Widget build(BuildContext c) => SizedBox(
    height: 46,
    child: TextField(
      controller: controller,
      enabled: onSearch != null,
      textInputAction: TextInputAction.search,
      onSubmitted: (_) => onSearch?.call(),
      maxLength: 100,
      decoration: InputDecoration(
        counterText: '',
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.italic,
          color: Color(0xff9b9b9b),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        prefixIcon: IconButton(
          tooltip: 'Cari',
          onPressed: onSearch,
          icon: const BrowserDesignIcon('search'),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

/// A horizontally scrollable table retains readable text at narrow widths.
class BrowserTable extends StatelessWidget {
  const BrowserTable({
    super.key,
    required this.headers,
    required this.fractions,
    required this.rows,
    this.leftPadding,
    this.fontSize = 16,
  });
  final List<String> headers;
  final List<double> fractions;
  final List<List<Widget>> rows;
  final List<double>? leftPadding;
  final double fontSize;
  @override
  Widget build(BuildContext c) => LayoutBuilder(
    builder: (c, s) => SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: math.max(1248, s.maxWidth),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                Container(
                  color: browserBlue,
                  constraints: const BoxConstraints(minHeight: 73),
                  child: Row(
                    children: [
                      for (var i = 0; i < headers.length; i++)
                        Expanded(
                          flex: (fractions[i] * 1000).round(),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              leftPadding?[i] ?? 22,
                              18,
                              16,
                              18,
                            ),
                            child: Text(
                              headers[i],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                for (var index = 0; index < rows.length; index++)
                  Container(
                    color: const Color(0xfff4f4f4),
                    child: Column(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 73),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: fontSize,
                              color: browserInk,
                              fontWeight: FontWeight.w500,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (var i = 0; i < headers.length; i++)
                                  Expanded(
                                    flex: (fractions[i] * 1000).round(),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        leftPadding?[i] ??
                                            (i == headers.length - 1 &&
                                                    headers.last.isEmpty
                                                ? 6
                                                : 22),
                                        18,
                                        i == headers.length - 1 &&
                                                headers.last.isEmpty
                                            ? 6
                                            : 16,
                                        18,
                                      ),
                                      child: rows[index][i],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        if (index < rows.length - 1)
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: BrowserDesignIcon('row-line'),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class BrowserFooter extends StatelessWidget {
  const BrowserFooter({
    super.key,
    required this.page,
    required this.total,
    this.onPrevious,
    this.onNext,
  });
  final int page, total;
  final VoidCallback? onPrevious, onNext;
  @override
  Widget build(BuildContext c) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          children: [
            Text(
              '$total hasil • Halaman $page',
              style: const TextStyle(color: browserInk),
            ),
            TextButton(onPressed: onPrevious, child: const Text('Sebelumnya')),
            TextButton(onPressed: onNext, child: const Text('Berikutnya')),
          ],
        ),
        const Text(
          'Powered By Dikasa',
          style: TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            color: Color(0xffb5b5b5),
          ),
        ),
      ],
    ),
  );
}
