import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_remote_image.dart';
import 'package:mobile_dikasa/core/constants/colors.dart';
import 'package:mobile_dikasa/core/themes/text_styles.dart';
import 'package:mobile_dikasa/core/utils/formatted_currency.dart';
import 'package:mobile_dikasa/data/models/product.dart';

/// Grid produk yang bisa dipilih kasir.
class ProductCatalog extends StatelessWidget {
  const ProductCatalog({
    super.key,
    required this.products,
    required this.onProductSelected,
  });

  /// Lebar maksimum satu kartu; jumlah kolom mengikuti lebar yang tersedia.
  static const double _maxCardWidth = 280;

  final List<Product> products;
  final ValueChanged<Product> onProductSelected;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Center(
        child: Text(
          'Produk tidak ditemukan.',
          style: AppTextStyles.body.copyWith(color: AppColors.c8F8F8F),
        ),
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int columnCount = (constraints.maxWidth / _maxCardWidth)
            .floor()
            .clamp(1, 4);

        return GridView.builder(
          padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 32,
            mainAxisExtent: 110,
          ),
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            final Product product = products[index];
            return ProductCard(
              product: product,
              onPressed: () => onProductSelected(product),
            );
          },
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onPressed,
  });

  final Product product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cEDEDED,
      borderRadius: BorderRadius.circular(8.r),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shadowColor: AppColors.c4D0F0F0F,
      child: InkWell(
        onTap: product.isAvailable ? onPressed : null,
        child: Row(
          children: <Widget>[
            product.imageUrl != null
                ? AppRemoteImage(
                    url: product.imageUrl!,
                    width: 108.w,
                    height: 110.h,
                    fit: BoxFit.cover,
                    fallback: SizedBox(
                      width: 108.w,
                      height: 110.h,
                      child: Icon(Icons.image_not_supported_outlined),
                    ),
                  )
                : Image.asset(
                    product.imageAsset,
                    width: 108.w,
                    height: 110.h,
                    fit: BoxFit.cover,
                    // Katalog nanti diisi dari backend; gambar yang hilang tidak
                    // boleh membuat seluruh grid gagal digambar.
                    errorBuilder: (_, _, _) => Container(
                      width: 108.w,
                      height: 110.h,
                      color: AppColors.cD9D9D9,
                      child: Icon(
                        Icons.restaurant_menu,
                        color: AppColors.c8F8F8F,
                        size: 28.r,
                      ),
                    ),
                  ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(14.w, 12.h, 10.w, 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.sectionTitle.copyWith(
                          fontSize: 15.sp,
                          height: 1.3,
                          color: product.isHighlighted
                              ? AppColors.c9D1414
                              : AppColors.c37474F,
                        ),
                      ),
                    ),
                    Text(
                      product.isAvailable
                          ? formatRupiah(product.price)
                          : 'Habis',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.c546168,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
