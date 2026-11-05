import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';

import '../helpers/test_env.dart';

void main() {
  test('mengirim Supabase access token sebagai bearer token', () async {
    loadTestEnv(useMockApi: false);

    final Dio dio = Dio();
    final ApiClient apiClient = ApiClient(dio: dio);
    String? authorization;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          authorization = options.headers['Authorization'] as String?;
          handler.reject(
            DioException(
              requestOptions: options,
              type: DioExceptionType.cancel,
            ),
          );
        },
      ),
    );

    apiClient.updateAuthToken('supabase-access-token');

    await expectLater(
      apiClient.api.getJenisOrderApi().listOrderTypes(),
      throwsA(isA<DioException>()),
    );
    expect(authorization, 'Bearer supabase-access-token');
  });
}
