import 'package:mobile_dikasa/data/models/user.dart';

/// Hasil login: token akses beserta data pengguna pemiliknya.
class AuthSession {
  const AuthSession({
    required this.token,
    this.refreshToken = '',
    this.expiresInSeconds = 0,
    required this.user,
  });

  final String token;
  final String refreshToken;
  final int expiresInSeconds;
  final User user;

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(
      token: json['token'] as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
      expiresInSeconds: (json['expires_in'] as num?)?.toInt() ?? 0,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
