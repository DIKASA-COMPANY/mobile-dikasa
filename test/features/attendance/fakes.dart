import 'package:mobile_dikasa/features/attendance/fingerprint_service.dart';
import 'package:mobile_dikasa/features/attendance/models.dart';
import 'package:mobile_dikasa/features/attendance/repository.dart';

class FakeAttendanceRepository implements AttendanceRepository {
  DateTime now = DateTime.utc(2026, 11, 3, 2, 42);
  AttendanceEntry? entry;
  Object? failure;
  bool enrolled = false;
  int writes = 0;
  @override
  Future<List<StaffMember>> employees() async => [
    StaffMember(
      id: 'staff',
      name: 'Jane Doe',
      hasPin: true,
      fingerprintEnrolled: enrolled,
    ),
    const StaffMember(
      id: 'coworker',
      name: 'Budi',
      hasPin: true,
      fingerprintEnrolled: false,
    ),
  ];
  @override
  Future<AttendanceStatus> status(String employeeId) async =>
      AttendanceStatus(entry, now);
  @override
  Future<List<AttendanceEntry>> history(
    String from,
    String to, {
    String? employeeId,
  }) async => entry == null ? [] : [entry!];
  AttendanceEntry punch(
    String employee,
    AttendanceAction action,
    String method,
  ) {
    writes++;
    if (failure != null) throw failure!;
    entry = AttendanceEntry(
      id: 'record',
      employeeId: employee,
      employeeName: 'Jane Doe',
      workDate: workDate(now),
      clockIn: entry?.clockIn ?? now,
      clockOut: action == AttendanceAction.clockOut
          ? now.add(const Duration(hours: 8))
          : null,
      inMethod: entry?.inMethod ?? method,
      outMethod: action == AttendanceAction.clockOut ? method : null,
    );
    return entry!;
  }

  @override
  Future<AttendanceEntry> pin(
    String employeeId,
    AttendanceAction action,
    String pin,
  ) async => punch(employeeId, action, 'pin');
  @override
  Future<void> enroll(String pin, String publicKey) async {
    if (failure != null) throw failure!;
    enrolled = true;
  }

  @override
  Future<FingerprintChallenge> challenge(AttendanceAction action) async =>
      FingerprintChallenge(action.name, 'server-payload');
  @override
  Future<AttendanceEntry> biometric(
    String challengeId,
    String signature,
  ) async => punch(
    'staff',
    challengeId == AttendanceAction.clockIn.name
        ? AttendanceAction.clockIn
        : AttendanceAction.clockOut,
    'fingerprint',
  );
}

class FakeFingerprint implements FingerprintService {
  bool supported = true, cancel = false;
  String? signedPayload;
  @override
  Future<bool> available() async => supported;
  @override
  Future<String> enroll(String accountId) async => 'public-key';
  @override
  Future<String> sign(String accountId, String payload) async {
    if (cancel) throw const FingerprintFailure('Pemindaian dibatalkan.');
    signedPayload = payload;
    return 'signature';
  }
}
