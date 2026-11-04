import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/data/models/product.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';

/// Returns a cart choice while retaining the real parent product ID.
Future<Product?> chooseProductVariation(
  BuildContext context,
  Product product,
) async {
  if (product.variations.isEmpty) return product;
  return showDialog<Product>(
    context: context,
    builder: (c) => AlertDialog(
      title: Text(product.name),
      content: SizedBox(
        width: 500.w,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final choice in [
                product,
                ...product.variations.map(product.selectVariant),
              ])
                ListTile(
                  title: Text(choice.variantName ?? 'Produk Utama'),
                  subtitle: Text(
                    choice.isAvailable ? formatRupiah(choice.price) : 'Habis',
                  ),
                  enabled: choice.isAvailable,
                  onTap: () => Navigator.pop(c, choice),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(c),
          child: const Text('Batal'),
        ),
      ],
    ),
  );
}
