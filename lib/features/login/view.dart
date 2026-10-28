import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_dikasa/components/app_loading_indicator.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_dikasa/components/text_field/main.dart';
import 'package:mobile_dikasa/core/constants/colors.dart';
import 'package:mobile_dikasa/core/routing/app_routes.dart';
import 'package:mobile_dikasa/core/themes/text_styles.dart';
import 'package:mobile_dikasa/core/utils/app_snackbar.dart';
import 'package:mobile_dikasa/features/login/view_model.dart';
import 'package:provider/provider.dart';

/// Halaman Login.
///
/// View tidak menyimpan state form sama sekali — nilai input, status loading,
/// dan pesan error semuanya dibaca dari [LoginViewModel]. Yang tersisa di sini
/// hanya urusan tampilan: layout responsif, `FormState`, dan navigasi.
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  /// Lebar minimum untuk menampilkan layout dua kolom seperti pada desain.
  static const double _twoColumnBreakpoint = 1000;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _onSubmit(LoginViewModel viewModel) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    FocusScope.of(context).unfocus();

    final bool isSuccess = await viewModel.submit();
    if (!isSuccess || !mounted) {
      return;
    }

    viewModel.reset();
    await Navigator.of(context).pushReplacementNamed(AppRoutes.newOrder);
  }

  @override
  Widget build(BuildContext context) {
    final LoginViewModel viewModel = context.read<LoginViewModel>();

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool isTwoColumn = constraints.maxWidth >= _twoColumnBreakpoint;

          final Widget form = _LoginForm(
            viewModel: viewModel,
            formKey: _formKey,
            onSubmit: () => _onSubmit(viewModel),
            compact: !isTwoColumn,
          );

          if (isTwoColumn) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Expanded(child: _HeroPanel()),
                Expanded(
                  child: SafeArea(child: _CenteredScrollable(child: form)),
                ),
              ],
            );
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 28.h),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 560.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: const AspectRatio(
                          aspectRatio: 670 / 460,
                          child: _HeroPanel(),
                        ),
                      ),
                      SizedBox(height: 28.h),
                      form,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CenteredScrollable extends StatelessWidget {
  const _CenteredScrollable({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Foto dapur dengan kalimat pembuka di atasnya, sesuai desain Figma.
class _HeroPanel extends StatelessWidget {
  const _HeroPanel();

  static const String _assetPath = 'assets/images/login_hero.png';
  static const String _headline =
      'Pilih Fitur Tambahan\nSesuai Kebutuhan\nRestaurant-mu';

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_assetPath),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(52.w, 60.h, 52.w, 52.h),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            _headline,
            style: TextStyle(
              color: AppColors.cFFFFFF,
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              height: 1.5,
              shadows: <Shadow>[
                // Foto latarnya terang di beberapa bagian; bayangan tipis
                // menjaga teks tetap terbaca.
                Shadow(color: AppColors.c4D0F0F0F, blurRadius: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.viewModel,
    required this.formKey,
    required this.onSubmit,
    required this.compact,
  });

  static const String _logoAssetPath = 'assets/images/dikasa_logo.png';

  final LoginViewModel viewModel;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmit;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 488.w),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Image.asset(
                _logoAssetPath,
                width: compact ? 280 : 345,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: compact ? 40 : 56),
            Text(
              'Masuk ke Dashboard',
              textAlign: TextAlign.center,
              style: AppTextStyles.formTitle.copyWith(
                fontSize: compact ? 20 : 22,
              ),
            ),
            SizedBox(height: compact ? 48 : 100),
            _UsernameField(viewModel: viewModel),
            SizedBox(height: 34.h),
            _PasswordField(viewModel: viewModel, onSubmit: onSubmit),
            const _ErrorBanner(),
            SizedBox(height: compact ? 40 : 62),
            _SubmitButton(viewModel: viewModel, onSubmit: onSubmit),
            SizedBox(height: 18.h),
            const _SecondaryActions(),
          ],
        ),
      ),
    );
  }
}

/// Kolom isian dengan gaya seragam: abu-abu polos tanpa garis tepi.
class _LoginTextField extends StatelessWidget {
  const _LoginTextField({
    required this.hintText,
    required this.iconAssetPath,
    required this.onChanged,
    required this.validator,
    required this.enabled,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.onFieldSubmitted,
    this.suffixIcon,
  });

