import 'cash_movement_service.dart';
import 'report_service.dart';
import 'cash_reconciliation_service.dart';
import 'refund_service.dart';
import 'package:dio/dio.dart';
import 'package:mobile_dikasa/data/models/saved_order.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/pos.dart';

/// HTTP boundary for cash sessions, checkout reference data and sales browsing.
class PosService {
  const PosService(this._client);
  final ApiClient _client;
 CashMovementService get cashMovements=>CashMovementService(_client);
 ReportService get reports=>ReportService(_client);
  RefundService get refunds=>RefundService(_client);
 CashReconciliationService get cashReconciliation=>CashReconciliationService(_client);

  // Validate envelopes before indexing; null/malformed payment replies may follow a commit.
  Map<String, dynamic> _body(Response<dynamic> response) =>
      response.data as Map<String, dynamic>;
  Map<String, dynamic> _data(Response<dynamic> response) =>
      _body(response)['data'] as Map<String, dynamic>;

  Future<T> _read<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    } on TypeError {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format data kasir dari server tidak sesuai.',
      );
    } on FormatException {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format data kasir dari server tidak sesuai.',
      );
    }
  }

  Future<SavedOrderPage> savedOrders({String search = '', int page = 1}) =>
      _read(() async {
        final r = await _client.dio.get<dynamic>(
          '/saved-orders',
          queryParameters: {
            'search': search.trim(),
            'page': page,
            'page_size': 20,
          },
        );
        return SavedOrderPage.fromJson(_body(r));
      });
  Future<SavedOrder> savedOrder(String id) => _read(
    () async => SavedOrder.fromJson(
      _data(await _client.dio.get<dynamic>('/saved-orders/$id')),
    ),
  );
  Future<SavedOrder> createSavedOrder(Map<String, dynamic> body) =>
      _savedMutation(
        () => _client.dio.post<dynamic>('/saved-orders', data: body),
      );
  Future<SavedOrder> updateSavedOrder(String id, Map<String, dynamic> body) =>
      _savedMutation(
        () => _client.dio.put<dynamic>('/saved-orders/$id', data: body),
      );
  Future<SavedOrder> deleteSavedOrder(
    String id, {
    required String requestId,
    required int revision,
  }) => _savedMutation(
    () => _client.dio.delete<dynamic>(
      '/saved-orders/$id',
      queryParameters: {'request_id': requestId, 'expected_revision': revision},
    ),
  );
  Future<SavedOrder> _savedMutation(
    Future<Response<dynamic>> Function() send,
  ) async {
    try {
      return SavedOrder.fromJson(_data(await send()));
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == null || status >= 500) {
        throw const SavedCommandUncertainException();
      }
      final error = ApiException.fromDio(e);
      final b = e.response?.data;
      throw SavedOrderApiException(
        type: error.type,
        message: error.message,
        code: b is Map && b['error'] is Map
            ? b['error']['code'] as String?
            : null,
      );
    } on TypeError {
      throw const SavedCommandUncertainException();
    } on FormatException {
      throw const SavedCommandUncertainException();
    }
  }

  Future<CashSession?> currentCash() => _read(() async {
    try {
      final response = await _client.dio.get<dynamic>('/cash-sessions/current');
      return CashSession.fromJson(_data(response));
    } on DioException catch (error) {
      final body = error.response?.data;
      if (error.response?.statusCode == 404 &&
          body is Map &&
          body['error'] is Map &&
          body['error']['code'] == 'SESI_KAS_TIDAK_DITEMUKAN') {
        return null;
      }
      rethrow;
    }
  });

  Future<CashSession> openCash(int amount) => _read(() async {
    try {
      final response = await _client.dio.post<dynamic>(
        '/cash-sessions',
        data: {'opening_cash': amount},
      );
      return CashSession.fromJson(_data(response));
    } on DioException catch (error) {
      // Another cashier may have opened the same outlet while this dialog was open.
      if (error.response?.statusCode == 409) {
        final active = await currentCash();
        if (active != null) return active;
      }
      rethrow;
    }
  });

  Future<List<PosOrderType>> orderTypes() => _read(() async {
    final response = await _client.dio.get<dynamic>('/order-types');
    return (_body(response)['data'] as List)
        .cast<Map<String, dynamic>>()
        .where((item) => item['is_active'] != false)
        .map(PosOrderType.fromJson)
        .toList();
  });

  Future<double> taxPercentage() => _read(() async {
    final response = await _client.dio.get<dynamic>('/payments/tax-percentage');
    final value = (_body(response)['tax_percentage'] as num).toDouble();
    if (!value.isFinite || value < 0 || value > 100) {
      throw const FormatException('Invalid tax');
    }
    return value;
  });

  Future<List<PosOption>> _options(String path) => _read(() async {
    final response = await _client.dio.get<dynamic>(path);
    return (_body(response)['data'] as List)
        .cast<Map<String, dynamic>>()
        .where((item) => item['is_active'] != false)
        .map(PosOption.fromJson)
        .toList();
  });
  Future<List<PosOption>> wallets() => _options('/wallets');
  Future<List<PosOption>> tables() => _options('/restaurant-tables');

  Future<PaymentReceipt> pay(Map<String, dynamic> payload) async {
    try {
      final response = await _client.dio.post<dynamic>(
        '/transactions',
        data: payload,
      );
      return PaymentReceipt.fromJson(_data(response));
    } on DioException catch (error) {
      final status = error.response?.statusCode;
      // No automatic retry: POST has no server idempotency-key contract yet.
      if (status == null || status >= 500) {
        throw const PaymentUncertainException();
      }
      final b = error.response?.data;
      if (b is Map &&
          b['error'] is Map &&
          b['error']['code'] == 'PESANAN_SUDAH_DIBAYAR') {
        throw const SavedOrderApiException(
          type: ApiErrorType.server,
          message: 'Pesanan sudah dibayar. Periksa struk.',
          code: 'PESANAN_SUDAH_DIBAYAR',
        );
      }
      throw ApiException.fromDio(error);
    } on TypeError {
      throw const PaymentUncertainException();
    } on FormatException {
      throw const PaymentUncertainException();
    }
  }

  Future<PosPage> orders({
    String search = '',
    int page = 1,
    String? status,
    String? orderTypeId,
  }) => _read(() async {
    final response = await _client.dio.get<dynamic>(
      '/orders',
      queryParameters: {
        'search': search.trim(),
        'page': page,
        'page_size': 20,
        'status': ?status,
        'order_type_id': ?orderTypeId,
      },
    );
    return PosPage.fromJson(response.data as Map<String, dynamic>);
  });

  Future<PosPage> customers({String search = '', int page = 1}) =>
      _read(() async {
        final response = await _client.dio.get<dynamic>(
          '/customers',
          queryParameters: {
            'search': search.trim(),
            'page': page,
            'page_size': 20,
          },
        );
        return PosPage.fromJson(response.data as Map<String, dynamic>);
      });
}
