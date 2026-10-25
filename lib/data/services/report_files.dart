import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';

class ReportFiles {
  const ReportFiles();
  Future<bool> saveWorkbook(Uint8List bytes, {required String filename}) async {
    try {
      return await FilePicker.saveFile(
            fileName: filename,
            bytes: bytes,
            type: FileType.custom,
            allowedExtensions: ['xlsx'],
          ) !=
          null;
    } catch (_) {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Workbook laporan tidak dapat disimpan. Coba kembali.',
      );
    }
  }
}
