import '../cash_movement/controller.dart';
import 'dart:convert';
import 'dart:math';
import 'package:mobile_dikasa/data/models/payment_snapshot.dart';
import 'package:mobile_dikasa/data/models/saved_order.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/order_item.dart';
import 'package:mobile_dikasa/data/models/product.dart';
import 'package:mobile_dikasa/data/models/user.dart';
import 'package:mobile_dikasa/data/models/pos.dart';
import 'package:mobile_dikasa/data/services/pos_service.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/repositories/product_repository.dart';
import 'package:mobx/mobx.dart';

part 'view_model.g.dart';
part 'saved_order_actions.dart';

class NewOrderViewModel = NewOrderViewModelBase with _$NewOrderViewModel;

/// Nilai yang dipakai dropdown kategori untuk mewakili "semua kategori".
///
/// Ditulis sebagai konstanta lepas, bukan anggota statis store, karena
/// anggota statis tidak ikut terbawa ke class hasil mixin MobX.
const String allCategoriesFilter = 'Filter Kategori';

/// State dan logika halaman Order (transaksi kasir).
abstract class NewOrderViewModelBase with Store {
  NewOrderViewModelBase({
    required ProductRepository productRepository,
    required AuthRepository authRepository,
    required this.posService,
  }) : _productRepository = productRepository,
       _authRepository = authRepository,
       _loadedSessionGeneration = authRepository.sessionGeneration;

  final ProductRepository _productRepository;
  final AuthRepository _authRepository;
  final PosService posService;
  final Observable<bool> _cashMovementGate = Observable(false);
  bool get cashMovementActive => _cashMovementGate.value;
  Object? _cashMovementOwner;
  CashMovementController? _movementController;
  AuthRepository get authRepository => _authRepository;
  CashMovementController get cashMovements {
    if (_movementController == null || !_movementController!.current) {
      _movementController?.dispose();
      _movementController = CashMovementController(
        service: posService.cashMovements,
        auth: _authRepository,
        acquire: beginCashMovement,
        release: endCashMovement,
      );
    }
    return _movementController!;
  }

  bool beginCashMovement(Object owner) {
    _syncUser();
    if (isPaying || paymentUncertain || draftLocked) return false;
    _cashMovementOwner = owner;
    runInAction(() => _cashMovementGate.value = true);
    return true;
  }

  void endCashMovement(Object owner) {
    if (identical(_cashMovementOwner, owner)) {
      _cashMovementOwner = null;
      runInAction(() => _cashMovementGate.value = false);
    }
  }

  @observable
  String? savedOrderId;
  @observable
  int? savedOrderRevision;
  @observable
  String? savedOrderLabel;
  @observable
  bool isSavingOrder = false;
  @observable
  bool savedCommandUncertain = false;
  @observable
  ObservableList<String> reopenWarnings = ObservableList<String>();
  int _draftGeneration = 0;
  _DraftCommand? _pendingDraft;
  SavedOrder? _reviewOrder;
  List<OrderItem>? _reviewItems;
  PosOrderType? _reviewType;
  @observable
  bool refundActive = false;
  Object? _refundOwner;
  bool beginRefund(Object owner) {
    _syncUser();
    if (refundActive || isPaying || paymentUncertain || draftLocked) {
      return false;
    }
    _refundOwner = owner;
    runInAction(() => refundActive = true);
    return true;
  }

  void endRefund(Object owner) {
    if (identical(owner, _refundOwner)) {
      _refundOwner = null;
      runInAction(() => refundActive = false);
    }
  }

  @observable
  bool cashClosingActive = false;
  Object? _cashClosingOwner;
  bool beginCashClosing(Object owner) {
    _syncUser();
    if (isPaying || paymentUncertain || draftLocked) return false;
    _cashClosingOwner = owner;
    runInAction(() => cashClosingActive = true);
    return true;
  }

  void endCashClosing(Object owner) {
    if (identical(owner, _cashClosingOwner)) {
      _cashClosingOwner = null;
      runInAction(() => cashClosingActive = false);
    }
  }

  Future<void> refreshCashAfterClose() async {
    final account = currentUser?.id;
    final active = await posService.currentCash();
    if (currentUser?.id != account) return;
    runInAction(() {
      cashSession = active;
      openingCash = active?.openingCash;
      isOpeningCashResolved = true;
    });
  }

  String? _loadedUserId;
  int _loadedSessionGeneration;
  int _productRequest = 0;
  int _posRequest = 0;

