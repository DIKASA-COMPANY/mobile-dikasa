import 'package:mobile_dikasa/data/models/cash_session.dart';
import 'package:mobile_dikasa/data/services/cash_session_service.dart';

class CashSessionRepository {
  CashSessionRepository({required CashSessionService cashSessionService})
    : _cashSessionService = cashSessionService;

  final CashSessionService _cashSessionService;
  CashSession? _current;

  CashSession? get current => _current;

  Future<CashSession?> getCurrent({bool forceRefresh = false}) async {
    if (!forceRefresh && _current != null) {
      return _current;
    }
    _current = await _cashSessionService.getCurrent();
    return _current;
  }

  Future<CashSession> open(int amount) async {
    _current = await _cashSessionService.open(amount);
    return _current!;
  }
}
