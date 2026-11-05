import 'package:flutter/foundation.dart';

@immutable
class StaffMember {
  const StaffMember({
    required this.id,
    required this.name,
    required this.hasPin,
    required this.fingerprintEnrolled,
  });
  final String id, name;
  final bool hasPin, fingerprintEnrolled;
}

@immutable
class AttendanceEntry {
  const AttendanceEntry({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.workDate,
    required this.clockIn,
    required this.clockOut,
    required this.inMethod,
    required this.outMethod,
  });
  final String id, employeeId, employeeName, workDate, inMethod;
  final String? outMethod;
  final DateTime clockIn;
  final DateTime? clockOut;
}

@immutable
class AttendanceStatus {
  const AttendanceStatus(this.entry, this.serverTime);
  final AttendanceEntry? entry;
  final DateTime serverTime;
}

@immutable
class FingerprintChallenge {
  const FingerprintChallenge(this.id, this.payload);
  final String id, payload;
}

enum AttendanceMethod { pin, fingerprint }

enum AttendanceAction { clockIn, clockOut }

DateTime inJakarta(DateTime value) =>
    value.toUtc().add(const Duration(hours: 7));
String workDate(DateTime value) =>
    inJakarta(value).toIso8601String().substring(0, 10);
String attendanceTime(DateTime? value) {
  if (value == null) return '--:--';
  final time = inJakarta(value);
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

/// A write may have reached the server; refresh its state before another punch.
class AttendanceOutcomeUncertain implements Exception {}
