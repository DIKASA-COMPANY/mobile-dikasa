import 'dart:ui' as ui;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';

/// Replaceable platform boundary: tests never need a native file dialog.
class AccountFiles {
  const AccountFiles();
  Future<CatalogImage?> pickImage() async {
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg'],
      );
      if (file == null) return null;
      final length = await file.length();
      if (length == null || length < 1 || length > 3 * 1024 * 1024) {
        throw const ApiException(
          type: ApiErrorType.parsing,
          message: 'Pilih gambar PNG/JPEG maksimal 3 MiB.',
        );
      }
      final bytes = await file.readAsBytes();
      if (bytes.length > 3 * 1024 * 1024) {
        throw const ApiException(
          type: ApiErrorType.parsing,
          message: 'Ukuran gambar maksimal 3 MiB.',
        );
      }
      final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
      try {
        final descriptor = await ui.ImageDescriptor.encoded(buffer);
        try {
          if (descriptor.width > 4096 ||
              descriptor.height > 4096 ||
              descriptor.width * descriptor.height > 16000000) {
            throw const ApiException(
              type: ApiErrorType.parsing,
              message:
                  'Resolusi gambar terlalu besar (maksimal 4096 px per sisi dan 16 megapiksel).',
            );
          }
        } finally {
          descriptor.dispose();
        }
      } finally {
        buffer.dispose();
      }
      final ext = file.name.split('.').last.toLowerCase();
      if (!['png', 'jpg', 'jpeg'].contains(ext)) {
        throw const ApiException(
          type: ApiErrorType.parsing,
          message: 'Gunakan berkas PNG atau JPEG.',
        );
      }
      return CatalogImage(
        name: file.name,
        bytes: bytes,
        mimeType: ext == 'png' ? 'image/png' : 'image/jpeg',
      );
    } on ApiException {
      rethrow;
    } on PlatformException {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Pemilih berkas tidak dapat dibuka. Coba kembali.',
      );
    } catch (_) {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Gambar tidak dapat dibaca. Pilih PNG/JPEG yang valid.',
      );
    }
  }
}