  // Invalidate old requests and cached data before a different account can use this store.
  void _syncUser() {
    final userId = currentUser?.id;
    if (_loadedUserId == userId && _loadedSessionGeneration == _authRepository.sessionGeneration) return;
    _loadedUserId = userId;
    _loadedSessionGeneration = _authRepository.sessionGeneration;
    _draftGeneration++;
    refundActive = false;
    _refundOwner = null;
    cashClosingActive = false;
    _cashClosingOwner = null;
    _pendingDraft = null;
    isSavingOrder = false;
    savedCommandUncertain = false;
    isPaying = false;
    _clearDraft();
    _productRequest++;
    _posRequest++;
    _productRepository.clear();
    products.clear();
    orderItems.clear();
    orderType = null;
    orderTypes.clear();
    cashSession = null;
    openingCash = null;
    isOpeningCashResolved = false;
    taxPercentage = 0;
    wallets.clear();
    tables.clear();
    paymentUncertain = false;
    isLoading = false;
    isLoadingPos = false;
    errorMessage = null;
    checkoutError = null;
  }

  // =========================
  // Katalog
  // =========================

  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  ProductGroup selectedGroup = ProductGroup.makanan;

  @observable
  String selectedCategory = allCategoriesFilter;

  @observable
  String searchQuery = '';

  // =========================
  // Pesanan berjalan
  // =========================

  @observable
  ObservableList<OrderItem> orderItems = ObservableList<OrderItem>();

  @observable
  PosOrderType? orderType;

  @observable
  ObservableList<PosOrderType> orderTypes = ObservableList<PosOrderType>();

  @observable
  CashSession? cashSession;

  @observable
  bool isLoadingPos = false;

  @observable
  bool isPaying = false;

  @observable
  bool paymentUncertain = false;

  @observable
  String? checkoutError;

  @observable
  double taxPercentage = 0;

  @observable
  ObservableList<PosOption> wallets = ObservableList<PosOption>();

  @observable
  ObservableList<PosOption> tables = ObservableList<PosOption>();

  /// Kas awal yang dipegang kasir. `null` selama dialog belum diisi.
  @observable
  int? openingCash;

  /// Menjadi true setelah kasir mengisi atau melewati dialog Kas Awal,
  /// sehingga dialog tidak muncul lagi saat halaman di-rebuild.
  @observable
  bool isOpeningCashResolved = false;

  User? get currentUser => _authRepository.currentUser;

  /// Produk pada tab yang sedang aktif.
  @computed
  List<Product> get _productsInGroup => products
      .where((Product product) => product.group == selectedGroup)
      .toList();

  /// Isi dropdown "Filter Kategori", mengikuti tab yang sedang aktif.
  @computed
  List<String> get categories => <String>[
    allCategoriesFilter,
    ..._productsInGroup
        .map((Product product) => product.category)
        .toSet()
        .toList()
      ..sort(),
  ];

  /// Produk yang lolos filter tab, kategori, dan pencarian.
  @computed
  List<Product> get visibleProducts {
    final String query = searchQuery.trim().toLowerCase();

    return _productsInGroup.where((Product product) {
      final bool matchesCategory =
          selectedCategory == allCategoriesFilter ||
          product.category == selectedCategory;
      final bool matchesQuery =
          query.isEmpty || product.name.toLowerCase().contains(query);

      return matchesCategory && matchesQuery;
    }).toList();
  }

  @computed
  bool get hasOrderItems => orderItems.isNotEmpty;

  @computed
  int get totalQuantity => orderItems.fold<int>(
    0,
    (int total, OrderItem item) => total + item.quantity,
  );

  @computed
  int get totalPrice => orderItems.fold<int>(
    0,
    (int total, OrderItem item) => total + item.subtotal,
  );

  // =========================
  // Aksi
  // =========================

  @action
  Future<void> loadProducts({bool forceRefresh = false}) async {
    _syncUser();
    final userId = currentUser?.id;
    final request = ++_productRequest;
    isLoading = true;
    errorMessage = null;

    try {
      final List<Product> result = await _productRepository.getProducts(
        forceRefresh: forceRefresh,
      );
      if (request != _productRequest || currentUser?.id != userId) return;
      products = ObservableList<Product>.of(result);
    } on ApiException catch (error) {
      if (request == _productRequest && currentUser?.id == userId) {
        errorMessage = error.message;
      }
    } catch (error) {
      if (request == _productRequest && currentUser?.id == userId) {
        errorMessage = 'Terjadi kesalahan tak terduga. Silakan coba lagi.';
      }
    } finally {
      if (request == _productRequest) isLoading = false;
    }
  }

  @action
  void selectGroup(ProductGroup group) {
    if (selectedGroup == group) {
      return;
    }
    selectedGroup = group;
    // Kategori pada tab lama belum tentu ada di tab baru.
    selectedCategory = allCategoriesFilter;
  }

