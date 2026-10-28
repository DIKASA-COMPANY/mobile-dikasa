import 'widgets/payment_success_view.dart';
import '../cash_movement/view.dart';
import '../account/view.dart';
import 'package:mobile_dikasa/features/report/main.dart';
import 'widgets/cash_sessions_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_dikasa/components/app_loading_indicator.dart';
import 'package:mobile_dikasa/core/constants/colors.dart';
import 'package:mobile_dikasa/core/routing/app_routes.dart';
import 'package:mobile_dikasa/core/themes/text_styles.dart';
import 'package:mobile_dikasa/core/utils/app_snackbar.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/features/new_order/widgets/catalog_filter_bar.dart';
import 'package:mobile_dikasa/features/new_order/widgets/opening_cash_dialog.dart';
import 'package:mobile_dikasa/features/new_order/widgets/order_panel.dart';
import 'package:mobile_dikasa/features/new_order/widgets/order_top_bar.dart';
import 'package:mobile_dikasa/features/new_order/widgets/product_catalog.dart';
import 'package:mobile_dikasa/features/new_order/widgets/payment_dialog.dart';
import 'package:mobile_dikasa/features/new_order/widgets/sales_browser.dart';
import 'package:provider/provider.dart';
import 'widgets/variation_picker.dart';
import 'package:mobile_dikasa/features/product/view.dart';

/// Halaman Order — layar utama kasir setelah login.
///
/// Kiri berisi katalog produk, kanan berisi pesanan yang sedang disusun.
class NewOrderView extends StatefulWidget {
  const NewOrderView({super.key});

  @override
  State<NewOrderView> createState() => _NewOrderViewState();
}

class _NewOrderViewState extends State<NewOrderView> {
  /// Lebar panel pesanan pada layar tablet, mengikuti proporsi desain.
  static const double _orderPanelWidth = 450;

  /// Di bawah lebar ini panel pesanan dipindah ke bawah katalog agar
  /// keduanya tetap terbaca.
  static const double _twoColumnBreakpoint = 1000;

