import 'dart:convert';
import 'package:dio/dio.dart';

/// Applies explicit JSON parts unsupported by the pinned dart-dio generator.
class GeneratedMultipartInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final parts = options.extra.remove('jsonMultipartParts');
    final form = options.data;
    if (parts is Map<String, dynamic> && form is FormData) {
      for (final entry in parts.entries) {
        form.fields.removeWhere(
          (f) => f.key == entry.key || f.key.startsWith('${entry.key}['),
        );
        form.files.removeWhere((f) => f.key == entry.key);
        if (entry.value != null) {
          form.files.add(
            MapEntry(
              entry.key,
              MultipartFile.fromString(
                jsonEncode(entry.value),
                contentType: DioMediaType('application', 'json'),
              ),
            ),
          );
        }
      }
    }
    handler.next(options);
  }
}
