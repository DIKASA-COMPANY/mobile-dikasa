import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/services/pos_service.dart';
import 'package:mobile_dikasa/data/models/pos.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';

void main() {
  late ApiClient client;
  late List<RequestOptions> requests;
  setUp(() {
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    client = ApiClient();
    requests = [];
  });

  for (final body in <dynamic>[
    null,
    'invalid',
    <dynamic>[],
    {'data': null},
  ]) {
    test('malformed success body is an uncertain payment: $body', () async {
      client.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (request, handler) {
            handler.resolve(
              Response(requestOptions: request, statusCode: 201, data: body),
            );
          },
        ),
      );
      await expectLater(
        PosService(client).pay({}),
        throwsA(isA<PaymentUncertainException>()),
      );
      await expectLater(
        PosService(client).currentCash(),
        throwsA(isA<ApiException>()),
      );
    });
  }

  test(
    'missing current session is distinguished from a server failure',
    () async {
      client.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (request, handler) {
            handler.reject(
              DioException(
                requestOptions: request,
                type: DioExceptionType.badResponse,
                response: Response(
                  requestOptions: request,
                  statusCode: 404,
                  data: {
                    'error': {
                      'code': 'SESI_KAS_TIDAK_DITEMUKAN',
                      'message': 'No open session',
                    },
                  },
                ),
              ),
            );
          },
        ),
      );
      expect(await PosService(client).currentCash(), isNull);
    },
  );

  test('opens cash and parses server IDs rather than static options', () async {
    client.updateAuthToken('session');
    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          requests.add(request);
          handler.resolve(
            Response(
              requestOptions: request,
              statusCode: 200,
              data: {
                'data': request.path == '/order-types'
                    ? [
                        {
                          'id': 'type-uuid',
                          'code': 'takeaway',
                          'name': 'Bungkus',
                          'is_active': true,
                        },
                      ]
                    : {
                        'id': 'cash-uuid',
                        'opening_cash': 100000,
                        'status': 'open',
                      },
              },
            ),
          );
        },
      ),
    );
    final service = PosService(client);
    final cash = await service.openCash(100000);
    final types = await service.orderTypes();
    expect(cash.id, 'cash-uuid');
    expect(cash.openingCash, 100000);
    expect(types.single.id, 'type-uuid');
    expect(types.single.label, 'Bungkus');
    expect(requests.first.data, {'opening_cash': 100000});
    expect(requests.first.headers['Authorization'], 'Bearer session');
  });

  test('reads tax, wallets and searchable paginated order history', () async {
    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          requests.add(request);
          final data = switch (request.path) {
            '/payments/tax-percentage' => {'tax_percentage': 10},
            '/wallets' => {
              'data': [
                {'id': 'wallet-uuid', 'name': 'GoPay', 'is_active': true},
              ],
            },
            _ => {
              'data': [
                {
                  'id': 'transaction-uuid',
                  'receipt_number': 'TRX-001',
                  'customer_name': '',
                  'ordered_at': '2026-10-19T10:00:00Z',
                  'order_type': {
                    'id': 'type-uuid',
                    'name': 'Bungkus',
                    'code': 'takeaway',
                  },
                  'total_quantity': 1,
                  'total_amount': 23100,
                  'status': 'paid',
                },
              ],
              'meta': {'page': 2, 'page_size': 20, 'total': 21},
            },
          };
          handler.resolve(
            Response(requestOptions: request, statusCode: 200, data: data),
          );
        },
      ),
    );
    final service = PosService(client);
    expect(await service.taxPercentage(), 10);
    expect((await service.wallets()).single.id, 'wallet-uuid');
    final history = await service.orders(
      search: 'TRX',
      page: 2,
      status: 'paid',
    );
    expect(history.total, 21);
    expect(history.items.single['receipt_number'], 'TRX-001');
    expect(requests.last.queryParameters, {
      'search': 'TRX',
      'page': 2,
      'page_size': 20,
      'status': 'paid',
    });
  });
}
