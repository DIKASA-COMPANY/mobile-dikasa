/// Semua path endpoint API dipusatkan di sini agar tidak tersebar di Service.
class ApiEndpoints {
  const ApiEndpoints._();

  static const String login = '/login';
  static const String profile = '/users/me';
  static const String products = '/products';
}
