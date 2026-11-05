import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/features/attendance/view.dart';
import 'package:mobile_dikasa/features/attendance/view_model.dart';
import 'package:mobile_dikasa/features/attendance/models.dart';
import 'package:mobile_dikasa/features/attendance/report_view_model.dart';
import 'fakes.dart';

void main() {
  for (final size in [
    const Size(1340, 800),
    const Size(800, 600),
    const Size(390, 844),
  ]) {
    testWidgets('attendance PIN, fingerprint and assets render at $size', (
      t,
    ) async {
      t.view.physicalSize = size;
      t.view.devicePixelRatio = 1;
      addTearDown(t.view.reset);
      final repo = FakeAttendanceRepository();
      final vm = AttendanceViewModel(
        repository: repo,
        fingerprint: FakeFingerprint(),
        accountId: 'staff',
      );
      final boundary = GlobalKey();
      await t.pumpWidget(
        MaterialApp(
          home: RepaintBoundary(
            key: boundary,
            child: AttendanceView(
              viewModel: vm,
              createReportViewModel: () => AttendanceReportViewModel(repo),
            ),
          ),
        ),
      );
      await t.pumpAndSettle();
      expect(find.text('Absensi Pegawai'), findsOneWidget);
      expect(t.takeException(), isNull);
      if (const bool.fromEnvironment('CAPTURE_ATTENDANCE') &&
          size.width >= 700) {
        await _capture(t, boundary, 'choose-${size.width.toInt()}');
      }
      vm.chooseMethod(AttendanceMethod.pin);
      await t.pumpAndSettle();
      for (final digit in '123456'.split('')) {
        vm.digit(digit);
      }
      await t.pump();
      expect(find.text('123456'), findsNothing);
      expect(t.takeException(), isNull);
      if (const bool.fromEnvironment('CAPTURE_ATTENDANCE') &&
          size.width >= 700) {
        await _capture(t, boundary, 'pin-${size.width.toInt()}');
      }
      await vm.submit(AttendanceAction.clockIn);
      await t.pumpAndSettle();
      expect(find.text('09:42'), findsWidgets);
      expect(t.takeException(), isNull);
      repo.enrolled = true;
      await vm.load();
      vm.chooseMethod(AttendanceMethod.fingerprint);
      await t.pumpAndSettle();
      expect(
        find.byWidgetPredicate(
          (w) =>
              w is Image &&
              w.image is AssetImage &&
              (w.image as AssetImage).assetName.endsWith(
                'fingerprint_scan.png',
              ),
        ),
        findsOneWidget,
      );
      expect(t.takeException(), isNull);
      if (const bool.fromEnvironment('CAPTURE_ATTENDANCE') &&
          size.width >= 700) {
        await _capture(t, boundary, 'fingerprint-${size.width.toInt()}');
      }
      await t.pumpWidget(const SizedBox.shrink());
    });
  }
}

Future<void> _capture(WidgetTester t, GlobalKey key, String name) async {
  final render =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await t.runAsync(() async {
    final image = await render.toImage();
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final file = File('build/attendance/$name.png');
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes!.buffer.asUint8List());
    image.dispose();
  });
}
