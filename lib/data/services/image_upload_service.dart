import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dikasa_api/dikasa_api.dart' as api;
import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';

/// Obtains a scoped intent, uploads bytes to Storage, then returns its object name.
class ImageUploadService {
  ImageUploadService(this.client);
  final ApiClient client;

  String _mime(String filename) =>
      filename.toLowerCase().endsWith('.png') ? 'image/png' : 'image/jpeg';

  void _validate(Uint8List bytes, String mime) {
    if (bytes.isEmpty ||
        bytes.length > 3145728 ||
        !['image/png', 'image/jpeg'].contains(mime)) {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Pilih gambar PNG/JPEG dengan ukuran maksimal 3 MB.',
      );
    }
  }

  Future<String> avatar(Uint8List bytes, String filename) async {
    final mime = _mime(filename);
    _validate(bytes, mime);
    final revision = client.authRevision;
    try {
      final intent =
          (await client.generated.getUserApi().createAvatarUploadIntent(
            avatarUploadIntentRequest: api.AvatarUploadIntentRequest.fromJson({
              'content_type': mime,
              'size': bytes.length,
            }),
          )).data?.data;
      if (intent == null) {
        throw const ApiException(
          type: ApiErrorType.parsing,
          message: 'Respons upload dari server tidak valid.',
        );
      }
      return await _put(
        intent.uploadUrl,
        intent.objectName,
        bytes,
        mime,
        revision,
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<String> product(Uint8List bytes, String mime) async {
    _validate(bytes, mime);
    final revision = client.authRevision;
    try {
      final intent =
          (await client.generated
                  .getKatalogApi()
                  .createProductImageUploadIntent(
                    productImageUploadIntentRequest:
                        api.ProductImageUploadIntentRequest.fromJson({
                          'content_type': mime,
                          'size': bytes.length,
                        }),
                  ))
              .data
              ?.data;
      if (intent == null) {
        throw const ApiException(
          type: ApiErrorType.parsing,
          message: 'Respons upload dari server tidak valid.',
        );
      }
      return await _put(
        intent.uploadUrl,
        intent.objectName,
        bytes,
        mime,
        revision,
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<String> cashProof(
    String sessionId,
    String requestId,
    Uint8List bytes,
    String filename,
  ) async {
    final mime = _mime(filename);
    _validate(bytes, mime);
    final revision = client.authRevision;
    try {
      final intent =
          (await client.generated.getKasKasirApi().createCashProofUploadIntent(
            sessionId: sessionId,
            proofUploadIntentRequest: api.ProofUploadIntentRequest.fromJson({
              'content_type': mime,
              'size': bytes.length,
              'request_id': requestId,
            }),
          )).data?.data;
      if (intent == null) {
        throw const ApiException(
          type: ApiErrorType.parsing,
          message: 'Respons upload dari server tidak valid.',
        );
      }
      return await _put(
        intent.uploadUrl,
        intent.objectName,
        bytes,
        mime,
        revision,
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<String> _put(
    String url,
    String objectName,
    Uint8List bytes,
    String mime,
    int revision,
  ) async {
    _ensureSession(revision);
    final uri = Uri.tryParse(url);
    if (uri == null ||
        uri.scheme != 'https' ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty ||
        objectName.isEmpty) {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Tautan upload dari server tidak valid.',
      );
    }
    // Dedicated Dio has no API authentication, cookies or request logging.
    await client.storage.put<void>(
      url,
      data: bytes,
      options: Options(contentType: mime, followRedirects: false),
    );
    _ensureSession(revision);
    return objectName;
  }

  void _ensureSession(int revision) {
    if (revision != client.authRevision) {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message:
            'Sesi berubah. Silakan masuk kembali sebelum menyimpan gambar.',
      );
    }
  }
}
