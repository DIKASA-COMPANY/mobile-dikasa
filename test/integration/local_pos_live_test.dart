import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/repositories/product_repository.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/services/product_service.dart';
import 'package:mobile_dikasa/data/services/pos_service.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';

/// Opt-in: writes one explicitly marked transaction to the local development DB.
void main() {
  const baseUrl = String.fromEnvironment('DIKASA_LIVE_API_URL');
  test(
    'local API persists a paid transaction and returns it in history',
    () async {
      final uri = Uri.parse(baseUrl);
      expect(['localhost', '127.0.0.1', '::1'], contains(uri.host));
      dotenv.loadFromString(
        envString: 'API_BASE_URL=$baseUrl\nUSE_MOCK_API=false',
      );
      final client = ApiClient();
      final auth = AuthRepository(
        authService: AuthService(client),
        apiClient: client,
      );
      await auth.login(
        username: const String.fromEnvironment(
          'DIKASA_LIVE_USERNAME',
          defaultValue: 'admin',
        ),
        password: const String.fromEnvironment(
          'DIKASA_LIVE_PASSWORD',
          defaultValue: 'dikasa123',
        ),
      );
      final pos = PosService(client);
      final vm = NewOrderViewModel(
        productRepository: ProductRepository(
          productService: ProductService(client),
        ),
        authRepository: auth,
        posService: pos,
      );
      await vm.loadPos();
      expect(vm.checkoutError, isNull);
      if (vm.cashSession == null) expect(await vm.openCash(100000), isTrue);
      await vm.loadProducts(forceRefresh: true);
      expect(vm.products, isNotEmpty);
      vm.selectOrderType(
        vm.orderTypes.firstWhere((type) => type.code == 'takeaway'),
      );
      vm.addProduct(vm.products.first);
      vm.orderItems[0] = vm.orderItems[0].copyWith(
        note: 'POS integration verification - local development',
      );
      expect(await vm.preparePayment(), isTrue);
      final expectedTotal = vm.paymentTotal;
      final receipt = await vm.pay(method: 'cash', paidAmount: expectedTotal);
      expect(vm.checkoutError, isNull);
      expect(receipt, isNotNull);
      expect(receipt!.total, expectedTotal);
      expect(vm.orderItems, isEmpty);
      final history = await pos.orders(search: receipt.number);
      expect(history.items.single['id'], receipt.id);
      expect(history.items.single['total_amount'], expectedTotal);
      expect(history.items.single['status'], 'paid');
      final customers = await pos.customers();
      expect(customers.total, greaterThanOrEqualTo(0));
      // Receipt is safe to display; credentials and tokens are never printed.
      // ignore: avoid_print
      print(
        'Verified local receipt ${receipt.number}; total $expectedTotal Rupiah',
      );
      client.dio.close();
    },
    skip: baseUrl.isEmpty
        ? 'Opt in with --dart-define=DIKASA_LIVE_API_URL=http://127.0.0.1:8081/dikasa/v1'
        : false,
  );
}
