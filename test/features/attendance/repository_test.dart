import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dikasa_api/dikasa_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/features/attendance/models.dart';
import 'package:mobile_dikasa/features/attendance/repository.dart';

void main() {
  late Dio dio;
  late ApiAttendanceRepository repository;
  late List<RequestOptions> requests;
  late Object? failure;
  late bool malformed;

  Map<String, Object?> record({bool clockOut = false}) => {
    'id': 'record',
    'outlet_id': 'outlet',
    'employee_id': 'staff',
    'employee_name': 'Jane Doe',
    'work_date': '2026-11-05',
    'clock_in': '2026-11-05T02:00:00Z',
    'clock_out': clockOut ? '2026-11-05T10:00:00Z' : null,
    'in_method': 'pin',
    'out_method': clockOut ? 'fingerprint' : null,
    'created_by': 'staff',
    'updated_by': 'staff',
  };

  setUp(() {
    requests = [];
    failure = null;
    malformed = false;
    dio = Dio(BaseOptions(baseUrl: 'https://api.example/dikasa/v1'));
    final client = api.DikasaApi(dio: dio);
    client.setBearerAuth('supabaseBearer', 'test-token');
    repository = ApiAttendanceRepository(client.getAbsensiApi());
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          requests.add(options);
          if (failure case final int status) {
            handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.badResponse,
                response: Response(
                  requestOptions: options,
                  statusCode: status,
                  data: {'message': 'Ditolak'},
                ),
              ),
            );
            return;
          }
          if (failure != null) {
            handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.receiveTimeout,
              ),
            );
            return;
          }
          final Object? data = switch (options.path) {
            '/employees' => {
              'data': [
                {
                  'id': 'staff',
                  'name': 'Jane Doe',
                  'has_pin': true,
                  'fingerprint_enrolled': false,
                },
              ],
            },
            '/attendance/status' => {
              'server_time': '2026-11-05T02:00:00Z',
              'data': null,
            },
            '/attendance' => {
              'data': [record(clockOut: true)],
            },
            '/attendance/biometric/challenge' => {
              'data': {
                'id': 'challenge',
                'payload': 'signed-server-payload',
                'expires_at': '2026-11-05T02:02:00Z',
              },
            },
            '/attendance/biometric/enrollment' => null,
            _ => malformed ? {'data': {}} : {'data': record()},
          };
          handler.resolve(
            Response(
              requestOptions: options,
              statusCode: options.path.endsWith('/enrollment') ? 204 : 200,
              headers: Headers.fromMap({
                'content-type': ['application/json'],
              }),
              data: data,
            ),
          );
        },
      ),
    );
  });
  tearDown(() => dio.close(force: true));

  test(
    'generated reads map staff, nullable status and history with bearer',
    () async {
      final staff = await repository.employees();
      expect(staff.single.id, 'staff');
      expect(staff.single.hasPin, isTrue);
      expect(staff.single.fingerprintEnrolled, isFalse);
      final status = await repository.status('staff');
      expect(status.entry, isNull);
      expect(status.serverTime, DateTime.utc(2026, 11, 5, 2));
      final entries = await repository.history(
        '2026-11-01',
        '2026-11-05',
        employeeId: 'staff',
      );
      expect(entries.single.clockOut, DateTime.utc(2026, 11, 5, 10));
      expect(entries.single.outMethod, 'fingerprint');
      expect(requests.last.queryParameters, {
        'employee_id': 'staff',
        'from': '2026-11-01',
        'to': '2026-11-05',
      });
      expect(
        requests.every(
          (r) => r.headers['Authorization'] == 'Bearer test-token',
        ),
        isTrue,
      );
    },
  );

  test('PIN serializes the published action and six-digit secret', () async {
    final entry = await repository.pin(
      'staff',
      AttendanceAction.clockOut,
      '123456',
    );
    expect(entry.employeeId, 'staff');
    expect(requests.single.method, 'POST');
    expect(jsonDecode(requests.single.data as String), {
      'employee_id': 'staff',
      'action': 'out',
      'pin': '123456',
    });
  });

  test(
    'fingerprint enrollment accepts empty 204 and sends a signed challenge',
    () async {
      await repository.enroll('123456', 'public-key');
      expect(requests.last.method, 'PUT');
      expect(jsonDecode(requests.last.data as String), {
        'pin': '123456',
        'public_key': 'public-key',
      });
      final challenge = await repository.challenge(AttendanceAction.clockIn);
      expect(challenge.payload, 'signed-server-payload');
      expect(jsonDecode(requests.last.data as String), {'action': 'in'});
      await repository.biometric(challenge.id, 'signature');
      expect(jsonDecode(requests.last.data as String), {
        'challenge_id': 'challenge',
        'signature': 'signature',
      });
    },
  );

  for (final status in [401, 403, 409, 422]) {
    test('HTTP $status remains an authoritative rejection', () async {
      failure = status;
      await expectLater(
        repository.pin('staff', AttendanceAction.clockIn, '123456'),
        throwsA(isA<ApiException>()),
      );
    });
  }

  for (final error in [500, 'timeout']) {
    test(
      '$error blocks blind retries of a potentially accepted punch',
      () async {
        failure = error;
        await expectLater(
          repository.pin('staff', AttendanceAction.clockIn, '123456'),
          throwsA(isA<AttendanceOutcomeUncertain>()),
        );
      },
    );
  }

  test('a malformed successful mutation is treated as uncertain', () async {
    malformed = true;
    await expectLater(
      repository.pin('staff', AttendanceAction.clockIn, '123456'),
      throwsA(isA<AttendanceOutcomeUncertain>()),
    );
  });
}
