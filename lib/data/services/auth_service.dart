import 'package:dikasa_api/dikasa_api.dart' as generated;
import 'package:dio/dio.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/auth_session.dart';
import 'package:mobile_dikasa/data/models/user.dart';

/// Lapisan jaringan untuk autentikasi.
///
/// Tugasnya hanya memanggil API dan mengubah response menjadi model.
/// Tidak menyimpan state apa pun — itu tugas Repository.
class AuthService {
  const AuthService(this._apiClient);

  final ApiClient _apiClient;

  /// POST /login, followed by the authenticated /users/me profile.
  Future<AuthSession> login({
    required String username,
    required String password,
  }) async {
    try {
      final Response<dynamic> response = await _apiClient.dio.post<dynamic>(
        ApiEndpoints.login,
        data: <String, dynamic>{'identifier': username, 'password': password},
      );

      final body = response.data as Map<String, dynamic>;
      // The mock keeps its legacy session fixture; real APIs return a token envelope.
      if (body['data'] == null) return AuthSession.fromJson(body);
      final data = body['data'] as Map<String, dynamic>;
      final token = data['access_token'] as String;
      if (token.isEmpty) throw const FormatException('Missing access token');

      final profile = await _apiClient.dio.get<dynamic>(
        ApiEndpoints.profile,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AuthSession(
        token: token,
        user: User.fromJson(
          (profile.data as Map<String, dynamic>)['data']
              as Map<String, dynamic>,
        ),
      );
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    } on TypeError catch (_) {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format data dari server tidak sesuai.',
      );
    } on FormatException {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format data dari server tidak sesuai.',
      );
    }
  }
}
