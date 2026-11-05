import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/features/attendance/models.dart';
import 'package:mobile_dikasa/features/attendance/view_model.dart';
import 'package:mobile_dikasa/features/attendance/report_view_model.dart';
import 'fakes.dart';

void main() {
  late FakeAttendanceRepository repository;
  late FakeFingerprint fingerprint;
  late AttendanceViewModel vm;
  setUp(() {
    repository = FakeAttendanceRepository();
    fingerprint = FakeFingerprint();
    vm = AttendanceViewModel(
      repository: repository,
      fingerprint: fingerprint,
      accountId: 'staff',
    );
  });
  tearDown(() => vm.dispose());
  void pin() {
    for (final n in '123456'.split('')) {
      vm.digit(n);
    }
  }

  test(
    'selects logged-in staff and enforces six-digit masked PIN flow',
    () async {
      await vm.load();
      expect(vm.selected?.id, 'staff');
      expect(vm.canClockIn, true);
      expect(vm.canClockOut, false);
      vm.chooseMethod(AttendanceMethod.pin);
      vm.digit('1');
      await vm.submit(AttendanceAction.clockIn);
      expect(repository.writes, 0);
      expect(vm.error, contains('6 digit'));
      vm.clear();
      pin();
      vm.digit('7');
      expect(vm.pin, '123456');
      await vm.submit(AttendanceAction.clockIn);
      expect(vm.entry?.inMethod, 'pin');
      expect(vm.pin, isEmpty);
      expect(vm.canClockIn, false);
      expect(vm.canClockOut, true);
      pin();
      await vm.submit(AttendanceAction.clockOut);
      expect(vm.entry?.clockOut, isNotNull);
      expect(vm.canClockOut, false);
    },
  );
  test(
    'coworker selection clears secret and prevents fingerprint attendance',
    () async {
      await vm.load();
      vm.chooseMethod(AttendanceMethod.pin);
      pin();
      await vm.select(vm.staff.last);
      expect(vm.pin, isEmpty);
      expect(vm.method, isNull);
      expect(vm.canFingerprint, false);
      vm.chooseMethod(AttendanceMethod.fingerprint);
      await vm.submit(AttendanceAction.clockIn);
      expect(repository.writes, 0);
    },
  );
  test(
    'fingerprint enrollment and signed server challenge precede punch',
    () async {
      await vm.load();
      vm.chooseMethod(AttendanceMethod.fingerprint);
      pin();
      await vm.enrollFingerprint();
      expect(vm.selected?.fingerprintEnrolled, true);
      expect(vm.pin, isEmpty);
      fingerprint.cancel = true;
      await vm.submit(AttendanceAction.clockIn);
      expect(repository.writes, 0);
      expect(vm.success, isNull);
      fingerprint.cancel = false;
      await vm.submit(AttendanceAction.clockIn);
      expect(fingerprint.signedPayload, 'server-payload');
      expect(vm.entry?.inMethod, 'fingerprint');
    },
  );
  test(
    'uncertain network write blocks retry until authoritative refresh',
    () async {
      await vm.load();
      vm.chooseMethod(AttendanceMethod.pin);
      pin();
      repository.failure = AttendanceOutcomeUncertain();
      await vm.submit(AttendanceAction.clockIn);
      expect(vm.uncertain, true);
      expect(vm.canClockIn, false);
      expect(vm.error, contains('belum pasti'));
      expect(vm.pin, isEmpty);
      pin();
      await vm.submit(AttendanceAction.clockIn);
      expect(repository.writes, 1);
      repository.failure = null;
      await vm.refresh();
      expect(vm.uncertain, false);
      expect(vm.canClockIn, true);
    },
  );
  test(
    'unsupported hardware retains PIN and report rejects wide date range',
    () async {
      fingerprint.supported = false;
      await vm.load();
      expect(vm.canFingerprint, false);
      expect(vm.canClockIn, true);
      final report = AttendanceReportViewModel(repository, now: repository.now);
      addTearDown(report.dispose);
      await report.load(start: '2026-01-01', end: '2026-12-31');
      expect(report.error, contains('31 hari'));
      expect(report.entries, isEmpty);
    },
  );
  test('WIB day and time are independent from host timezone', () {
    final time = DateTime.utc(2026, 11, 2, 18, 5);
    expect(workDate(time), '2026-11-03');
    expect(attendanceTime(time), '01:05');
  });
}
