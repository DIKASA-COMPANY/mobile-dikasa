import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/models/saved_order.dart';
import 'package:mobile_dikasa/data/services/pos_service.dart';

Map<String, dynamic> draftJson() => {
  'id': 'draft',
  'label': 'Table A',
  'revision': 1,
  'status': 'open',
  'order_type_id': 'type',
  'created_by': 'actor',
  'creator_name': 'Cashier',
  'updated_at': '2026-10-23T01:00:00Z',
  'estimated_subtotal': 100,
  'total_quantity': 1,
  'transaction_id': null,
  'items': [
    {
      'product_id': 'product',
      'product_name': 'Tea',
      'unit_price': 100,
      'quantity': 1,
      'notes': 'less ice',
    },
  ],
};
void main() {
  setUp(
    () => dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    ),
  );
  test('saved draft parsing preserves variation and notes', () {
    final json = draftJson();
    json['items'][0]['product_variant_id'] = 'variant';
    json['items'][0]['variant_name'] = 'Large';
    final d = SavedOrder.fromJson(json);
    expect(d.items.single.variantId, 'variant');
    expect(d.items.single.notes, 'less ice');
    expect(d.revision, 1);
  });
  test('malformed successful save is uncertain', () async {
    final client = ApiClient();
    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (r, h) => h.resolve(
          Response(requestOptions: r, statusCode: 200, data: {'data': null}),
        ),
      ),
    );
    expect(
      () => PosService(client).createSavedOrder({}),
      throwsA(isA<SavedCommandUncertainException>()),
    );
  });
  test('timeout is uncertain and conflict retains stable code', () async {
    final client = ApiClient();
    var timeout = true;
    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (r, h) {
          h.reject(
            DioException(
              requestOptions: r,
              type: timeout
                  ? DioExceptionType.receiveTimeout
                  : DioExceptionType.badResponse,
              response: timeout
                  ? null
                  : Response(
                      requestOptions: r,
                      statusCode: 409,
                      data: {
                        'error': {
                          'code': 'PESANAN_SUDAH_DIBAYAR',
                          'message': 'Paid',
                        },
                      },
                    ),
            ),
          );
        },
      ),
    );
    final s = PosService(client);
    await expectLater(
      s.createSavedOrder({}),
      throwsA(isA<SavedCommandUncertainException>()),
    );
    timeout = false;
    await expectLater(
      s.createSavedOrder({}),
      throwsA(
        isA<SavedOrderApiException>().having(
          (e) => e.code,
          'code',
          'PESANAN_SUDAH_DIBAYAR',
        ),
      ),
    );
  });
}
