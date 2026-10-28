/// Pilihan jenis order yang dikonfigurasi oleh outlet di backend.
class OrderType {
  const OrderType({required this.id, required this.code, required this.label});

  final String id;
  final String code;
  final String label;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OrderType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
