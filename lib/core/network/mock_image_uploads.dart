import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';

/// Shared demo Storage state follows the same intent/PUT/adopt flow as production.
class MockImageUploads {
  final _uploads = <String, ({String mime, Uint8List? bytes})>{};
  int _serial = 0;

  Uint8List? bytes(String? objectName) => _uploads[objectName]?.bytes;
  String? publicUrl(String? objectName) {
    final upload = _uploads[objectName];
    if (upload?.bytes == null) return null;
    return 'data:${upload!.mime};base64,${base64Encode(upload.bytes!)}';
  }

  bool handle(RequestOptions o, RequestInterceptorHandler h) {
    void reply(Object? data) => h.resolve(
      Response<dynamic>(requestOptions: o, statusCode: 200, data: data),
    );
    if (o.uri.host == 'storage.mock.dikasa' && o.method == 'PUT') {
      final objectName = o.uri.path.substring(1);
      final pending = _uploads[objectName];
      if (pending == null) return false;
      _uploads[objectName] = (
        mime: pending.mime,
        bytes: Uint8List.fromList(o.data as List<int>),
      );
      reply(null);
      return true;
    }
    if (o.method != 'POST') return false;
    final prefix = o.path == '/users/me/avatar-upload-intents'
        ? 'avatars'
        : o.path == '/products/image-upload-intents'
        ? 'products'
        : RegExp(
            r'^/cash-sessions/[^/]+/movement-proof-upload-intents$',
          ).hasMatch(o.path)
        ? 'cash-proofs'
        : null;
    if (prefix == null) return false;
    final body =
        (o.data is String ? jsonDecode(o.data as String) : o.data) as Map;
    final mime = body['content_type'] as String;
    final objectName =
        '$prefix/mock-${++_serial}.${mime == 'image/png' ? 'png' : 'jpg'}';
    _uploads[objectName] = (mime: mime, bytes: null);
    reply({
      'data': {
        'upload_url': 'https://storage.mock.dikasa/$objectName',
        'object_name': objectName,
        'expires_in': 7200,
      },
    });
    return true;
  }
}
