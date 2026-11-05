import 'package:dikasa_api/dikasa_api.dart' as api;
import 'package:dio/dio.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'models.dart';

abstract class AttendanceRepository {
  Future<List<StaffMember>> employees();
  Future<AttendanceStatus> status(String employeeId);
  Future<List<AttendanceEntry>> history(
    String from,
    String to, {
    String? employeeId,
  });
  Future<AttendanceEntry> pin(
    String employeeId,
    AttendanceAction action,
    String pin,
  );
  Future<void> enroll(String pin, String publicKey);
  Future<FingerprintChallenge> challenge(AttendanceAction action);
  Future<AttendanceEntry> biometric(String challengeId, String signature);
}

/// Maps generated transport models at the feature's repository boundary.
class ApiAttendanceRepository implements AttendanceRepository {
  ApiAttendanceRepository(this._api);
  final api.AbsensiApi _api;

  Future<T> _call<T>(
    Future<T> Function() operation, {
    bool mutation = false,
  }) async {
    try {
      return await operation();
    } on DioException catch (error) {
      final status = error.response?.statusCode;
      if (mutation &&
          (status == null ||
              status >= 500 ||
              (status >= 200 && status < 300))) {
        throw AttendanceOutcomeUncertain();
      }
      throw ApiException.fromDio(error);
    } catch (_) {
      if (mutation) throw AttendanceOutcomeUncertain();
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Data absensi dari server tidak lengkap.',
      );
    }
  }

  AttendanceEntry _entry(api.AttendanceRecord r) => AttendanceEntry(
    id: r.id,
    employeeId: r.employeeId,
    employeeName: r.employeeName,
    workDate: r.workDate,
    clockIn: r.clockIn,
    clockOut: r.clockOut,
    inMethod: r.inMethod,
    outMethod: r.outMethod,
  );
  T _required<T>(T? value) {
    if (value == null) throw const FormatException('Missing response');
    return value;
  }

  @override
  Future<List<StaffMember>> employees() => _call(() async {
    final response = _required((await _api.listEmployees()).data);
    return (response.data ?? [])
        .map(
          (s) => StaffMember(
            id: s.id,
            name: s.name,
            hasPin: s.hasPin,
            fingerprintEnrolled: s.fingerprintEnrolled,
          ),
        )
        .toList(growable: false);
  });
  @override
  Future<AttendanceStatus> status(String employeeId) => _call(() async {
    final response = _required(
      (await _api.getAttendanceStatus(employeeId: employeeId)).data,
    );
    return AttendanceStatus(
      response.data == null ? null : _entry(response.data!),
      response.serverTime,
    );
  });
  @override
  Future<List<AttendanceEntry>> history(
    String from,
    String to, {
    String? employeeId,
  }) => _call(() async {
    final response = _required(
      (await _api.listAttendance(
        from: from,
        to: to,
        employeeId: employeeId,
      )).data,
    );
    return (response.data ?? []).map(_entry).toList(growable: false);
  });
  @override
  Future<AttendanceEntry> pin(
    String employeeId,
    AttendanceAction action,
    String pin,
  ) => _call(
    () async => _entry(
      _required(
        (await _api.punchAttendancePin(
          attendancePINRequest: api.AttendancePINRequest(
            employeeId: employeeId,
            action: action == AttendanceAction.clockIn
                ? api.AttendancePINRequestActionEnum.in_
                : api.AttendancePINRequestActionEnum.out_,
            pin: pin,
          ),
        )).data,
      ).data,
    ),
    mutation: true,
  );
  @override
  Future<void> enroll(String pin, String publicKey) => _call(() async {
    await _api.enrollAttendanceBiometric(
      attendanceEnrollmentRequest: api.AttendanceEnrollmentRequest(
        pin: pin,
        publicKey: publicKey,
      ),
    );
  }, mutation: true);
  @override
  Future<FingerprintChallenge> challenge(AttendanceAction action) =>
      _call(() async {
        final c = _required(
          (await _api.createAttendanceChallenge(
            attendanceChallengeInputBody: api.AttendanceChallengeInputBody(
              action: action == AttendanceAction.clockIn
                  ? api.AttendanceChallengeInputBodyActionEnum.in_
                  : api.AttendanceChallengeInputBodyActionEnum.out_,
            ),
          )).data,
        ).data;
        return FingerprintChallenge(c.id, c.payload);
      });
  @override
  Future<AttendanceEntry> biometric(String challengeId, String signature) =>
      _call(
        () async => _entry(
          _required(
            (await _api.punchAttendanceBiometric(
              attendanceBiometricInputBody: api.AttendanceBiometricInputBody(
                challengeId: challengeId,
                signature: signature,
              ),
            )).data,
          ).data,
        ),
        mutation: true,
      );
}
