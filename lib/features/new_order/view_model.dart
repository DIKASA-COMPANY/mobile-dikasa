import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/cash_session.dart';
import 'package:mobile_dikasa/data/models/order_item.dart';
import 'package:mobile_dikasa/data/models/order_type.dart';
import 'package:mobile_dikasa/data/models/product.dart';
import 'package:mobile_dikasa/data/models/user.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/repositories/cash_session_repository.dart';
import 'package:mobile_dikasa/data/repositories/order_type_repository.dart';
import 'package:mobile_dikasa/data/repositories/product_repository.dart';
import 'package:mobx/mobx.dart';

part 'view_model.g.dart';

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
    required OrderTypeRepository orderTypeRepository,
    required CashSessionRepository cashSessionRepository,
  }) : _productRepository = productRepository,
       _authRepository = authRepository,
       _orderTypeRepository = orderTypeRepository,
       _cashSessionRepository = cashSessionRepository;

  final ProductRepository _productRepository;
  final AuthRepository _authRepository;
  final OrderTypeRepository _orderTypeRepository;
  final CashSessionRepository _cashSessionRepository;

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
  OrderType? orderType;

  @observable
  ObservableList<OrderType> orderTypes = ObservableList<OrderType>();

  @observable
  bool isOrderTypesLoading = false;

  @observable
  String? orderTypesErrorMessage;

  /// Kas awal yang dipegang kasir. `null` selama dialog belum diisi.
  @observable
  int? openingCash;

  /// Menjadi true setelah kasir mengisi atau melewati dialog Kas Awal,
  /// sehingga dialog tidak muncul lagi saat halaman di-rebuild.
  @observable
  bool isOpeningCashResolved = false;

  @observable
  bool isCheckingOpeningCash = false;

  @observable
  bool isOpeningCashSubmitting = false;

  @observable
  String? openingCashErrorMessage;

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
    isLoading = true;
    errorMessage = null;

    try {
      final List<Product> result = await _productRepository.getProducts(
        forceRefresh: forceRefresh,
      );
      products = ObservableList<Product>.of(result);
    } on ApiException catch (error) {
      errorMessage = error.message;
    } catch (error) {
      errorMessage = 'Terjadi kesalahan tak terduga. Silakan coba lagi.';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadOrderTypes({bool forceRefresh = false}) async {
    isOrderTypesLoading = true;
    orderTypesErrorMessage = null;
    try {
      final List<OrderType> result = await _orderTypeRepository.getOrderTypes(
        forceRefresh: forceRefresh,
      );
      orderTypes = ObservableList<OrderType>.of(result);
      if (orderType != null && !orderTypes.contains(orderType)) {
        orderType = null;
      }
    } on ApiException catch (error) {
      orderTypesErrorMessage = error.message;
    } catch (_) {
      orderTypesErrorMessage =
          'Jenis order tidak dapat dimuat. Silakan coba lagi.';
    } finally {
      isOrderTypesLoading = false;
    }
  }

  @action
  Future<void> checkOpeningCash() async {
    if (isCheckingOpeningCash || isOpeningCashResolved) {
      return;
    }

    isCheckingOpeningCash = true;
    openingCashErrorMessage = null;
    try {
      final CashSession? session = await _cashSessionRepository.getCurrent();
      if (session != null) {
        openingCash = session.openingCash;
        isOpeningCashResolved = true;
      }
    } on ApiException catch (error) {
      openingCashErrorMessage = error.message;
    } catch (_) {
      openingCashErrorMessage =
          'Status sesi kas tidak dapat diperiksa. Silakan coba lagi.';
    } finally {
      isCheckingOpeningCash = false;
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
  void selectOrderType(OrderType type) => orderType = type;

  /// Menambah produk ke pesanan; bila sudah ada, jumlahnya bertambah satu.
  @action
  void addProduct(Product product) {
    final int index = orderItems.indexWhere(
      (OrderItem item) => item.product.id == product.id,
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
    final int index = orderItems.indexWhere(
      (OrderItem item) => item.product.id == product.id,
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
  void clearOrder() => orderItems.clear();

  @action
  Future<bool> confirmOpeningCash(int? amount) async {
    isOpeningCashSubmitting = true;
    openingCashErrorMessage = null;
    try {
      // "Lewati" berarti membuka sesi dengan modal Rp0; transaksi backend
      // tetap membutuhkan sesi kas aktif.
      final CashSession session = await _cashSessionRepository.open(
        amount ?? 0,
      );
      openingCash = session.openingCash;
      isOpeningCashResolved = true;
      return true;
    } on ApiException catch (error) {
      openingCashErrorMessage = error.message;
      return false;
    } catch (_) {
      openingCashErrorMessage = 'Kas awal gagal disimpan. Silakan coba lagi.';
      return false;
    } finally {
      isOpeningCashSubmitting = false;
    }
  }
}
