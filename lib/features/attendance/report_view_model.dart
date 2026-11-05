import 'package:flutter/foundation.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'models.dart';
import 'repository.dart';

class AttendanceReportViewModel extends ChangeNotifier {
  AttendanceReportViewModel(this._repository, {DateTime? now})
    : from = workDate(now ?? DateTime.now()),
      to = workDate(now ?? DateTime.now());
  final AttendanceRepository _repository;
  String from, to;
  String? error;
  bool busy = false, _disposed = false;
  List<AttendanceEntry> entries = const [];
  Future<void> load({String? start, String? end}) async {
    if (busy || _disposed) return;
    final nextFrom = start ?? from, nextTo = end ?? to;
    final a = DateTime.tryParse(nextFrom), b = DateTime.tryParse(nextTo);
    if (a == null ||
        b == null ||
        b.isBefore(a) ||
        b.difference(a).inDays > 30) {
      error = 'Pilih rentang maksimal 31 hari.';
      notifyListeners();
      return;
    }
    from = nextFrom;
    to = nextTo;
    busy = true;
    error = null;
    entries = const [];
    notifyListeners();
    try {
      entries = await _repository.history(from, to);
    } on ApiException catch (e) {
      error = e.message;
    } catch (_) {
      error = 'Laporan gagal dimuat. Silakan coba lagi.';
    } finally {
      busy = false;
      if (!_disposed) notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
