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

  /// POST /login, dilanjutkan GET /users/me untuk data profil layar.
  Future<AuthSession> login({
    required String username,
    required String password,
  }) async {
    try {
      final Response<generated.LoginResponse> loginResponse = await _apiClient
          .api
          .getAutentikasiApi()
          .login(
            loginRequest: generated.LoginRequest(
              identifier: username,
              password: password,
            ),
          );
      final generated.LoginResponseData? session = loginResponse.data?.data;
      if (session == null) {
        throw const ApiException(
          type: ApiErrorType.parsing,
          message: 'Data sesi dari server tidak lengkap.',
        );
      }

      final Response<generated.ProfileResponse> profileResponse =
          await _apiClient.api.getUserApi().getCurrentUser(
            headers: <String, dynamic>{
              'Authorization': 'Bearer ${session.accessToken}',
            },
          );
      final generated.Profile? profile = profileResponse.data?.data;
      if (profile == null) {
        throw const ApiException(
          type: ApiErrorType.parsing,
          message: 'Data profil dari server tidak lengkap.',
        );
      }

      final String fullName = '${profile.firstName} ${profile.lastName}'.trim();
      return AuthSession(
        token: session.accessToken,
        refreshToken: session.refreshToken,
        expiresInSeconds: session.expiresIn,
        user: User(
          id: profile.id,
          name: fullName.isEmpty ? profile.username : fullName,
          username: profile.username,
          roleId: profile.roleId,
          phoneNumber: profile.phoneNumber,
          outletId: profile.outletId,
          email: profile.email,
          avatarUrl: profile.avatarUrl,
        ),
      );
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    } on TypeError catch (_) {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format data dari server tidak sesuai.',
      );
    }
  }
}
