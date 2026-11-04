// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewOrderViewModel on NewOrderViewModelBase, Store {
  Computed<List<Product>>? _$_productsInGroupComputed;

  @override
  List<Product> get _productsInGroup =>
      (_$_productsInGroupComputed ??= Computed<List<Product>>(
        () => super._productsInGroup,
        name: 'NewOrderViewModelBase._productsInGroup',
      )).value;
  Computed<List<String>>? _$categoriesComputed;

  @override
  List<String> get categories =>
      (_$categoriesComputed ??= Computed<List<String>>(
        () => super.categories,
        name: 'NewOrderViewModelBase.categories',
      )).value;
  Computed<List<Product>>? _$visibleProductsComputed;

  @override
  List<Product> get visibleProducts =>
      (_$visibleProductsComputed ??= Computed<List<Product>>(
        () => super.visibleProducts,
        name: 'NewOrderViewModelBase.visibleProducts',
      )).value;
  Computed<bool>? _$hasOrderItemsComputed;

  @override
  bool get hasOrderItems => (_$hasOrderItemsComputed ??= Computed<bool>(
    () => super.hasOrderItems,
    name: 'NewOrderViewModelBase.hasOrderItems',
  )).value;
  Computed<int>? _$totalQuantityComputed;

  @override
  int get totalQuantity => (_$totalQuantityComputed ??= Computed<int>(
    () => super.totalQuantity,
    name: 'NewOrderViewModelBase.totalQuantity',
  )).value;
  Computed<int>? _$totalPriceComputed;

  @override
  int get totalPrice => (_$totalPriceComputed ??= Computed<int>(
    () => super.totalPrice,
    name: 'NewOrderViewModelBase.totalPrice',
  )).value;
  Computed<int>? _$taxAmountComputed;

  @override
  int get taxAmount => (_$taxAmountComputed ??= Computed<int>(
    () => super.taxAmount,
    name: 'NewOrderViewModelBase.taxAmount',
  )).value;
  Computed<int>? _$paymentTotalComputed;

  @override
  int get paymentTotal => (_$paymentTotalComputed ??= Computed<int>(
    () => super.paymentTotal,
    name: 'NewOrderViewModelBase.paymentTotal',
  )).value;

  late final _$savedOrderIdAtom = Atom(
    name: 'NewOrderViewModelBase.savedOrderId',
    context: context,
  );

  @override
  String? get savedOrderId {
    _$savedOrderIdAtom.reportRead();
    return super.savedOrderId;
  }

  @override
  set savedOrderId(String? value) {
    _$savedOrderIdAtom.reportWrite(value, super.savedOrderId, () {
      super.savedOrderId = value;
    });
  }

  late final _$savedOrderRevisionAtom = Atom(
    name: 'NewOrderViewModelBase.savedOrderRevision',
    context: context,
  );

  @override
  int? get savedOrderRevision {
    _$savedOrderRevisionAtom.reportRead();
    return super.savedOrderRevision;
  }

  @override
  set savedOrderRevision(int? value) {
    _$savedOrderRevisionAtom.reportWrite(value, super.savedOrderRevision, () {
      super.savedOrderRevision = value;
    });
  }

  late final _$savedOrderLabelAtom = Atom(
    name: 'NewOrderViewModelBase.savedOrderLabel',
    context: context,
  );

  @override
  String? get savedOrderLabel {
    _$savedOrderLabelAtom.reportRead();
    return super.savedOrderLabel;
  }

  @override
  set savedOrderLabel(String? value) {
    _$savedOrderLabelAtom.reportWrite(value, super.savedOrderLabel, () {
      super.savedOrderLabel = value;
    });
  }

  late final _$isSavingOrderAtom = Atom(
    name: 'NewOrderViewModelBase.isSavingOrder',
    context: context,
  );

  @override
  bool get isSavingOrder {
    _$isSavingOrderAtom.reportRead();
    return super.isSavingOrder;
  }

  @override
  set isSavingOrder(bool value) {
    _$isSavingOrderAtom.reportWrite(value, super.isSavingOrder, () {
      super.isSavingOrder = value;
    });
  }

  late final _$savedCommandUncertainAtom = Atom(
    name: 'NewOrderViewModelBase.savedCommandUncertain',
    context: context,
  );

  @override
  bool get savedCommandUncertain {
    _$savedCommandUncertainAtom.reportRead();
    return super.savedCommandUncertain;
  }

  @override
  set savedCommandUncertain(bool value) {
    _$savedCommandUncertainAtom.reportWrite(
      value,
      super.savedCommandUncertain,
      () {
        super.savedCommandUncertain = value;
      },
    );
  }

  late final _$reopenWarningsAtom = Atom(
    name: 'NewOrderViewModelBase.reopenWarnings',
    context: context,
  );

  @override
  ObservableList<String> get reopenWarnings {
    _$reopenWarningsAtom.reportRead();
    return super.reopenWarnings;
  }

  @override
  set reopenWarnings(ObservableList<String> value) {
    _$reopenWarningsAtom.reportWrite(value, super.reopenWarnings, () {
      super.reopenWarnings = value;
    });
  }

  late final _$refundActiveAtom = Atom(
    name: 'NewOrderViewModelBase.refundActive',
    context: context,
  );

  @override
  bool get refundActive {
    _$refundActiveAtom.reportRead();
    return super.refundActive;
  }

  @override
  set refundActive(bool value) {
    _$refundActiveAtom.reportWrite(value, super.refundActive, () {
      super.refundActive = value;
    });
  }

  late final _$cashClosingActiveAtom = Atom(
    name: 'NewOrderViewModelBase.cashClosingActive',
    context: context,
  );

  @override
  bool get cashClosingActive {
    _$cashClosingActiveAtom.reportRead();
    return super.cashClosingActive;
  }

  @override
  set cashClosingActive(bool value) {
    _$cashClosingActiveAtom.reportWrite(value, super.cashClosingActive, () {
      super.cashClosingActive = value;
    });
  }

  late final _$productsAtom = Atom(
    name: 'NewOrderViewModelBase.products',
    context: context,
  );

  @override
  ObservableList<Product> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<Product> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'NewOrderViewModelBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: 'NewOrderViewModelBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$selectedGroupAtom = Atom(
    name: 'NewOrderViewModelBase.selectedGroup',
    context: context,
  );

  @override
  ProductGroup get selectedGroup {
    _$selectedGroupAtom.reportRead();
    return super.selectedGroup;
  }

  @override
  set selectedGroup(ProductGroup value) {
    _$selectedGroupAtom.reportWrite(value, super.selectedGroup, () {
      super.selectedGroup = value;
    });
  }

  late final _$selectedCategoryAtom = Atom(
    name: 'NewOrderViewModelBase.selectedCategory',
    context: context,
  );

  @override
  String get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$searchQueryAtom = Atom(
    name: 'NewOrderViewModelBase.searchQuery',
    context: context,
  );

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$orderItemsAtom = Atom(
    name: 'NewOrderViewModelBase.orderItems',
    context: context,
  );

  @override
  ObservableList<OrderItem> get orderItems {
    _$orderItemsAtom.reportRead();
    return super.orderItems;
  }

  @override
  set orderItems(ObservableList<OrderItem> value) {
    _$orderItemsAtom.reportWrite(value, super.orderItems, () {
      super.orderItems = value;
    });
  }

  late final _$orderTypeAtom = Atom(
    name: 'NewOrderViewModelBase.orderType',
    context: context,
  );

  @override
  PosOrderType? get orderType {
    _$orderTypeAtom.reportRead();
    return super.orderType;
  }

  @override
  set orderType(PosOrderType? value) {
    _$orderTypeAtom.reportWrite(value, super.orderType, () {
      super.orderType = value;
    });
  }

  late final _$orderTypesAtom = Atom(
    name: 'NewOrderViewModelBase.orderTypes',
    context: context,
  );

  @override
  ObservableList<PosOrderType> get orderTypes {
    _$orderTypesAtom.reportRead();
    return super.orderTypes;
  }

  @override
  set orderTypes(ObservableList<PosOrderType> value) {
    _$orderTypesAtom.reportWrite(value, super.orderTypes, () {
      super.orderTypes = value;
    });
  }

  late final _$cashSessionAtom = Atom(
    name: 'NewOrderViewModelBase.cashSession',
    context: context,
  );

  @override
  CashSession? get cashSession {
    _$cashSessionAtom.reportRead();
    return super.cashSession;
  }

  @override
  set cashSession(CashSession? value) {
    _$cashSessionAtom.reportWrite(value, super.cashSession, () {
      super.cashSession = value;
    });
  }

  late final _$isLoadingPosAtom = Atom(
    name: 'NewOrderViewModelBase.isLoadingPos',
    context: context,
  );

  @override
  bool get isLoadingPos {
    _$isLoadingPosAtom.reportRead();
    return super.isLoadingPos;
  }

  @override
  set isLoadingPos(bool value) {
    _$isLoadingPosAtom.reportWrite(value, super.isLoadingPos, () {
      super.isLoadingPos = value;
    });
  }

  late final _$isPayingAtom = Atom(
    name: 'NewOrderViewModelBase.isPaying',
    context: context,
  );

  @override
  bool get isPaying {
    _$isPayingAtom.reportRead();
    return super.isPaying;
  }

  @override
  set isPaying(bool value) {
    _$isPayingAtom.reportWrite(value, super.isPaying, () {
      super.isPaying = value;
    });
  }

  late final _$paymentUncertainAtom = Atom(
    name: 'NewOrderViewModelBase.paymentUncertain',
    context: context,
  );

  @override
  bool get paymentUncertain {
    _$paymentUncertainAtom.reportRead();
    return super.paymentUncertain;
  }

  @override
  set paymentUncertain(bool value) {
    _$paymentUncertainAtom.reportWrite(value, super.paymentUncertain, () {
      super.paymentUncertain = value;
    });
  }

  late final _$checkoutErrorAtom = Atom(
    name: 'NewOrderViewModelBase.checkoutError',
    context: context,
  );

  @override
  String? get checkoutError {
    _$checkoutErrorAtom.reportRead();
    return super.checkoutError;
  }

  @override
  set checkoutError(String? value) {
    _$checkoutErrorAtom.reportWrite(value, super.checkoutError, () {
      super.checkoutError = value;
    });
  }

  late final _$taxPercentageAtom = Atom(
    name: 'NewOrderViewModelBase.taxPercentage',
    context: context,
  );

  @override
  double get taxPercentage {
    _$taxPercentageAtom.reportRead();
    return super.taxPercentage;
  }

  @override
  set taxPercentage(double value) {
    _$taxPercentageAtom.reportWrite(value, super.taxPercentage, () {
      super.taxPercentage = value;
    });
  }

  late final _$walletsAtom = Atom(
    name: 'NewOrderViewModelBase.wallets',
    context: context,
  );

  @override
  ObservableList<PosOption> get wallets {
    _$walletsAtom.reportRead();
    return super.wallets;
  }

  @override
  set wallets(ObservableList<PosOption> value) {
    _$walletsAtom.reportWrite(value, super.wallets, () {
      super.wallets = value;
    });
  }

  late final _$tablesAtom = Atom(
    name: 'NewOrderViewModelBase.tables',
    context: context,
  );

  @override
  ObservableList<PosOption> get tables {
    _$tablesAtom.reportRead();
    return super.tables;
  }

  @override
  set tables(ObservableList<PosOption> value) {
    _$tablesAtom.reportWrite(value, super.tables, () {
      super.tables = value;
    });
  }

  late final _$openingCashAtom = Atom(
    name: 'NewOrderViewModelBase.openingCash',
    context: context,
  );

  @override
  int? get openingCash {
    _$openingCashAtom.reportRead();
    return super.openingCash;
  }

  @override
  set openingCash(int? value) {
    _$openingCashAtom.reportWrite(value, super.openingCash, () {
      super.openingCash = value;
    });
  }

  late final _$isOpeningCashResolvedAtom = Atom(
    name: 'NewOrderViewModelBase.isOpeningCashResolved',
    context: context,
  );

  @override
  bool get isOpeningCashResolved {
    _$isOpeningCashResolvedAtom.reportRead();
    return super.isOpeningCashResolved;
  }

  @override
  set isOpeningCashResolved(bool value) {
    _$isOpeningCashResolvedAtom.reportWrite(
      value,
      super.isOpeningCashResolved,
      () {
        super.isOpeningCashResolved = value;
      },
    );
  }

  late final _$loadProductsAsyncAction = AsyncAction(
    'NewOrderViewModelBase.loadProducts',
    context: context,
  );

  @override
  Future<void> loadProducts({bool forceRefresh = false}) {
    return _$loadProductsAsyncAction.run(
      () => super.loadProducts(forceRefresh: forceRefresh),
    );
  }

  late final _$loadPosAsyncAction = AsyncAction(
    'NewOrderViewModelBase.loadPos',
    context: context,
  );

  @override
  Future<void> loadPos() {
    return _$loadPosAsyncAction.run(() => super.loadPos());
  }

  late final _$openCashAsyncAction = AsyncAction(
    'NewOrderViewModelBase.openCash',
    context: context,
  );

  @override
  Future<bool> openCash(int amount) {
    return _$openCashAsyncAction.run(() => super.openCash(amount));
  }

  late final _$preparePaymentAsyncAction = AsyncAction(
    'NewOrderViewModelBase.preparePayment',
    context: context,
  );

  @override
  Future<bool> preparePayment() {
    return _$preparePaymentAsyncAction.run(() => super.preparePayment());
  }

  late final _$payAsyncAction = AsyncAction(
    'NewOrderViewModelBase.pay',
    context: context,
  );

  @override
  Future<PaymentReceipt?> pay({
    required String method,
    required int paidAmount,
    String? walletId,
    String? tableId,
  }) {
    return _$payAsyncAction.run(
      () => super.pay(
        method: method,
        paidAmount: paidAmount,
        walletId: walletId,
        tableId: tableId,
      ),
    );
  }

  late final _$NewOrderViewModelBaseActionController = ActionController(
    name: 'NewOrderViewModelBase',
    context: context,
  );

  @override
  void selectGroup(ProductGroup group) {
    final _$actionInfo = _$NewOrderViewModelBaseActionController.startAction(
      name: 'NewOrderViewModelBase.selectGroup',
    );
    try {
      return super.selectGroup(group);
    } finally {
      _$NewOrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectCategory(String category) {
    final _$actionInfo = _$NewOrderViewModelBaseActionController.startAction(
      name: 'NewOrderViewModelBase.selectCategory',
    );
    try {
      return super.selectCategory(category);
    } finally {
      _$NewOrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSearchChanged(String value) {
    final _$actionInfo = _$NewOrderViewModelBaseActionController.startAction(
      name: 'NewOrderViewModelBase.onSearchChanged',
    );
    try {
      return super.onSearchChanged(value);
    } finally {
      _$NewOrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectOrderType(PosOrderType type) {
    final _$actionInfo = _$NewOrderViewModelBaseActionController.startAction(
      name: 'NewOrderViewModelBase.selectOrderType',
    );
    try {
      return super.selectOrderType(type);
    } finally {
      _$NewOrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addProduct(Product product) {
    final _$actionInfo = _$NewOrderViewModelBaseActionController.startAction(
      name: 'NewOrderViewModelBase.addProduct',
    );
    try {
      return super.addProduct(product);
    } finally {
      _$NewOrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decreaseProduct(Product product) {
    final _$actionInfo = _$NewOrderViewModelBaseActionController.startAction(
      name: 'NewOrderViewModelBase.decreaseProduct',
    );
    try {
      return super.decreaseProduct(product);
    } finally {
      _$NewOrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearOrder() {
    final _$actionInfo = _$NewOrderViewModelBaseActionController.startAction(
      name: 'NewOrderViewModelBase.clearOrder',
    );
    try {
      return super.clearOrder();
    } finally {
      _$NewOrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void confirmOpeningCash(int? amount) {
    final _$actionInfo = _$NewOrderViewModelBaseActionController.startAction(
      name: 'NewOrderViewModelBase.confirmOpeningCash',
    );
    try {
      return super.confirmOpeningCash(amount);
    } finally {
      _$NewOrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resolveUncertainPayment({required bool wasSaved}) {
    final _$actionInfo = _$NewOrderViewModelBaseActionController.startAction(
      name: 'NewOrderViewModelBase.resolveUncertainPayment',
    );
    try {
      return super.resolveUncertainPayment(wasSaved: wasSaved);
    } finally {
      _$NewOrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
savedOrderId: ${savedOrderId},
savedOrderRevision: ${savedOrderRevision},
savedOrderLabel: ${savedOrderLabel},
isSavingOrder: ${isSavingOrder},
savedCommandUncertain: ${savedCommandUncertain},
reopenWarnings: ${reopenWarnings},
refundActive: ${refundActive},
cashClosingActive: ${cashClosingActive},
products: ${products},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
selectedGroup: ${selectedGroup},
selectedCategory: ${selectedCategory},
searchQuery: ${searchQuery},
orderItems: ${orderItems},
orderType: ${orderType},
orderTypes: ${orderTypes},
cashSession: ${cashSession},
isLoadingPos: ${isLoadingPos},
isPaying: ${isPaying},
paymentUncertain: ${paymentUncertain},
checkoutError: ${checkoutError},
taxPercentage: ${taxPercentage},
wallets: ${wallets},
tables: ${tables},
openingCash: ${openingCash},
isOpeningCashResolved: ${isOpeningCashResolved},
categories: ${categories},
visibleProducts: ${visibleProducts},
hasOrderItems: ${hasOrderItems},
totalQuantity: ${totalQuantity},
totalPrice: ${totalPrice},
taxAmount: ${taxAmount},
paymentTotal: ${paymentTotal}
    ''';
  }
}
