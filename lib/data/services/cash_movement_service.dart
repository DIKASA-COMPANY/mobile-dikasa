import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../models/cash_movement.dart';

class CashMovementUncertainException implements Exception {
  const CashMovementUncertainException();
}

class CashMovementApiException extends ApiException {
  const CashMovementApiException({
    required super.type,
    required super.message,
    this.code,
  });
  final String? code;
}

class CashMovementService {
  CashMovementService(this.client);
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
      throw CashMovementApiException(
        type: a.type,
        message: a.message,
        code: b is Map && b['error'] is Map
            ? b['error']['code'] as String?
            : null,
      );
    } on TypeError {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format data kas tidak sesuai.',
      );
    } on FormatException {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format data kas tidak sesuai.',
      );
    }
  }

  Future<CashActivity> activity(String id, {int page = 1}) => _read(
    () async => CashActivity.fromJson(
      _body(
        await client.dio.get<dynamic>(
          '/cash-sessions/$id/activity',
          queryParameters: {'page': page, 'page_size': 20},
        ),
      ),
    ),
  );
  Future<CashMovementDetail> detail(String id, String mid) => _read(
    () async => CashMovementDetail.fromJson(
      _data(await client.dio.get<dynamic>('/cash-sessions/$id/movements/$mid')),
    ),
  );
  Future<CashMovementRecord> byRequest(String id, String request) => _read(
    () async => CashMovementRecord.fromJson(
      _data(
        await client.dio.get<dynamic>(
          '/cash-sessions/$id/movements/by-request/$request',
        ),
      ),
    ),
  );
  Future<Uint8List> proof(String id, String mid) => _read(() async {
    final r = await client.dio.get<List<int>>(
      '/cash-sessions/$id/movements/$mid/proof',
      options: Options(responseType: ResponseType.bytes),
    );
    if (r.data == null || r.data!.isEmpty || r.data!.length > 3145728) {
      throw const FormatException('Invalid proof');
    }
    return Uint8List.fromList(r.data!);
  });
  Future<CashMovementRecord> create(String id, PendingCashMovement p) =>
      _write(id, p, false);
  Future<CashMovementRecord> reverse(
    String id,
    String mid,
    PendingCashMovement p,
  ) => _write(id, p, true);
  Future<CashMovementRecord> _write(
    String id,
    PendingCashMovement p,
    bool reversing,
  ) async {
    try {
      return await _read(() async {
        dynamic body;
        String path = '/cash-sessions/$id/movements';
        if (reversing) {
          path += '/${p.reverseId}/reverse';
          body = {'request_id': p.requestId, 'reason': p.reason};
        } else {
          final f = FormData.fromMap({
            'request_id': p.requestId,
            'kind': p.kind,
            'name': p.name,
            'amount': p.amount.toString(),
            'reason': p.reason,
          });
          if (p.proofBytes != null) {
            final name = p.proofName ?? 'proof.png';
            f.files.add(
              MapEntry(
                'proof',
                MultipartFile.fromBytes(
                  p.proofBytes!,
                  filename: name,
                  contentType: DioMediaType(
                    'image',
                    name.toLowerCase().endsWith('.png') ? 'png' : 'jpeg',
                  ),
                ),
              ),
            );
          }
          body = f;
        }
        try {
          final r = await client.dio.post<dynamic>(path, data: body);
          if (r.statusCode != 201) throw const CashMovementUncertainException();
          final m = CashMovementRecord.fromJson(_data(r));
          if (m.sessionId != p.sessionId || m.requestId != p.requestId) {
            throw const CashMovementUncertainException();
          }
          return m;
        } on DioException catch (e) {
          if (e.response == null || (e.response!.statusCode ?? 500) >= 500) {
            throw const CashMovementUncertainException();
          }
          rethrow;
        }
      });
    } on ApiException catch (e) {
      if (e.type == ApiErrorType.parsing) {
        throw const CashMovementUncertainException();
      }
      rethrow;
    }
  }
}
