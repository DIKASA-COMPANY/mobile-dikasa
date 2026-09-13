import 'package:dikasa_api/dikasa_api.dart' as generated;
import 'package:dio/dio.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/cash_session.dart';

class CashSessionService {
  const CashSessionService(this._apiClient);

  final ApiClient _apiClient;

  Future<CashSession?> getCurrent() async {
    try {
      final Response<generated.SessionResponse> response = await _apiClient.api
          .getSesiKasApi()
          .getCurrentCashSession();
      return _toCashSession(response.data?.data);
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        return null;
      }
      throw ApiException.fromDio(error);
    }
  }

  Future<CashSession> open(int amount) async {
    try {
      final Response<generated.SessionResponse> response = await _apiClient.api
          .getSesiKasApi()
          .openCashSession(
            openRequest: generated.OpenRequest(openingCash: amount),
          );
      final CashSession? session = _toCashSession(response.data?.data);
      if (session == null) {
        throw const ApiException(
          type: ApiErrorType.parsing,
          message: 'Data sesi kas dari server tidak lengkap.',
        );
      }
      return session;
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  CashSession? _toCashSession(generated.SessionData? data) {
    if (data == null) {
      return null;
    }
    return CashSession(
      id: data.id,
      openingCash: data.openingCash,
      openedAt: data.openedAt,
    );
  }
}
