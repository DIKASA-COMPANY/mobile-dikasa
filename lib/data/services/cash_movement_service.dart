import 'package:dikasa_api/dikasa_api.dart' as api;
import 'image_upload_service.dart';
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
  final _proofUploads = Expando<({int revision, Future<String> upload})>();

  Future<String?> _proof(PendingCashMovement pending) async {
    if (pending.proofBytes == null) return null;
    final cached = _proofUploads[pending];
    if (cached != null) {
      if (cached.revision != client.authRevision) {
        throw const ApiException(
          type: ApiErrorType.unauthorized,
          message:
              'Sesi berubah. Silakan masuk kembali sebelum menyimpan bukti.',
        );
      }
      return cached.upload;
    }
    final uploading = ImageUploadService(client).cashProof(
      pending.sessionId,
      pending.requestId,
      pending.proofBytes!,
      pending.proofName ?? 'proof.png',
    );
    _proofUploads[pending] = (revision: client.authRevision, upload: uploading);
    try {
      return await uploading;
    } catch (_) {
      _proofUploads[pending] = null;
      rethrow;
    }
  }

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
  Future<String> proof(String id, String mid) => _read(() async {
    final response = await client.generated.getKasKasirApi().cashMovementProof(
      sessionId: id,
      movementId: mid,
    );
    final url = response.data?.data.url;
    final uri = url == null ? null : Uri.tryParse(url);
    if (uri == null ||
        (!uri.hasScheme ||
            (!uri.isScheme('https') &&
                !uri.isScheme('http') &&
                !uri.isScheme('data')))) {
      throw const FormatException('Invalid proof');
    }
    return url!;
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
    final objectName = reversing ? null : await _proof(p);
    try {
      return await _read(() async {
        try {
          final service = client.generated.getKasKasirApi();
          final r = reversing
              ? await service.reverseCashMovement(
                  sessionId: id,
                  movementId: p.reverseId!,
                  reversalCommand: api.ReversalCommand(
                    requestId: p.requestId,
                    reason: p.reason,
                  ),
                )
              : await service.createCashMovement(
                  sessionId: id,
                  amount: p.amount,
                  kind: p.kind,
                  name: p.name,
                  reason: p.reason,
                  requestId: p.requestId,
                  proofObjectName: objectName,
                );
          if (r.statusCode != 201) throw const CashMovementUncertainException();
          final m = CashMovementRecord.fromJson(r.data!.data.toJson());
          if (m.sessionId != p.sessionId || m.requestId != p.requestId) {
            throw const CashMovementUncertainException();
          }
          return m;
        } on DioException catch (e) {
          if (e.response == null ||
              (e.response!.statusCode ?? 500) >= 500 ||
              e.type == DioExceptionType.unknown) {
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
