import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/sales_report.dart';

class ReportService {
  const ReportService(this.client);
  final ApiClient client;
  Future<T> _read<T>(Future<T> Function() f) async {
    try {
      return await f();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    } on TypeError {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format laporan tidak sesuai.',
      );
    } on FormatException {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format laporan tidak sesuai.',
      );
    } on ArgumentError {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Jenis laporan tidak sesuai.',
      );
    }
  }

  Future<ReportData> read(ReportKind kind, ReportFilter f) => _read(() async {
    final r = await client.dio.get<dynamic>(
      '/reports/${kind.name}',
      queryParameters: f.parameters(kind),
    );
    final data = ReportData.fromJson(Map<String, dynamic>.from(r.data as Map));
    if (data.kind != kind) throw const FormatException('Wrong report');
    return data;
  });
  Future<Uint8List> export(ReportKind kind, ReportFilter f) => _read(() async {
    final r = await client.dio.get<List<int>>(
      '/reports/${kind.name}/export.xlsx',
      queryParameters: f.parameters(kind, exporting: true),
      options: Options(responseType: ResponseType.bytes),
    );
    final bytes = Uint8List.fromList(r.data!);
    if (bytes.length < 4 || bytes[0] != 80 || bytes[1] != 75) {
      throw const FormatException('Not XLSX');
    }
    return bytes;
  });
}
