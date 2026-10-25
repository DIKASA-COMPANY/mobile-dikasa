import 'package:dio/dio.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/refund.dart';

/// Confirmation may have committed; retain its exact UUID/body until resolved.
class RefundUncertainException implements Exception {
  const RefundUncertainException();
}

/// Stable business codes distinguish stale selection and exhausted quantities.
class RefundApiException extends ApiException {
  const RefundApiException({
    required super.type,
    required super.message,
    this.code,
  });
  final String? code;
}

/// Refund transport uses the existing authenticated client and never sends money.
class RefundService {
  const RefundService(this.client);
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
      throw RefundApiException(
        type: a.type,
        message: a.message,
        code: b is Map && b['error'] is Map
            ? b['error']['code'] as String?
            : null,
      );
    } on TypeError {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format data refund tidak sesuai.',
      );
    } on FormatException {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format data refund tidak sesuai.',
      );
    }
  }

  Future<ReceiptRefundDetail> detail(String id) => _read(
    () async => ReceiptRefundDetail.fromJson(
      _data(await client.dio.get<dynamic>('/transactions/$id')),
    ),
  );
  Future<RefundHistoryPage> history(String id, {int page = 1}) => _read(
    () async => RefundHistoryPage.fromJson(
      _body(
        await client.dio.get<dynamic>(
          '/transactions/$id/refunds',
          queryParameters: {'page': page, 'page_size': 20},
        ),
      ),
    ),
  );
  Future<RefundPreview> preview(String id, Map<String, dynamic> selection) =>
      _read(
        () async => RefundPreview.fromJson(
          _data(
            await client.dio.post<dynamic>(
              '/transactions/$id/refunds/preview',
              data: selection,
            ),
          ),
        ),
      );
  Future<RefundRecord?> byRequest(String id) => _read(() async {
    try {
      return RefundRecord.fromJson(
        _data(await client.dio.get<dynamic>('/refunds/by-request/$id')),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  });
  Future<RefundRecord> confirm(String id, Map<String, dynamic> body) async {
    try {
      return await _read(() async {
        try {
          return RefundRecord.fromJson(
            _data(
              await client.dio.post<dynamic>(
                '/transactions/$id/refunds',
                data: body,
              ),
            ),
          );
        } on DioException catch (e) {
          if (e.response?.statusCode == null || e.response!.statusCode! >= 500) {
            throw const RefundUncertainException();
          }
          rethrow;
        }
      });
    } on ApiException catch (e) {
      if (e.type == ApiErrorType.parsing) {
        throw const RefundUncertainException();
      }
      rethrow;
    }
  }
}
