import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/account_profile.dart';
import 'package:mobile_dikasa/data/services/account_service.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/features/account/view.dart';

class VisualAccount extends AccountService {
  VisualAccount(super.c, {this.fail = false});
  final bool fail;
  @override
  Future<AccountProfile> profile() async {
    if (fail) {
      throw const ApiException(
        type: ApiErrorType.network,
        message: 'Koneksi profil terputus. Coba lagi.',
      );
    }
    return AccountProfile.fromJson({
      'id': '1',
      'first_name': 'Jane',
      'last_name': 'Doe',
      'username': 'admin',
      'phone_number': '081234567890',
      'email': 'jane@example.com',
      'date_of_birth': '1990-08-10',
      'gender_id': 'male',
      'personal_address': 'Jl. Kawaluyaan III No. 12 A',
      'has_pin': true,
      'can_change_password': true,
      'role': 'Kasir',
      'outlet_name': 'Warteg Bahari',
    });
  }

  @override
  Future<List<GenderOption>> genders() async => [
    GenderOption.fromJson({'id': 'male', 'name': 'Pria'}),
  ];
}

void main() {
  setUpAll(() async {
    for (final name in ['Regular', 'Medium', 'SemiBold', 'Bold', 'Italic']) {
      final l = FontLoader('Poppins')
        ..addFont(rootBundle.load('assets/fonts/Poppins-$name.ttf'));
      await l.load();
    }
    final l = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await l.load();
  });
  testWidgets('capture profile, credentials, responsive and error states', (
    t,
  ) async {
    dotenv.loadFromString(
      envString: 'API_BASE_URL=http://localhost/dikasa/v1\nUSE_MOCK_API=true',
    );
    final c = ApiClient();
    final a = AuthRepository(authService: AuthService(c), apiClient: c);
    await t.runAsync(() => a.login(username: 'admin', password: 'dikasa123'));
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.resetDevicePixelRatio);
    addTearDown(t.view.resetPhysicalSize);
    Future<void> shot(
      String name,
      Size size, {
      bool edit = false,
      bool credentials = false,
      bool fail = false,
    }) async {
      t.view.physicalSize = size;
      final key = GlobalKey();
      await t.pumpWidget(
        RepaintBoundary(
          key: key,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AccountSettingsView(
              key: UniqueKey(),
              service: VisualAccount(c, fail: fail),
              auth: a,
            ),
          ),
        ),
      );
      await t.pumpAndSettle();
      if (edit) {
        await t.ensureVisible(find.text('Ubah Profil'));
        await t.tap(find.text('Ubah Profil'));
        await t.pumpAndSettle();
        await t.drag(
          find.byType(SingleChildScrollView).first,
          const Offset(0, 2000),
        );
        await t.pumpAndSettle();
      }
      if (credentials) {
        await t.ensureVisible(find.text('PIN Akun'));
        await t.pumpAndSettle();
      }
      await t.runAsync(
        () => precacheImage(
          const AssetImage('assets/icons/account_design_gender.png'),
          key.currentContext!,
        ),
      );
      await t.pumpAndSettle();
      expect(t.takeException(), isNull);
      await t.runAsync(() async {
        final boundary =
            key.currentContext!.findRenderObject() as RenderRepaintBoundary;
        final image = await boundary.toImage();
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        final dir = Directory('build/account-qa')..createSync(recursive: true);
        File(
          '${dir.path}/$name.png',
        ).writeAsBytesSync(bytes!.buffer.asUint8List());
        image.dispose();
      });
    }

    await shot('desktop-profile', const Size(1340, 800));
    await shot('desktop-edit', const Size(1340, 800), edit: true);
    await shot('desktop-credentials', const Size(1340, 800), credentials: true);
    await shot('narrow-edit', const Size(390, 844), edit: true);
    await shot('profile-error', const Size(1340, 800), fail: true);
  }, skip: !const bool.fromEnvironment('CAPTURE_ACCOUNT'));
}