  @action
  void selectCategory(String category) => selectedCategory = category;

  @action
  void onSearchChanged(String value) => searchQuery = value;

  @action
  void selectOrderType(PosOrderType type) {
    if (!isPaying && !paymentUncertain && !draftLocked) orderType = type;
  }

  bool canAddProduct(Product product) =>
      !isPaying &&
      !paymentUncertain &&
      !draftLocked &&
      product.isAvailable &&
      (!product.trackStock ||
          orderItems
                  .where((i) => i.product.id == product.id)
                  .fold<int>(0, (sum, i) => sum + i.quantity) <
              product.stockQuantity);
  void updateItemNote(Product product, String note) {
    if (isPaying || paymentUncertain || draftLocked) return;
    runInAction(() {
      final index = orderItems.indexWhere(
        (i) => i.product.cartKey == product.cartKey,
      );
      if (index >= 0) {
        orderItems[index] = orderItems[index].copyWith(note: note);
      }
    });
  }

  /// Menambah produk ke pesanan; bila sudah ada, jumlahnya bertambah satu.
  @action
  void addProduct(Product product) {
    if (!canAddProduct(product)) return;
    final int index = orderItems.indexWhere(
      (OrderItem item) => item.product.cartKey == product.cartKey,
    );

    if (index == -1) {
      orderItems.add(OrderItem(product: product, quantity: 1));
      return;
    }

    orderItems[index] = orderItems[index].copyWith(
      quantity: orderItems[index].quantity + 1,
    );
  }

  /// Mengurangi satu jumlah; baris terhapus saat jumlahnya habis.
  @action
  void decreaseProduct(Product product) {
    if (isPaying || paymentUncertain || draftLocked) return;
    final int index = orderItems.indexWhere(
      (OrderItem item) => item.product.cartKey == product.cartKey,
    );
    if (index == -1) {
      return;
    }

    final OrderItem item = orderItems[index];
    if (item.quantity <= 1) {
      orderItems.removeAt(index);
      return;
    }

    orderItems[index] = item.copyWith(quantity: item.quantity - 1);
  }

  @action
  void clearOrder() {
    if (!isPaying && !paymentUncertain && !draftLocked) {
      orderItems.clear();
      orderType = null;
      _clearDraft();
    }
  }

  @action
  void confirmOpeningCash(int? amount) {
    openingCash = amount;
    isOpeningCashResolved = true;
  }

  @computed
  int get taxAmount => (totalPrice * taxPercentage / 100).round();

  @computed
  int get paymentTotal => totalPrice + taxAmount;

  @action
  Future<void> loadPos() async {
    _syncUser();
    if (isLoadingPos) return;
    final userId = currentUser?.id;
    final request = ++_posRequest;
    isLoadingPos = true;
    checkoutError = null;
    try {
      final result = await Future.wait<dynamic>([
        posService.orderTypes(),
        posService.currentCash(),
      ]);
      if (request != _posRequest || currentUser?.id != userId) return;
      orderTypes = ObservableList<PosOrderType>.of(
        result[0] as List<PosOrderType>,
      );
      cashSession = result[1] as CashSession?;
      if (orderType != null) {
        final matching = orderTypes.where((item) => item.id == orderType!.id);
        orderType = matching.isEmpty ? null : matching.first;
      }
      if (cashSession != null) {
        openingCash = cashSession!.openingCash;
        isOpeningCashResolved = true;
      }
    } on ApiException catch (error) {
      if (request == _posRequest && currentUser?.id == userId) {
        checkoutError = error.message;
      }
    } finally {
      if (request == _posRequest) isLoadingPos = false;
    }
  }

  @action
  Future<bool> openCash(int amount) async {
    if (cashClosingActive) return false;
    if (isLoadingPos) return false;
    isLoadingPos = true;
    checkoutError = null;
    try {
      cashSession = await posService.openCash(amount);
      confirmOpeningCash(cashSession!.openingCash);
      return true;
    } on ApiException catch (error) {
      checkoutError = error.message;
      return false;
    } finally {
      isLoadingPos = false;
    }
  }

  @action
  Future<bool> preparePayment() async {
    _syncUser();
    final preparingUser = currentUser?.id;
    final preparingGeneration = _draftGeneration;
    bool current() =>
        currentUser?.id == preparingUser &&
        preparingGeneration == _draftGeneration;
    checkoutError = null;
    try {
      final options = await Future.wait<dynamic>([
        posService.taxPercentage(),
        posService.wallets(),
        posService.tables(),
        posService.currentCash(),
      ]);
      if (!current()) return false;
      taxPercentage = options[0] as double;
      wallets = ObservableList<PosOption>.of(options[1] as List<PosOption>);
      tables = ObservableList<PosOption>.of(options[2] as List<PosOption>);
      cashSession = options[3] as CashSession?;
      if (cashSession == null) {
        checkoutError = 'Buka sesi kas sebelum menerima pembayaran.';
        return false;
      }
      return true;
    } on ApiException catch (error) {
      if (current()) checkoutError = error.message;
      return false;
    }
  }

