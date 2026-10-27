/// Data pengguna yang sedang login.
///
/// Model hanya mendefinisikan bentuk data dan cara membacanya dari JSON.
/// Tidak ada logika tampilan maupun jaringan di sini.
class User {
  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.roleId,
    required this.phoneNumber,
    this.outletId,
    this.email,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String username;
  final String roleId;
  final String phoneNumber;
  final String? outletId;
  final String? email;
  final String? avatarUrl;

  /// Kontrak backend saat ini hanya mengirim ID outlet, bukan nama outlet.
  String get outletLabel => outletId == null ? '-' : 'Outlet aktif';

  /// Inisial nama untuk ditampilkan pada avatar dashboard.
  String get initials {
    final List<String> parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) {
      return '?';
    }
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
