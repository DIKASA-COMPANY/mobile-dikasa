import 'package:dio/dio.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/cash_reconciliation.dart';

class CashCloseUncertainException implements Exception {
  const CashCloseUncertainException();
}

class CashReconciliationApiException extends ApiException {
  const CashReconciliationApiException({
    required super.type,
    required super.message,
    this.code,
  });
  final String? code;
}

/// Uses the existing authenticated client; closing never moves or transfers money.
class CashReconciliationService {
  const CashReconciliationService(this.client);
  final ApiClient client;
  Map<String, dynamic> _body(Response<dynamic> r) =>
      Map<String, dynamic>.from(r.data as Map);
  Map<String, dynamic> _data(Response<dynamic> r) =>
      Map<String, dynamic>.from(_body(r)['data'] as Map);
  Future<T> _read<T>(Future<T> Function() f) async {
    try {
      return await f();
    } on DioException catch (e) {
      final a = ApiException.fromDio(e);
      final b = e.response?.data;
      throw CashReconciliationApiException(
        type: a.type,
        message: a.message,
        code: b is Map && b['error'] is Map
            ? b['error']['code'] as String?
            : null,
      );
    } on TypeError {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format sesi kas tidak sesuai.',
      );
    } on FormatException {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format sesi kas tidak sesuai.',
      );
    }
  }

  Future<CashSessionPage> sessions({int page = 1}) => _read(
    () async => CashSessionPage.fromJson(
      _body(
        await client.dio.get<dynamic>(
          '/cash-sessions',
          queryParameters: {'page': page, 'page_size': 20},
        ),
      ),
    ),
  );
  Future<CashSessionRecord> detail(String id) => _read(
    () async => CashSessionRecord.fromJson(
      _data(await client.dio.get<dynamic>('/cash-sessions/$id')),
    ),
  );
  Future<CashClosePreview> preview(String id, Map<String, dynamic> b) => _read(
    () async => CashClosePreview.fromJson(
      _data(
        await client.dio.post<dynamic>(
          '/cash-sessions/$id/close/preview',
          data: b,
        ),
      ),
    ),
  );
  Future<CashClosedRecord> close(String id, Map<String, dynamic> b) async {
    try {
      return await _read(() async {
        try {
          return CashClosedRecord.fromJson(
            _data(
              await client.dio.post<dynamic>(
                '/cash-sessions/$id/close',
                data: b,
              ),
            ),
          );
        } on DioException catch (e) {
          if (e.response?.statusCode == null || e.response!.statusCode! >= 500) {
            throw const CashCloseUncertainException();
          }
          rethrow;
        }
      });
    } on ApiException catch (e) {
      if (e.type == ApiErrorType.parsing) {
        throw const CashCloseUncertainException();
      }
      rethrow;
    }
  }
}