  @action
  Future<PaymentReceipt?> pay({
    required String method,
    required int paidAmount,
    String? walletId,
    String? tableId,
  }) async {
    _syncUser();
    if (isPaying || paymentUncertain || draftLocked) return null;
    if (savedOrderId != null && !await saveOrder(clearOnSuccess: false)) {
      return null;
    }
    final payingUser = currentUser?.id;
    final payingGeneration = _draftGeneration;
    final sessionGeneration = _authRepository.sessionGeneration;
    bool currentPayment() =>
        currentUser?.id == payingUser &&
        payingGeneration == _draftGeneration &&
        sessionGeneration == _authRepository.sessionGeneration;
    checkoutError = null;
    if (cashSession == null) {
      checkoutError = 'Buka sesi kas terlebih dahulu.';
      return null;
    }
    if (orderType == null ||
        !orderTypes.any((item) => item.id == orderType!.id)) {
      checkoutError = 'Pilih jenis order dari outlet.';
      return null;
    }
    if (orderItems.isEmpty) {
      checkoutError = 'Tambahkan produk terlebih dahulu.';
      return null;
    }
    if (orderItems.length > 100 ||
        orderItems.any((item) => item.quantity > 1000) ||
        paymentTotal > 9007199254740991 ||
        paidAmount > 9007199254740991 ||
        paidAmount < paymentTotal) {
      checkoutError =
          'Nominal pembayaran kurang atau melebihi batas yang didukung.';
      return null;
    }
    if (method == 'wallet' && !wallets.any((item) => item.id == walletId)) {
      checkoutError = 'Pilih dompet pembayaran yang aktif.';
      return null;
    }
    if ((orderType!.code == 'table_order' || orderType!.code == 'dine_in') &&
        !tables.any((item) => item.id == tableId)) {
      checkoutError = 'Pilih meja untuk jenis order ini.';
      return null;
    }
    isPaying = true;
    final payload = <String, dynamic>{
      if (savedOrderId != null) 'saved_order_id': savedOrderId,
      if (savedOrderId != null) 'saved_order_revision': savedOrderRevision,
      'order_type_id': orderType!.id,
      'payment_method': method,
      if (method == 'wallet') 'wallet_id': walletId,
      'restaurant_table_id': ?tableId,
      'subtotal': totalPrice,
      'discount_amount': 0,
      'tax_percentage': taxPercentage,
      'tax_amount': taxAmount,
      'total_amount': paymentTotal,
      'paid_amount': paidAmount,
      'change_amount': paidAmount - paymentTotal,
      'rounding_amount': 0,
      'tip_amount': 0,
      'items': orderItems
          .map(
            (item) => {
              'product_id': item.product.id,
              'product_name': item.product.name,
              if (item.product.variantId != null)
                'product_variant_id': item.product.variantId,
              if (item.product.variantName != null)
                'variant_name': item.product.variantName,
              'unit_price': item.product.price,
              'quantity': item.quantity,
              'notes': item.note,
              'line_total': item.subtotal,
            },
          )
          .toList(),
    };
    final snapshot = PaymentSnapshot.fromPayload(
      payload,
      orderTypeLabel: orderType!.label,
    );
    try {
      final receipt = await posService.pay(payload);
      if (!currentPayment()) return null;
      orderItems.clear();
      orderType = null;
      _clearDraft();
      return receipt.withSnapshot(snapshot);
    } on PaymentUncertainException {
      if (!currentPayment()) return null;
      paymentUncertain = true;
      checkoutError =
          'Status pembayaran belum pasti. Periksa Daftar Order sebelum membuat transaksi baru. Jangan bayar ulang.';
      return null;
    } on ApiException catch (error) {
      if (!currentPayment()) return null;
      if (error is SavedOrderApiException &&
          error.code == 'PESANAN_SUDAH_DIBAYAR') {
        paymentUncertain = true;
      }
      checkoutError = error.message;
      return null;
    } finally {
      if (currentPayment()) isPaying = false;
    }
  }

  /// Cashier explicitly reconciles an uncertain response against order history.
  @action
  void resolveUncertainPayment({required bool wasSaved}) {
    if (!paymentUncertain || isPaying || savedOrderId != null) return;
    if (wasSaved) {
      orderItems.clear();
      orderType = null;
    }
    paymentUncertain = false;
    checkoutError = null;
  }
}
