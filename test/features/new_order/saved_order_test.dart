import 'dart:async';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/models/user.dart';
import 'package:mobile_dikasa/data/models/product.dart';
import 'package:mobile_dikasa/data/models/pos.dart';
import 'package:mobile_dikasa/data/models/saved_order.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/repositories/product_repository.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/services/product_service.dart';
import 'package:mobile_dikasa/data/services/pos_service.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import '../../data/saved_order_service_test.dart' show draftJson;

class TestAuth extends AuthRepository {
  TestAuth(ApiClient c) : super(authService: AuthService(c), apiClient: c);
  User? account = const User(
    id: 'actor',
    name: 'Cashier',
    username: 'a',
    role: 'cashier',
    outletName: 'Shop',
  );
  @override
  User? get currentUser => account;
}

class TestProducts extends ProductRepository {
  TestProducts(ApiClient c) : super(productService: ProductService(c));
  int loads = 0;
  List<Product> catalog = [tea];
  @override
  Future<List<Product>> getProducts({bool forceRefresh = false}) async {
    loads++;
    return catalog;
  }
}

const tea = Product(
  id: 'product',
  name: 'Tea',
  price: 100,
  imageAsset: '',
  group: ProductGroup.minuman,
  category: 'Drink',
  isHighlighted: false,
);

class TestPos extends PosService {
  TestPos(super.c);
  @override
  Future<PosPage> orders({
    String search = '',
    int page = 1,
    String? status,
    String? orderTypeId,
  }) async => PosPage(items: [], total: 0, page: page);
  Completer<double>? pendingTax;
  int attempts = 0;
  bool uncertain = false;
  Completer<SavedOrder>? pending;
  Completer<SavedOrder>? pendingRead;
  Completer<PaymentReceipt>? pendingPayment;
  Map<String, dynamic> draft = draftJson();
  ApiException? updateError;
  bool paymentTimeout = false;
  Map<String, dynamic>? paidPayload;
  int listCalls = 0;
  @override
  Future<SavedOrderPage> savedOrders({String search = '', int page = 1}) async {
    listCalls++;
    return SavedOrderPage([SavedOrder.fromJson(draft)], 1, page);
  }

  @override
  Future<SavedOrder> updateSavedOrder(String id, Map<String, dynamic> b) async {
    bodies.add(b);
    if (updateError != null) throw updateError!;
    if (uncertain) throw const SavedCommandUncertainException();
    draft = {...draft, ...b, 'revision': (b['expected_revision'] as int) + 1};
    return SavedOrder.fromJson(draft);
  }

  @override
  Future<PaymentReceipt> pay(Map<String, dynamic> b) async {
    paidPayload = b;
    if (paymentTimeout) throw const PaymentUncertainException();
    return pendingPayment?.future ??
        const PaymentReceipt(id: 'receipt', number: 'TRX', total: 100);
  }

  final bodies = <Map<String, dynamic>>[];
  @override
  Future<SavedOrder> createSavedOrder(Map<String, dynamic> b) async {
    attempts++;
    bodies.add(b);
    if (uncertain) throw const SavedCommandUncertainException();
    if (pending != null) return pending!.future;
    return SavedOrder.fromJson(draftJson());
  }

  @override
  Future<SavedOrder> savedOrder(String id) async =>
      pendingRead?.future ?? SavedOrder.fromJson(draft);
  @override
  Future<List<PosOrderType>> orderTypes() async => [
    const PosOrderType(id: 'type', code: 'takeaway', label: 'Takeaway'),
  ];
  @override
  Future<CashSession?> currentCash() async =>
      const CashSession(id: 'cash', openingCash: 0);
  @override
  Future<double> taxPercentage() async => pendingTax?.future ?? 0;
  @override
  Future<List<PosOption>> wallets() async => [];
  @override
  Future<List<PosOption>> tables() async => [];
}

