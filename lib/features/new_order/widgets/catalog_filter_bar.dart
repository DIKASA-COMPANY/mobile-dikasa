import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_dikasa/core/constants/colors.dart';
import 'package:mobile_dikasa/core/themes/text_styles.dart';
import 'package:mobile_dikasa/data/models/product.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/features/new_order/widgets/panel_dropdown.dart';

/// Panel biru di atas katalog: tab kelompok produk, filter kategori,
/// dan kolom pencarian.
class CatalogFilterBar extends StatelessWidget {
  const CatalogFilterBar({super.key, required this.viewModel});

  final NewOrderViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.c2C5E7A,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 26.h, 24.w, 26.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _GroupTabs(viewModel: viewModel),
            SizedBox(height: 20.h),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 268.w,
                  child: Observer(
                    builder: (_) => PanelDropdown<String>(
                      label: viewModel.selectedCategory,
                      options: viewModel.categories,
                      optionLabel: (String category) => category,
                      onSelected: viewModel.selectCategory,
                      isActive:
                          viewModel.selectedCategory != allCategoriesFilter,
                    ),
                  ),
                ),
                SizedBox(width: 24.w),
                Expanded(child: _SearchField(viewModel: viewModel)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupTabs extends StatelessWidget {
  const _GroupTabs({required this.viewModel});

  final NewOrderViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Row(
        children: ProductGroup.values
            .map(
              (ProductGroup group) => Expanded(
                child: Observer(
                  builder: (_) => _GroupTab(
                    label: group.label,
                    isActive: viewModel.selectedGroup == group,
                    onPressed: () => viewModel.selectGroup(group),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _GroupTab extends StatelessWidget {
  const _GroupTab({
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? AppColors.c529DC8 : AppColors.cE6E6E6,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 44.h,
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.button.copyWith(
                color: isActive ? AppColors.cFFFFFF : AppColors.c656565,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.viewModel});

  final NewOrderViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: TextField(
        onChanged: viewModel.onSearchChanged,
        style: AppTextStyles.body,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: 'Cari Nama Produk',
          hintStyle: AppTextStyles.body.copyWith(
            color: AppColors.cA4A4A4,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: AppColors.cFFFFFF,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          prefixIcon: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 12.w, 12.h),
            child: SvgPicture.asset(
              'assets/icons/search_icon.svg',
              width: 20.w,
              height: 20.h,
              colorFilter: ColorFilter.mode(AppColors.cA4A4A4, BlendMode.srcIn),
            ),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 0.w),
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
        ),
      ),
    );
  }

  OutlineInputBorder get _border => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide.none,
  );
}
