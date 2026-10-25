import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mobile_dikasa/data/models/sales_report.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';
import 'report_header.dart';

/// Independent axes keep transaction counts distinct from signed whole-Rupiah values.
class DailySalesChart extends StatefulWidget {
  const DailySalesChart({super.key, required this.points});
  final List<DailyReportPoint> points;
  @override
  State<DailySalesChart> createState() => _ChartState();
}

class _ChartState extends State<DailySalesChart> {
  int? selected;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Wrap(
        spacing: 24,
        runSpacing: 8,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ReportIcon('legend-transactions'),
              const SizedBox(width: 10),
              const Text(
                'Transaksi / hari (kiri)',
                style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ReportIcon('legend-money'),
              const SizedBox(width: 10),
              const Text(
                'Penjualan bersih Rp (kanan)',
                style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 12),
      LayoutBuilder(
        builder: (context, constraints) => MouseRegion(
          onHover: (e) {
            if (widget.points.isEmpty) return;
            final n =
                ((e.localPosition.dx - 44) /
                        (constraints.maxWidth - 112) *
                        (widget.points.length - 1))
                    .round()
                    .clamp(0, widget.points.length - 1);
            if (n != selected) setState(() => selected = n);
          },
          child: GestureDetector(
            onTapDown: (e) {
              if (widget.points.isEmpty) return;
              setState(
                () => selected =
                    ((e.localPosition.dx - 44) /
                            (constraints.maxWidth - 112) *
                            (widget.points.length - 1))
                        .round()
                        .clamp(0, widget.points.length - 1),
              );
            },
            child: SizedBox(
              height: 240,
              width: double.infinity,
              child: CustomPaint(
                painter: _DailyPainter(widget.points, selected),
              ),
            ),
          ),
        ),
      ),
      if (selected != null && selected! < widget.points.length)
        Text(
          '${widget.points[selected!].date}: ${widget.points[selected!].count} transaksi • ${formatRupiah(widget.points[selected!].net, prefix: 'Rp ')} bersih',
        ),
      ExpansionTile(
        title: const Text('Lihat angka harian', style: TextStyle(fontSize: 13)),
        children: [
          for (final p in widget.points)
            Semantics(
              label: '${p.date}, ${p.count} transaksi, ${p.net} Rupiah bersih',
              child: ListTile(
                dense: true,
                title: Text(p.date),
                subtitle: Text(
                  '${p.count} transaksi • refund ${formatRupiah(p.refunds, prefix: 'Rp ')}',
                ),
                trailing: Text(formatRupiah(p.net, prefix: 'Rp ')),
              ),
            ),
        ],
      ),
    ],
  );
}

class _DailyPainter extends CustomPainter {
  _DailyPainter(this.data, this.selected);
  final List<DailyReportPoint> data;
  final int? selected;
  @override
  void paint(Canvas c, Size s) {
    final area = Rect.fromLTRB(44, 22, s.width - 68, s.height - 32);
    if (area.width <= 0) return;
    void text(String t, Offset p, {bool right = false}) {
      final tp = TextPainter(
        text: TextSpan(
          text: t,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 9,
            color: Color(0xff888888),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(c, Offset(right ? p.dx - tp.width : p.dx, p.dy));
    }

    final maxCount = math.max(
      1,
      data.fold<int>(0, (a, p) => math.max(a, p.count)),
    );
    var low = math
            .min(0, data.fold<int>(0, (a, p) => math.min(a, p.net)))
            .toDouble(),
        high = math
            .max(1, data.fold<int>(0, (a, p) => math.max(a, p.net)))
            .toDouble();
    if (high == low) high = low + 1;
    for (var i = 0; i <= 5; i++) {
      final y = area.top + area.height * i / 5;
      c.drawLine(
        Offset(area.left, y),
        Offset(area.right, y),
        Paint()
          ..color = const Color(0xffcccccc)
          ..strokeWidth = .7,
      );
      text(
        (maxCount * (1 - i / 5)).round().toString(),
        Offset(area.left - 8, y - 6),
        right: true,
      );
      final money = (high - (high - low) * i / 5).round();
      text(
        money.abs() >= 1000000
            ? '${(money / 1000000).toStringAsFixed(1)}jt'
            : money.abs() >= 1000
            ? '${(money / 1000).toStringAsFixed(1)}rb'
            : money.toString(),
        Offset(area.right + 6, y - 6),
      );
    }
    if (data.isEmpty) return;
    for (var series = 0; series < 2; series++) {
      final paint = Paint()
        ..color = (series == 0
            ? const Color(0xffff8227)
            : const Color(0xffa0cfe3))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8;
      final path = Path();
      for (var i = 0; i < data.length; i++) {
        final x =
            area.left +
            area.width * (data.length == 1 ? 0.5 : i / (data.length - 1));
        final ratio = series == 0
            ? data[i].count / maxCount
            : (data[i].net - low) / (high - low);
        final y = area.bottom - area.height * ratio;
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
        if (data.length <= 40 || selected == i) {
          c.drawCircle(
            Offset(x, y),
            selected == i ? 4 : 2.7,
            Paint()..color = paint.color,
          );
        }
        if (series == 0 &&
            (i == 0 ||
                i == data.length - 1 ||
                i % math.max(1, (data.length / 6).ceil()) == 0)) {
          text(data[i].date.substring(5), Offset(x - 10, area.bottom + 9));
        }
      }
      c.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DailyPainter old) =>
      old.data != data || old.selected != selected;
}
