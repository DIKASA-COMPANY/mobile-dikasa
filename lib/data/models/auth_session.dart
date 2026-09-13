import 'package:mobile_dikasa/data/models/user.dart';

/// Hasil login: token akses beserta data pengguna pemiliknya.
class AuthSession {
  const AuthSession({
    required this.token,
    required this.refreshToken,
    required this.expiresInSeconds,
    required this.user,
  });

  final String token;
  final String refreshToken;
  final int expiresInSeconds;
  final User user;
}
