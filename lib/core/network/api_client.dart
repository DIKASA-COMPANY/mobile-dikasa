import 'package:dikasa_api/dikasa_api.dart';
import 'package:dio/dio.dart';
import 'package:dikasa_api/dikasa_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/core/network/mock_api_interceptor.dart';

/// Pembungkus tunggal Dio; base URL, timeout, header auth, dan logging diatur sekali di sini.
class ApiClient {
  ApiClient({Dio? dio}) : dio = dio ?? Dio() {
    api = DikasaApi(dio: this.dio);
    _configure();
    generated = DikasaApi(dio: this.dio, interceptors: const <Interceptor>[]);
  }

  final Dio dio;
  late final DikasaApi generated;

  /// Token yang dilampirkan otomatis ke setiap request setelah login.
  String? _authToken;

  void _configure() {
    const dartDefineBaseUrl = String.fromEnvironment('API_BASE_URL');
    const dartDefineUseMock = String.fromEnvironment('USE_MOCK_API');
    final baseUrl = dartDefineBaseUrl.isNotEmpty
        ? dartDefineBaseUrl
        : (dotenv.env['API_BASE_URL'] ?? 'http://localhost:8081/dikasa/v1');
    final useMockValue = dartDefineUseMock.isNotEmpty
        ? dartDefineUseMock
        : (dotenv.env['USE_MOCK_API'] ?? 'true');
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: Headers.jsonContentType,
    );

    // Menyisipkan Authorization header tanpa perlu diulang di tiap Service.
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          final String? token = _authToken;
          if (token != null && !options.headers.containsKey('Authorization')) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );

    // Set USE_MOCK_API=false di .env untuk memakai backend asli.
    if (useMockValue.toLowerCase() == 'true') {
      dio.interceptors.add(MockApiInterceptor());
    }

    // Log request/response hanya saat debug, agar tidak bocor di build rilis.
    if (kDebugMode) {
      // Avoid printing passwords, bearer tokens or token responses during login.
      dio.interceptors.add(
        LogInterceptor(requestHeader: false, responseHeader: false),
      );
    }
  }

  /// Mengisi interceptor bearer generated setelah login / menghapusnya saat logout.
  void updateAuthToken(String? token) {
    if (token == null || token.isEmpty) {
      api.removeBearerAuth('firebaseBearer');
      return;
    }

    api.setBearerAuth('firebaseBearer', token);
  }
}
