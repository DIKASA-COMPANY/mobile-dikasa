/// Sesi kas aktif milik outlet pengguna.
class CashSession {
  const CashSession({
    required this.id,
    required this.openingCash,
    required this.openedAt,
  });

  final String id;
  final int openingCash;
  final DateTime openedAt;
}
