import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/services/account_service.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/repositories/product_repository.dart';
import 'package:mobile_dikasa/data/services/product_service.dart';
import 'package:mobile_dikasa/data/services/pos_service.dart';
import 'package:mobile_dikasa/data/models/account_profile.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/features/account/view_model.dart';

class DelayedAccount extends AccountService {
  DelayedAccount(super.c);
  final pending = Completer<AccountProfile>();
  @override
  Future<AccountProfile> profile() => pending.future;
  @override
  Future<List<GenderOption>> genders() async => [];
}

void main() {
  setUp(
    () => dotenv.loadFromString(
      envString: 'API_BASE_URL=http://localhost/dikasa/v1\nUSE_MOCK_API=true',
    ),
  );
  test('late profile cannot replace a new login to the same account', () async {
    final c = ApiClient();
    final a = AuthRepository(authService: AuthService(c), apiClient: c);
    await a.login(username: 'admin', password: 'dikasa123');
    final s = DelayedAccount(c);
    final m = AccountSettingsViewModel(s, a);
    final load = m.load();
    a.logout();
    await a.login(username: 'admin', password: 'dikasa123');
    s.pending.complete(
      AccountProfile.fromJson({'id': '1', 'first_name': 'Late'}),
    );
    await load;
    expect(m.profile, isNull);
    expect(a.currentUser!.name, 'Jane Doe');
    expect(m.active, isFalse);
    m.dispose();
  });
  test(
    'profile save preserves cart variations, till and saved order identity',
    () async {
      final c = ApiClient();
      final a = AuthRepository(authService: AuthService(c), apiClient: c);
      await a.login(username: 'admin', password: 'dikasa123');
      final v = NewOrderViewModel(
        productRepository: ProductRepository(productService: ProductService(c)),
        authRepository: a,
        posService: PosService(c),
      );
      await v.loadProducts();
      v.addProduct(v.products.first);
      final before = v.orderItems.first;
      v.savedOrderId = 'draft';
      v.savedOrderRevision = 2;
      v.openingCash = 100000;
      final m = AccountSettingsViewModel(AccountService(c), a);
      await m.load();
      expect(await m.save({'first_name': 'Janet'}), isTrue);
      expect(v.currentUser!.name, contains('Janet'));
      expect(v.orderItems.first, same(before));
      expect(v.savedOrderId, 'draft');
      expect(v.savedOrderRevision, 2);
      expect(v.openingCash, 100000);
      m.dispose();
    },
  );
}
