import 'package:dikasa_api/dikasa_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/core/network/mock_api_interceptor.dart';

/// Pembungkus tunggal Dio; base URL, timeout, header auth, dan logging diatur sekali di sini.
class ApiClient {
  ApiClient({Dio? dio}) : dio = dio ?? Dio() {
    api = DikasaApi(dio: this.dio);
    _configure();
  }

  final Dio dio;
  late final DikasaApi api;

  void _configure() {
    dio.options = BaseOptions(
      baseUrl: dotenv.env['API_BASE_URL'] ?? '',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: Headers.jsonContentType,
    );

    // Set USE_MOCK_API=false di .env untuk memakai backend asli.
    if (dotenv.env['USE_MOCK_API'] == 'true') {
      dio.interceptors.add(MockApiInterceptor());
    }

    // Log request/response hanya saat debug, agar tidak bocor di build rilis.
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(responseBody: true));
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
