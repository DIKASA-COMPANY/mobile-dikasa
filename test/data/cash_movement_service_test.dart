import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/models/cash_movement.dart';
import 'package:mobile_dikasa/data/services/cash_movement_service.dart';

void main() {
  setUp(
    () => dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost/dikasa/v1\nUSE_MOCK_API=false',
    ),
  );

  test('proof uses the generated JSON response contract', () async {
    final client = ApiClient();
    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          expect(
            options.path,
            '/cash-sessions/session/movements/movement/proof',
          );
          handler.resolve(
            Response<Object>(
              requestOptions: options,
              statusCode: 200,
              data: {
                'data': {'url': 'https://cdn.example.test/proof.png'},
              },
            ),
          );
        },
      ),
    );

    final result = await CashMovementService(
      client,
    ).proof('session', 'movement');

    expect(result, 'https://cdn.example.test/proof.png');
  });

  test(
    'same pending command recreates identical multipart and treats lost reply as uncertain',
    () async {
      final client = ApiClient();
      var calls = 0;
      client.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            calls++;
            final data = options.data as FormData;
            expect(Map.fromEntries(data.fields)['request_id'], 'request');
            expect(Map.fromEntries(data.fields)['amount'], '123');
            expect(data.files.single.key, 'proof');
            handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.receiveTimeout,
              ),
            );
          },
        ),
      );
      final service = CashMovementService(client);
      final pending = PendingCashMovement(
        sessionId: 'session',
        requestId: 'request',
        kind: 'out',
        name: 'Bank',
        amount: 123,
        reason: 'Deposit',
        proofBytes: Uint8List.fromList([1, 2]),
        proofName: 'p.png',
      );
      await expectLater(
        service.create('session', pending),
        throwsA(isA<CashMovementUncertainException>()),
      );
      await expectLater(
        service.create('session', pending),
        throwsA(isA<CashMovementUncertainException>()),
      );
      expect(calls, 2);
    },
  );
}