void main() {
  late NewOrderViewModel vm;
  late TestPos pos;
  late TestAuth auth;
  late TestProducts repository;
  setUp(() async {
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    final c = ApiClient();
    auth = TestAuth(c);
    pos = TestPos(c);
    vm = NewOrderViewModel(
      productRepository: repository = TestProducts(c),
      authRepository: auth,
      posService: pos,
    );
    await vm.loadProducts();
    await vm.loadPos();
    vm.selectOrderType(vm.orderTypes.single);
    vm.addProduct(tea);
  });
  test(
    'same account new session invalidates payment and resets pending state',
    () async {
      pos.pendingPayment = Completer<PaymentReceipt>();
      final paying = vm.pay(method: 'cash', paidAmount: 100);
      await Future<void>.delayed(Duration.zero);
      auth.logout();
      pos.pendingPayment!.complete(
        const PaymentReceipt(id: 'old', number: 'OLD', total: 100),
      );
      expect(await paying, isNull);
      await vm.loadPos();
      expect(vm.isPaying, isFalse);
    },
  );
  test('save clears only on confirmed success', () async {
    expect(await vm.saveOrder(label: 'Table A'), true);
    expect(vm.orderItems, isEmpty);
    expect(pos.bodies.single['items'][0]['product_id'], 'product');
  });
  test('confirmed payment retains snapshot after clearing cart', () async {
    final receipt = await vm.pay(method: 'cash', paidAmount: 150);
    expect(vm.orderItems, isEmpty);
    expect(receipt!.snapshot!.items.single.name, 'Tea');
    expect(receipt.snapshot!.total, 100);
    expect(receipt.snapshot!.paid, 150);
    expect(receipt.snapshot!.change, 50);
  });
  test('uncertain save freezes cart and retries exact command', () async {
    pos.uncertain = true;
    expect(await vm.saveOrder(), false);
    vm.addProduct(tea);
    vm.clearOrder();
    expect(vm.totalQuantity, 1);
    pos.uncertain = false;
    expect(await vm.saveOrder(label: 'different ignored during retry'), true);
    expect(pos.bodies[0], pos.bodies[1]);
  });
  test('opening cannot overwrite occupied cart', () async {
    expect(await vm.openSavedOrder('draft'), false);
    expect(vm.totalQuantity, 1);
  });
  test('reopen preserves notes and associates revision', () async {
    vm.clearOrder();
    expect(await vm.openSavedOrder('draft'), true);
    expect(vm.orderItems.single.note, 'less ice');
    expect(vm.savedOrderId, 'draft');
    expect(vm.savedOrderRevision, 1);
  });
  test('late save cannot clear next account cart', () async {
    pos.pending = Completer<SavedOrder>();
    final saving = vm.saveOrder();
    await Future<void>.delayed(Duration.zero);
    auth.account = const User(
      id: 'other',
      name: 'Other',
      username: 'b',
      role: 'cashier',
      outletName: 'Other shop',
    );
    await vm.loadProducts();
    vm.addProduct(tea);
    pos.pending!.complete(SavedOrder.fromJson(draftJson()));
    expect(await saving, false);
    expect(vm.totalQuantity, 1);
    expect(vm.savedOrderId, isNull);
  });
  test(
    'repricing requires approval and uses the exact reviewed snapshot',
    () async {
      vm.clearOrder();
      repository.catalog = [
        const Product(
          id: 'product',
          name: 'Tea',
          price: 120,
          imageAsset: '',
          group: ProductGroup.minuman,
          category: 'Drink',
          isHighlighted: false,
        ),
      ];
      expect(await vm.openSavedOrder('draft'), false);
      expect(vm.orderItems, isEmpty);
      expect(vm.reopenWarnings, isNotEmpty);
      repository.catalog = [tea];
      expect(await vm.openSavedOrder('draft', acceptChanges: true), true);
      expect(vm.orderItems.single.product.price, 120);
    },
  );
  test('base and variation lines plus notes survive reopening', () async {
    vm.clearOrder();
    repository.catalog = [
      const Product(
        id: 'product',
        name: 'Tea',
        price: 100,
        imageAsset: '',
        group: ProductGroup.minuman,
        category: 'Drink',
        isHighlighted: false,
        variations: [ProductVariation(id: 'large', name: 'Large', price: 150)],
      ),
    ];
    pos.draft['items'].add({
      'product_id': 'product',
      'product_name': 'Tea',
      'unit_price': 150,
      'quantity': 2,
      'notes': 'warm',
      'product_variant_id': 'large',
      'variant_name': 'Large',
    });
    expect(await vm.openSavedOrder('draft'), true);
    expect(vm.orderItems.length, 2);
    expect(vm.orderItems.last.product.variantId, 'large');
    expect(vm.orderItems.last.note, 'warm');
  });
  test(
    'removed variation review cancellation leaves the persisted draft intact',
    () async {
      vm.clearOrder();
      pos.draft['items'][0]['product_variant_id'] = 'removed';
      expect(await vm.openSavedOrder('draft'), false);
      expect(vm.reopenWarnings, isNotEmpty);
      vm.cancelSavedReview();
      expect(pos.draft['items'].length, 1);
      expect(vm.orderItems, isEmpty);
      expect(vm.savedOrderId, isNull);
    },
  );
  test('stale update retains the reopened cart', () async {
    vm.clearOrder();
    await vm.openSavedOrder('draft');
    pos.updateError = const SavedOrderApiException(
      type: ApiErrorType.server,
      message: 'Changed',
      code: 'PESANAN_TERSIMPAN_BERUBAH',
    );
    expect(await vm.saveOrder(), false);
    expect(vm.totalQuantity, 1);
    expect(vm.savedOrderId, 'draft');
    expect(vm.savedCommandUncertain, false);
  });
  test('saved checkout sends the confirmed updated revision', () async {
    vm.clearOrder();
    await vm.openSavedOrder('draft');
    final receipt = await vm.pay(method: 'cash', paidAmount: 100);
    expect(receipt, isNotNull);
    expect(pos.paidPayload!['saved_order_id'], 'draft');
    expect(pos.paidPayload!['saved_order_revision'], 2);
    expect(vm.savedOrderId, isNull);
  });
  test('uncertain draft payment resolves from server status', () async {
    vm.clearOrder();
    await vm.openSavedOrder('draft');
    pos.paymentTimeout = true;
    await vm.pay(method: 'cash', paidAmount: 100);
    expect(vm.paymentUncertain, true);
    pos.draft = {...pos.draft, 'status': 'paid', 'transaction_id': 'receipt'};
    final loadsBefore = repository.loads;
    expect(await vm.reconcileSavedPayment(), true);
    expect(repository.loads, greaterThan(loadsBefore));
    expect(vm.orderItems, isEmpty);
    expect(vm.paymentUncertain, false);
    expect(vm.checkoutError, contains('receipt'));
  });
  test('late reopen cannot attach a different account draft', () async {
    vm.clearOrder();
    pos.pendingRead = Completer<SavedOrder>();
    final opening = vm.openSavedOrder('draft');
    await Future<void>.delayed(Duration.zero);
    auth.account = null;
    await vm.loadProducts();
    pos.pendingRead!.complete(SavedOrder.fromJson(draftJson()));
    expect(await opening, false);
    expect(vm.savedOrderId, isNull);
  });
  test(
    'late payment cannot clear the next account cart or return its receipt',
    () async {
      pos.pendingPayment = Completer<PaymentReceipt>();
      final paying = vm.pay(method: 'cash', paidAmount: 100);
      await Future<void>.delayed(Duration.zero);
      auth.account = null;
      await vm.loadProducts();
      vm.addProduct(tea);
      pos.pendingPayment!.complete(
        const PaymentReceipt(id: 'old', number: 'OLD', total: 100),
      );
      expect(await paying, isNull);
      expect(vm.totalQuantity, 1);
    },
  );

  test(
    'already-paid response while saving before checkout enables recovery',
    () async {
      vm.clearOrder();
      await vm.openSavedOrder('draft');
      pos.updateError = const SavedOrderApiException(
        type: ApiErrorType.server,
        message: 'Already paid',
        code: 'PESANAN_SUDAH_DIBAYAR',
      );
      expect(await vm.pay(method: 'cash', paidAmount: 100), isNull);
      expect(vm.paymentUncertain, true);
      expect(vm.orderItems, isNotEmpty);
    },
  );
  test('late checkout reference data cannot cross accounts', () async {
    pos.pendingTax = Completer<double>();
    final preparing = vm.preparePayment();
    await Future<void>.delayed(Duration.zero);
    auth.account = null;
    await vm.loadProducts();
    pos.pendingTax!.complete(10);
    expect(await preparing, false);
    expect(vm.taxPercentage, 0);
    expect(vm.cashSession, isNull);
  });
  test(
    'refund lock preserves cart and only its owner can release it',
    () async {
      final owner = Object();
      final quantity = vm.totalQuantity;
      final items = List.of(vm.orderItems);
      expect(vm.beginRefund(owner), true);
      vm.clearOrder();
      vm.addProduct(tea);
      expect(await vm.pay(method: 'cash', paidAmount: 100), isNull);
      expect(await vm.saveOrder(), false);
      vm.endRefund(Object());
      expect(vm.refundActive, true);
      expect(vm.totalQuantity, quantity);
      expect(vm.orderItems, items);
      vm.endRefund(owner);
      expect(vm.refundActive, false);
      expect(vm.totalQuantity, quantity);
    },
  );

  test('closing owns its lock and preserves the active cart', () async {
    final owner = Object();
    final items = List.of(vm.orderItems);
    final qty = vm.totalQuantity;
    expect(vm.beginCashClosing(owner), true);
    expect(vm.beginRefund(Object()), false);
    vm.clearOrder();
    vm.addProduct(tea);
    expect(await vm.pay(method: 'cash', paidAmount: 100), isNull);
    expect(await vm.saveOrder(), false);
    vm.endCashClosing(Object());
    expect(vm.cashClosingActive, true);
    expect(vm.orderItems, items);
    expect(vm.totalQuantity, qty);
    vm.endCashClosing(owner);
    expect(vm.cashClosingActive, false);
    expect(vm.orderItems, items);
  });
}
