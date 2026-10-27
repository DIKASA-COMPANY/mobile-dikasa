/// Semua path endpoint API dipusatkan di sini agar tidak tersebar di Service.
class ApiEndpoints {
  const ApiEndpoints._();

  static const String login = '/login';
  static const String currentUser = '/users/me';
  static const String cashSessions = '/cash-sessions';
  static const String currentCashSession = '/cash-sessions/current';
  static const String orderTypes = '/order-types';
  static const String products = '/products';
}
