/// Kelompok besar produk, sesuai tiga tab pada halaman Order.
enum ProductGroup {
  makanan('Makanan'),
  minuman('Minuman'),
  tambahan('Tambahan');

  const ProductGroup(this.label);

  /// Teks yang ditampilkan pada tab.
  final String label;

  static ProductGroup fromApi(String? value) {
    return switch (value) {
      'drink' || 'minuman' => ProductGroup.minuman,
      'additional' || 'tambahan' => ProductGroup.tambahan,
      _ => ProductGroup.makanan,
    };
  }
}

/// Satu produk yang bisa dipesan.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.group,
    required this.category,
    required this.isHighlighted,
    required this.isAvailable,
    this.imageUrl,
    this.imageAsset,
  });

  final String id;
  final String name;
  final int price;

  /// URL Firebase/backend untuk data nyata.
  final String? imageUrl;

  /// Fallback asset lokal untuk data demo dan produk tanpa gambar.
  final String? imageAsset;

  final ProductGroup group;

  /// Kategori yang dipakai oleh dropdown "Filter Kategori".
  final String category;

  /// Pada desain Figma sebagian nama produk dicetak merah.
  /// Arti pastinya belum dikonfirmasi ke tim desain - dugaan sementara
  /// adalah penanda stok menipis. Sementara ini hanya memengaruhi warna teks.
  final bool isHighlighted;
  final bool isAvailable;
}
