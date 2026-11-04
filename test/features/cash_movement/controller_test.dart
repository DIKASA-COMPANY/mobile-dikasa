import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/services/cash_movement_service.dart';
import 'package:mobile_dikasa/data/models/cash_movement.dart';
import 'package:mobile_dikasa/features/cash_movement/controller.dart';

CashMovementRecord result(PendingCashMovement p) =>
    CashMovementRecord.fromJson({
      'id': 'm',
      'session_id': p.sessionId,
      'request_id': p.requestId,
      'created_by': '1',
      'created_at': '2026-10-24T01:00:00Z',
      'kind': 'out',
      'name': 'Deposit',
      'reason': 'Bank',
      'amount': 10,
      'has_proof': false,
    });

class UncertainService extends CashMovementService {
  UncertainService(super.c);
  int calls = 0;
  final requests = <String>[];
  @override
  Future<CashMovementRecord> create(String id, PendingCashMovement p) async {
    calls++;
    requests.add(p.requestId);
    if (calls == 1) throw const CashMovementUncertainException();
    return result(p);
  }

  @override
  Future<CashMovementRecord> byRequest(String id, String request) async =>
      throw const ApiException(type: ApiErrorType.server, message: 'Not found');
}

class DeferredService extends CashMovementService {
  DeferredService(super.c);
  final pending = Completer<CashMovementRecord>();
  PendingCashMovement? intent;
  @override
  Future<CashMovementRecord> create(String id, PendingCashMovement p) {
    intent = p;
    return pending.future;
  }
}

class FailedReadService extends CashMovementService {
  FailedReadService(super.c);
  @override
  Future<CashActivity> activity(String id, {int page = 1}) async =>
      throw const ApiException(type: ApiErrorType.network, message: 'offline');
}

void main() {
  setUp(
    () => dotenv.loadFromString(
      envString: 'API_BASE_URL=http://localhost/dikasa/v1\nUSE_MOCK_API=true',
    ),
  );
  test(
    'uncertain command keeps original till, UUID and checkout lock until resolved',
    () async {
      final client = ApiClient();
      final auth = AuthRepository(
        authService: AuthService(client),
        apiClient: client,
      );
      await auth.login(username: 'admin', password: 'dikasa123');
      final service = UncertainService(client);
      var locked = false;
      final c = CashMovementController(
        service: service,
        auth: auth,
        acquire: (_) {
          locked = true;
          return true;
        },
        release: (_) => locked = false,
      );
      c.sessionId = 'original';
      expect(
        await c.create(
          kind: 'out',
          name: 'Deposit',
          amount: 10,
          reason: 'Bank',
        ),
        isFalse,
      );
      expect(c.uncertain, isTrue);
      expect(locked, isTrue);
      final id = c.pending!.requestId;
      await c.load('new-till');
      expect(c.sessionId, 'original');
      expect(await c.recover(), isFalse);
      expect(c.pending!.requestId, id);
      expect(locked, isTrue);
      expect(await c.retry(), isTrue);
      expect(service.requests, [id, id]);
      expect(locked, isFalse);
      c.dispose();
    },
  );
  test(
    'logout invalidates pending results even on subsequent same-account login',
    () async {
      final client = ApiClient();
      final auth = AuthRepository(
        authService: AuthService(client),
        apiClient: client,
      );
      await auth.login(username: 'admin', password: 'dikasa123');
      final service = DeferredService(client);
      var locked = false;
      final c = CashMovementController(
        service: service,
        auth: auth,
        acquire: (_) {
          locked = true;
          return true;
        },
        release: (_) => locked = false,
      );
      c.sessionId = 'original';
      final command = c.create(
        kind: 'out',
        name: 'Deposit',
        amount: 10,
        reason: 'Bank',
      );
      auth.logout();
      await auth.login(username: 'admin', password: 'dikasa123');
      service.pending.complete(result(service.intent!));
      expect(await command, isFalse);
      expect(c.pending, isNull);
      expect(locked, isFalse);
      expect(c.current, isFalse);
      c.dispose();
    },
  );

  test(
    'failed session switch cannot keep another till balance or capabilities',
    () async {
      final client = ApiClient();
      final auth = AuthRepository(
        authService: AuthService(client),
        apiClient: client,
      );
      await auth.login(username: 'admin', password: 'dikasa123');
      final c = CashMovementController(
        service: FailedReadService(client),
        auth: auth,
        acquire: (_) => true,
        release: (_) {},
      );
      c.activity = CashActivity.fromJson({
        'data': {
          'session': {'id': 'old', 'status': 'open', 'opening_cash': 100},
          'totals': null,
          'events': [],
          'capabilities': {'can_create': true, 'can_upload_proof': true},
        },
        'meta': {'page': 1, 'total': 0},
      });
      c.sessionId = 'old';
      await c.load('new');
      expect(c.activity, isNull);
      expect(c.error, isNotNull);
      c.dispose();
    },
  );
}
