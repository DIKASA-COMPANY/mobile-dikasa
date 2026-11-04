import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/services/refund_service.dart';

void main() {
  setUp(
    () => dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    ),
  );
  test('malformed successful confirmation remains uncertain', () async {
    final c = ApiClient();
    c.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (r, h) => h.resolve(
          Response(requestOptions: r, statusCode: 201, data: {'data': {}}),
        ),
      ),
    );
    expect(
      () => RefundService(c).confirm('receipt', {}),
      throwsA(isA<RefundUncertainException>()),
    );
  });
  test(
    'lookup404 is unresolved rather than a new refund instruction',
    () async {
      final c = ApiClient();
      c.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (r, h) => h.reject(
            DioException(
              requestOptions: r,
              type: DioExceptionType.badResponse,
              response: Response(requestOptions: r, statusCode: 404),
            ),
          ),
        ),
      );
      expect(await RefundService(c).byRequest('request'), isNull);
    },
  );
}
