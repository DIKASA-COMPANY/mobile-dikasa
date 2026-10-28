import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/services/cash_reconciliation_service.dart';

void main() {
  setUp(
    () => dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    ),
  );
  test('malformed successful close stays uncertain', () async {
    final c = ApiClient();
    c.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (r, h) => h.resolve(
          Response(requestOptions: r, statusCode: 200, data: {'data': {}}),
        ),
      ),
    );
    expect(
      () => CashReconciliationService(c).close('session', {}),
      throwsA(isA<CashCloseUncertainException>()),
    );
  });
  test('business stale code remains available', () async {
    final c = ApiClient();
    c.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (r, h) => h.reject(
          DioException(
            requestOptions: r,
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: r,
              statusCode: 409,
              data: {
                'error': {
                  'code': 'SESI_KAS_PRATINJAU_BERUBAH',
                  'message': 'Changed',
                },
              },
            ),
          ),
        ),
      ),
    );
    expect(
      () => CashReconciliationService(c).close('session', {}),
      throwsA(
        isA<CashReconciliationApiException>().having(
          (e) => e.code,
          'code',
          'SESI_KAS_PRATINJAU_BERUBAH',
        ),
      ),
    );
  });
}
