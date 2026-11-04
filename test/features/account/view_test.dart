import 'dart:async';
import 'package:mobile_dikasa/data/models/account_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/services/account_service.dart';
import 'package:mobile_dikasa/features/account/view.dart';
import 'package:mobile_dikasa/features/account/view_model.dart';

class DeferredCredentialService extends AccountService {
  DeferredCredentialService(super.c);
  final pending = Completer<void>();
  @override
  Future<AccountProfile> profile() async => AccountProfile.fromJson({
    'id': '1',
    'first_name': 'Jane',
    'has_pin': false,
    'can_change_password': true,
  });
  @override
  Future<List<GenderOption>> genders() async => [];
  @override
  Future<void> changePIN(String current, String next, String confirmation) =>
      pending.future;
}

void main() {
  testWidgets('profile edit and PIN setup work at narrow width', (t) async {
    dotenv.loadFromString(
      envString: 'API_BASE_URL=http://localhost/dikasa/v1\nUSE_MOCK_API=true',
    );
    final client = ApiClient();
    final auth = AuthRepository(
      authService: AuthService(client),
      apiClient: client,
    );
    await t.runAsync(
      () => auth.login(username: 'admin', password: 'dikasa123'),
    );
    t.view.physicalSize = const Size(390, 844);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.resetPhysicalSize);
    addTearDown(t.view.resetDevicePixelRatio);
    await t.pumpWidget(
      MaterialApp(
        home: AccountSettingsView(
          viewModel: AccountSettingsViewModel(AccountService(client), auth),
        ),
      ),
    );
    await t.pumpAndSettle();
    expect(find.text('Informasi Profil'), findsOneWidget);
    expect(t.takeException(), isNull);
    await t.ensureVisible(find.text('Ubah Profil'));
    await t.tap(find.text('Ubah Profil'));
    await t.pumpAndSettle();
    await t.ensureVisible(find.widgetWithText(TextFormField, 'Nama Depan'));
    await t.enterText(
      find.widgetWithText(TextFormField, 'Nama Depan'),
      'Janet',
    );
    await t.ensureVisible(find.text('Simpan Profil'));
    await t.tap(find.text('Simpan Profil'));
    await t.pumpAndSettle();
    expect(auth.currentUser!.name, contains('Janet'));
    expect(t.takeException(), isNull);
  });
  testWidgets(
    'initial PIN becomes change PIN and password persists for next mock login',
    (t) async {
      dotenv.loadFromString(
        envString: 'API_BASE_URL=http://localhost/dikasa/v1\nUSE_MOCK_API=true',
      );
      final c = ApiClient();
      final a = AuthRepository(authService: AuthService(c), apiClient: c);
      await t.runAsync(() => a.login(username: 'admin', password: 'dikasa123'));
      t.view.physicalSize = const Size(1340, 800);
      t.view.devicePixelRatio = 1;
      addTearDown(t.view.resetPhysicalSize);
      addTearDown(t.view.resetDevicePixelRatio);
      await t.pumpWidget(
        MaterialApp(
          home: AccountSettingsView(
            viewModel: AccountSettingsViewModel(AccountService(c), a),
          ),
        ),
      );
      await t.pumpAndSettle();
      Future<void> fill(String label, String value) async {
        final f = find.widgetWithText(TextFormField, label);
        await t.ensureVisible(f);
        await t.pumpAndSettle();
        await t.enterText(f, value);
      }

      await fill('PIN Baru', '012345');
      await fill('Konfirmasi PIN Baru', '012345');
      await t.ensureVisible(find.text('Buat PIN'));
      await t.pumpAndSettle();
      await t.tap(find.text('Buat PIN'));
      await t.pumpAndSettle();
      expect(find.widgetWithText(TextFormField, 'PIN Lama'), findsOneWidget);
      await fill('Password Lama', 'dikasa123');
      await fill('Password Baru', 'newpassword123');
      await fill('Konfirmasi Password Baru', 'newpassword123');
      await t.ensureVisible(find.text('Ubah Password'));
      await t.pumpAndSettle();
      await t.tap(find.text('Ubah Password'));
      await t.pumpAndSettle();
      expect(t.takeException(), isNull);
      await t.runAsync(
        () => a.login(username: 'admin', password: 'newpassword123'),
      );
      expect(a.isLoggedIn, isTrue);
    },
  );
  testWidgets('logout during credential request disposes secrets safely', (
    t,
  ) async {
    dotenv.loadFromString(
      envString: 'API_BASE_URL=http://localhost/dikasa/v1\nUSE_MOCK_API=true',
    );
    final c = ApiClient();
    final a = AuthRepository(authService: AuthService(c), apiClient: c);
    await t.runAsync(() => a.login(username: 'admin', password: 'dikasa123'));
    final service = DeferredCredentialService(c);
    t.view.physicalSize = const Size(1340, 800);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.resetPhysicalSize);
    addTearDown(t.view.resetDevicePixelRatio);
    await t.pumpWidget(
      MaterialApp(
        home: AccountSettingsView(
          viewModel: AccountSettingsViewModel(service, a),
        ),
      ),
    );
    await t.pumpAndSettle();
    for (final label in ['PIN Baru', 'Konfirmasi PIN Baru']) {
      final f = find.widgetWithText(TextFormField, label);
      await t.ensureVisible(f);
      await t.pumpAndSettle();
      await t.enterText(f, '123456');
    }
    await t.ensureVisible(find.text('Buat PIN'));
    await t.pumpAndSettle();
    await t.tap(find.text('Buat PIN'));
    await t.pump();
    a.logout();
    await t.pump();
    service.pending.complete();
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);
  });
}