  final String hintText;
  final String iconAssetPath;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final bool enabled;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onFieldSubmitted;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintText: hintText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      enabled: enabled,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      backgroundColor: AppColors.cEDEDED,
      borderColor: AppColors.cEDEDED,
      focusedBorderColor: AppColors.c097BC2,
      textStyle: AppTextStyles.input,
      hintStyle: AppTextStyles.inputHint,
      borderRadius: 10,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
      prefixIcon: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 14.w, 14.h),
        child: SvgPicture.asset(
          iconAssetPath,
          width: 24.w,
          height: 24.h,
          colorFilter: ColorFilter.mode(AppColors.cA4A4A4, BlendMode.srcIn),
        ),
      ),
      suffixIcon: suffixIcon,
    );
  }
}

class _UsernameField extends StatelessWidget {
  const _UsernameField({required this.viewModel});

  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _LoginTextField(
        hintText: 'Username atau Nomor Hp',
        iconAssetPath: 'assets/icons/user_square_icon.svg',
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        enabled: !viewModel.isSubmitting,
        onChanged: viewModel.onUsernameChanged,
        validator: viewModel.validateUsername,
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({required this.viewModel, required this.onSubmit});

  final LoginViewModel viewModel;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _LoginTextField(
        hintText: 'Password',
        iconAssetPath: 'assets/icons/lock_icon.svg',
        textInputAction: TextInputAction.done,
        obscureText: viewModel.isPasswordHidden,
        enabled: !viewModel.isSubmitting,
        onChanged: viewModel.onPasswordChanged,
        onFieldSubmitted: (_) => onSubmit(),
        validator: viewModel.validatePassword,
        suffixIcon: IconButton(
          onPressed: viewModel.togglePasswordVisibility,
          tooltip: viewModel.isPasswordHidden
              ? 'Tampilkan password'
              : 'Sembunyikan password',
          icon: viewModel.isPasswordHidden
              ? SvgPicture.asset(
                  'assets/icons/eye_slash_icon.svg',
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    AppColors.cA4A4A4,
                    BlendMode.srcIn,
                  ),
                )
              : Icon(
                  Icons.visibility_outlined,
                  size: 24.r,
                  color: AppColors.cA4A4A4,
                ),
        ),
      ),
    );
  }
}

/// Menampilkan pesan kegagalan login dari server / jaringan.
class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner();

  @override
  Widget build(BuildContext context) {
    final LoginViewModel viewModel = context.read<LoginViewModel>();

    return Observer(
      builder: (_) {
        final String? message = viewModel.errorMessage;
        if (message == null) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.error_outline, size: 18.r, color: AppColors.c9D1414),
              SizedBox(width: 8.w),
              Expanded(child: Text(message, style: AppTextStyles.error)),
            ],
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.viewModel, required this.onSubmit});

  final LoginViewModel viewModel;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => SizedBox(
        height: 54.h,
        child: ElevatedButton(
          // Tombol tetap aktif meski field kosong, mengikuti desain.
          // Field yang belum diisi ditangkap oleh validator form.
          onPressed: viewModel.isSubmitting ? null : onSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.cFF8227,
            foregroundColor: AppColors.cFFFFFF,
            disabledBackgroundColor: AppColors.cFF8227,
            disabledForegroundColor: AppColors.cFFFFFF,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            textStyle: AppTextStyles.button.copyWith(
              fontSize: 19.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: viewModel.isSubmitting
              ? AppLoadingIndicator(compact: true, color: AppColors.cFFFFFF)
              : const Text('Masuk'),
        ),
      ),
    );
  }
}

class _SecondaryActions extends StatelessWidget {
  const _SecondaryActions();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 16.w,
      runSpacing: 8.h,
      children: <Widget>[
        _LinkButton(
          label: 'Daftar Akun Baru',
          onPressed: () => _showComingSoon(context, 'Pendaftaran akun'),
        ),
        _LinkButton(
          label: 'Lupa Password',
          onPressed: () => _showComingSoon(context, 'Pemulihan password'),
        ),
      ],
    );
  }

  void _showComingSoon(BuildContext context, String feature) =>
      showAppSnackBar(context, '$feature belum tersedia.');
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.c097BC2,
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 36),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: AppTextStyles.button.copyWith(fontWeight: FontWeight.w600),
      ),
      child: Text(label),
    );
  }
}