  late final NewOrderViewModel _viewModel;
  bool _checkoutOpen = false;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<NewOrderViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _viewModel.loadProducts(forceRefresh: true);
      await _viewModel.loadPos();
      if (!mounted) return;
      if (_viewModel.checkoutError == null) await _askOpeningCash();
    });
  }

  /// Menanyakan kas awal sekali saja per sesi kasir.
  Future<void> _askOpeningCash({bool force = false}) async {
    if (!force && _viewModel.isOpeningCashResolved) {
      return;
    }

    final int? amount = await OpeningCashDialog.show(
      context,
      onConfirm: (amount) async {
        final saved = await _viewModel.openCash(amount);
        return saved
            ? null
            : _viewModel.checkoutError ?? 'Kas awal belum tersimpan.';
      },
    );
    if (amount == null) _viewModel.confirmOpeningCash(null);
  }

  Future<void> _pay() async {
    if (_checkoutOpen || _viewModel.isPaying || !_viewModel.hasOrderItems) {
      return;
    }
    _checkoutOpen = true;
    try {
      if (_viewModel.cashSession == null) await _askOpeningCash(force: true);
      if (!mounted || _viewModel.cashSession == null) return;
      final paymentGeneration = _viewModel.authRepository.sessionGeneration;
      final paymentUser = _viewModel.currentUser;
      final receipt = await PaymentDialog.show(context, _viewModel);
      if (!mounted || receipt == null) return;
      await _viewModel.loadProducts(forceRefresh: true);
      if (!mounted) return;
      if (_viewModel.authRepository.sessionGeneration != paymentGeneration ||
          _viewModel.currentUser?.id != paymentUser?.id) {
        return;
      }
      final history = await PaymentSuccessView.show(
        context,
        receipt,
        paymentUser,
        auth: _viewModel.authRepository,
        onLock: _onLockPressed,
      );
      if (mounted &&
          history == true &&
          _viewModel.authRepository.sessionGeneration == paymentGeneration &&
          _viewModel.currentUser?.id == paymentUser?.id) {
        await SalesBrowser.show(context, _viewModel);
      }
    } finally {
      _checkoutOpen = false;
    }
  }

  void _onLockPressed() {
    if (_viewModel.isPaying ||
        _viewModel.paymentUncertain ||
        _viewModel.draftLocked) {
      showAppSnackBar(
        context,
        'Selesaikan pemeriksaan pembayaran sebelum mengunci kasir.',
      );
      return;
    }
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutes.login, (Route<dynamic> route) => false);
  }

  Future<void> _showCashDrawer() async {
    if (_viewModel.isPaying ||
        _viewModel.paymentUncertain ||
        (_viewModel.draftLocked && !_viewModel.cashMovementActive)) {
      showAppSnackBar(
        context,
        'Selesaikan operasi kasir yang sedang berjalan.',
      );
      return;
    }
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            CashMovementView(viewModel: _viewModel, onLock: _onLockPressed),
      ),
    );
    if (mounted) setState(() {});
  }

  Future<void> _onMenuPressed() async {
    final openCatalog = await showModalBottomSheet<bool>(
      context: context,
      builder: (c) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.account_balance_wallet_outlined),
              title: const Text('Kas Kasir / Uang Masuk-Keluar'),
              onTap: () {
                Navigator.pop(c, false);
                _showCashDrawer();
              },
            ),
            ListTile(
              leading: const Icon(Icons.manage_accounts_outlined),
              title: const Text('Pengaturan Akun'),
              onTap: () async {
                Navigator.pop(c, false);
                if (_viewModel.isPaying ||
                    _viewModel.paymentUncertain ||
                    _viewModel.draftLocked) {
                  showAppSnackBar(
                    context,
                    'Selesaikan operasi kasir yang sedang berjalan.',
                  );
                  return;
                }
                await Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AccountSettingsView(
                      viewModel: _viewModel.createAccountSettingsViewModel(),
                      onLock: _onLockPressed,
                    ),
                  ),
                );
                if (mounted) setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics_outlined),
              title: const Text('Laporan Penjualan'),
              onTap: () {
                Navigator.pop(c, false);
                if (_viewModel.isPaying ||
                    _viewModel.paymentUncertain ||
                    _viewModel.draftLocked) {
                  showAppSnackBar(
                    context,
                    'Selesaikan operasi kasir yang sedang berjalan.',
                  );
                  return;
                }
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SalesReportsView(
                      viewModel: _viewModel.createReportViewModel(),
                      user: _viewModel.currentUser,
                      onLock: _onLockPressed,
                      onCashDrawer: _showCashDrawer,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.point_of_sale),
              title: const Text('Sesi Kas / Tutup Kas'),
              onTap: () {
                Navigator.pop(c, false);
                CashSessionsDialog.show(context, _viewModel);
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory_2_outlined),
              title: const Text('Katalog Produk'),
              subtitle: const Text('Produk, harga, dan kategori'),
              onTap: () => Navigator.pop(c, true),
            ),
            ListTile(
              leading: const Icon(Icons.point_of_sale),
              title: const Text('Kembali ke kasir'),
              onTap: () => Navigator.pop(c, false),
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Muat ulang Katalog'),
              onTap: () async {
                Navigator.pop(c, false);
                if (_viewModel.isPaying ||
                    _viewModel.paymentUncertain ||
                    _viewModel.draftLocked) {
                  showAppSnackBar(
                    context,
                    'Periksa hasil pembayaran dahulu di Daftar Order.',
                  );
                  return;
                }
                await _viewModel.loadProducts(forceRefresh: true);
                if (!mounted) return;
                showAppSnackBar(
                  context,
                  _viewModel.errorMessage ??
                      'Katalog dimuat ulang. Periksa harga/stok; hapus dan tambahkan ulang item yang berubah.',
                );
              },
            ),
          ],
        ),
      ),
    );
    if (openCatalog != true || !mounted) return;
    if (_checkoutOpen ||
        _viewModel.isPaying ||
        _viewModel.paymentUncertain ||
        _viewModel.hasOrderItems) {
      showAppSnackBar(
        context,
        'Selesaikan atau hapus pesanan sebelum mengubah katalog.',
      );
      return;
    }
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => CatalogView(
          viewModel: _viewModel.createCatalogViewModel(),
          user: _viewModel.currentUser,
        ),
      ),
    );
    if (mounted) {
      await _viewModel.loadProducts(forceRefresh: true);
      _viewModel.selectCategory(allCategoriesFilter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: OrderTopBar(
        user: _viewModel.currentUser,
        onMenuPressed: _onMenuPressed,
        onLockPressed: _onLockPressed,
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Widget catalog = _CatalogColumn(viewModel: _viewModel);
            final Widget panel = OrderPanel(viewModel: _viewModel, onPay: _pay);

            if (constraints.maxWidth < _twoColumnBreakpoint) {
              return Column(
                children: <Widget>[
                  Expanded(child: catalog),
                  SizedBox(height: constraints.maxHeight * 0.45, child: panel),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: catalog),
                SizedBox(width: _orderPanelWidth, child: panel),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CatalogColumn extends StatelessWidget {
  const _CatalogColumn({required this.viewModel});

  final NewOrderViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CatalogFilterBar(viewModel: viewModel),
        Expanded(
          child: Observer(
            builder: (_) {
              if (viewModel.isLoading && viewModel.products.isEmpty) {
                return const Center(child: AppLoadingIndicator());
              }

              final String? error = viewModel.errorMessage;
              if (error != null && viewModel.products.isEmpty) {
                return _CatalogError(
                  message: error,
                  onRetry: () => viewModel.loadProducts(forceRefresh: true),
                );
              }

              return ProductCatalog(
                products: viewModel.visibleProducts,
                onProductSelected: (p) async {
                  final choice = await chooseProductVariation(context, p);
                  if (choice == null || !context.mounted) return;
                  if (!viewModel.canAddProduct(choice)) {
                    showAppSnackBar(
                      context,
                      'Stok tidak cukup atau pesanan sedang diproses.',
                    );
                    return;
                  }
                  viewModel.addProduct(choice);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CatalogError extends StatelessWidget {
  const _CatalogError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.cloud_off, size: 48.r, color: AppColors.cA4A4A4),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cFF8227,
                foregroundColor: AppColors.cFFFFFF,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                textStyle: AppTextStyles.button,
              ),
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
