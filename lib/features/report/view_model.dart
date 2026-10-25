import 'package:flutter/foundation.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/sales_report.dart';
import 'package:mobile_dikasa/data/services/report_service.dart';

/// Read-only account/request-scoped reports; no POS cart or till mutation.
class ReportViewModel extends ChangeNotifier {
  ReportViewModel({
    required this.service,
    required this.accountId,
    DateTime Function()? clock,
  }) : _account = accountId() {
    final today = reportDate(reportWib((clock ?? DateTime.now)()));
    filter = ReportFilter(startDate: today, endDate: today);
  }
  final ReportService service;
  final String? Function() accountId;
  final String? _account;
  late ReportFilter filter;
  ReportKind kind = ReportKind.summary;
  ReportData? report;
  String? error;
  bool loading = false, exporting = false, _disposed = false;
  int _request = 0;
  bool get current => !_disposed && accountId() == _account;
  void _notify() {
    if (current) notifyListeners();
  }

  Future<void> reload() async {
    if (!current) return;
    final generation = ++_request;
    final requested = kind, selected = filter;
    loading = true;
    report = null;
    error = null;
    _notify();
    try {
      final r = await service.read(requested, selected);
      if (current && generation == _request) report = r;
    } on ApiException catch (e) {
      if (current && generation == _request) error = e.message;
    } finally {
      if (current && generation == _request) {
        loading = false;
        _notify();
      }
    }
  }

  Future<void> setKind(ReportKind k) async {
    if (!current) return;
    kind = k;
    filter = filter.copyWith(query: '', sort: 'quantity_desc', page: 1);
    await reload();
  }

  Future<void> setQuery(String q) async {
    if (!current) return;
    filter = filter.copyWith(query: q.trim(), page: 1);
    await reload();
  }

  Future<void> setSort(String s) async {
    if (!current) return;
    filter = filter.copyWith(sort: s, page: 1);
    await reload();
  }

  Future<void> setPage(int n) async {
    if (!current || n < 1) return;
    filter = filter.copyWith(page: n);
    await reload();
  }

  Future<void> setDateRange(DateTime start, DateTime end) async {
    if (!current) return;
    final a = DateTime.utc(start.year, start.month, start.day),
        b = DateTime.utc(end.year, end.month, end.day);
    if (b.isBefore(a) || b.difference(a).inDays >= 366) {
      error = 'Pilih rentang maksimal366 hari.';
      _notify();
      return;
    }
    filter = filter.copyWith(
      startDate: reportDate(start),
      endDate: reportDate(end),
      page: 1,
    );
    await reload();
  }

  Future<bool> export(Future<bool> Function(Uint8List, String) save) async {
    if (!current || exporting) return false;
    final k = kind, f = filter;
    exporting = true;
    error = null;
    _notify();
    try {
      final b = await service.export(k, f);
      if (!current) return false;
      final ok = await save(
        b,
        'dikasa-${k.name}-${f.startDate}-${f.endDate}.xlsx',
      );
      return current && ok;
    } on ApiException catch (e) {
      if (current) error = e.message;
      return false;
    } finally {
      if (current) {
        exporting = false;
        _notify();
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _request++;
    super.dispose();
  }
}
