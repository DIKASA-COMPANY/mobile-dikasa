import 'package:mobile_dikasa/features/new_order/widgets/browser_design.dart';
import 'package:dio/dio.dart';
import 'package:mobile_dikasa/data/models/saved_order.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/models/pos.dart';
import 'package:mobile_dikasa/data/models/payment_snapshot.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/features/new_order/widgets/payment_success_view.dart';
import 'package:mobile_dikasa/features/new_order/widgets/sales_browser.dart';
import 'saved_order_test.dart' show TestAuth, TestPos, TestProducts;

class BrowserPos extends TestPos {
  BrowserPos(super.c);
  bool deleted = false;
  @override
  Future<SavedOrderPage> savedOrders({
    String search = "",
    int page = 1,
  }) async => deleted
      ? SavedOrderPage([], 0, page)
      : super.savedOrders(search: search, page: page);
  @override
  Future<SavedOrder> deleteSavedOrder(
    String id, {
    required String requestId,
    required int revision,
  }) async {
    deleted = true;
    return SavedOrder.fromJson({...draft, "status": "deleted"});
  }

  bool empty = false, fail = false;
  Completer<PosPage>? pendingCustomers;
  int lastPage = 0;
  String lastSearch = '';
  String? lastStatus;
  @override
  Future<PosPage> customers({String search = '', int page = 1}) async {
    lastPage = page;
    lastSearch = search;
    if (fail) {
      throw const ApiException(
        type: ApiErrorType.server,
        message: 'Test connection failed',
      );
    }
    if (pendingCustomers != null) return pendingCustomers!.future;
    return PosPage(
      items: empty
          ? []
          : [
              {
                'name': 'Jane Doe',
                'address': 'Jalan Bandung',
                'gender': {'name': 'Wanita'},
                'points': 2321,
                'phone_number': '08123456789',
                'email': null,
              },
              {
                'name': 'John Doe',
                'address': 'Komplek Setrasari, Bandung',
                'points': 5749,
                'gender': null,
                'phone_number': '08123456780',
                'email': 'john@example.test',
              },
            ],
      total: empty ? 0 : 21,
      page: page,
    );
  }

  @override
  Future<PosPage> orders({
    String search = '',
    int page = 1,
    String? status,
    String? orderTypeId,
  }) async {
    lastPage = page;
    lastSearch = search;
    lastStatus = status;
    return PosPage(
      items: empty
          ? []
          : [
              {
                'id': 'receipt',
                'receipt_number': 'TRX-42',
                'customer_name': 'Jane Doe',
                'ordered_at': '2026-10-24T10:00:00Z',
                'order_type': {'name': 'Dine-In'},
                'restaurant_table': {'name': 'Meja 5'},
                'total_quantity': 7,
                'total_amount': 120000,
                'refunded_amount': 20000,
                'net_after_refund': 100000,
                'status': 'partially_refunded',
              },
            ],
      total: empty ? 0 : 21,
      page: page,
    );
  }
}

void main() {
  Widget qa(Widget child) =>
      RepaintBoundary(key: const ValueKey("figma-batch-one"), child: child);
  late NewOrderViewModel vm;
  late BrowserPos pos;
  late TestAuth auth;
  setUpAll(() async {
    final f = FontLoader('Poppins');
    for (final file in [
      'Poppins-Regular.ttf',
      'Poppins-Medium.ttf',
      'Poppins-SemiBold.ttf',
      'Poppins-Bold.ttf',
      'Poppins-Italic.ttf',
    ]) {
      f.addFont(rootBundle.load('assets/fonts/$file'));
    }
    await f.load();
    final icons = FontLoader("MaterialIcons")
      ..addFont(rootBundle.load("fonts/MaterialIcons-Regular.otf"));
    await icons.load();
  });
  setUp(() async {
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    final c = ApiClient();
    c.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (r, h) {
          if (r.method == 'GET' && r.path == '/transactions/receipt') {
            h.resolve(
              Response(
                requestOptions: r,
                statusCode: 200,
                data: {
                  'data': {
                    'id': 'receipt',
                    'transaction_number': 'TRX-42',
                    'status': 'partially_refunded',
                    'payment_method': 'cash',
                    'refund_revision': 1,
                    'total_amount': 120000,
                    'refunded_amount': 20000,
                    'refunds_supported': true,
                    'items': [],
                  },
                },
              ),
            );
            return;
          }
          if (r.method == 'GET' && r.path == '/transactions/receipt/refunds') {
            h.resolve(
              Response(
                requestOptions: r,
                statusCode: 200,
                data: {
                  'data': [],
                  'meta': {'total': 0},
                },
              ),
            );
            return;
          }
          h.reject(
            DioException(
              requestOptions: r,
              error: 'Unexpected test HTTP request',
            ),
          );
        },
      ),
    );
    auth = TestAuth(c);
    pos = BrowserPos(c);
    vm = NewOrderViewModel(
      productRepository: TestProducts(c),
      authRepository: auth,
      posService: pos,
    );
    await vm.loadProducts();
    await vm.loadPos();
  });
  Future<void> browser(
    WidgetTester t, {
    bool customers = false,
    double width = 1340,
  }) async {
    t.view.physicalSize = Size(width, 800);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.reset);
    await t.pumpWidget(
      qa(
        MaterialApp(
          theme: ThemeData(fontFamily: 'Poppins'),
          home: Builder(
            builder: (c) => Scaffold(
              body: TextButton(
                onPressed: () => SalesBrowser.show(c, vm, customers: customers),
                child: const Text('Browse'),
              ),
            ),
          ),
        ),
      ),
    );
    await t.tap(find.text('Browse'));
    await t.pumpAndSettle();
    await t.runAsync(
      () => precacheImage(
        const AssetImage('assets/images/batch_one_empty.png'),
        t.element(find.byType(SalesBrowser)),
      ),
    );
    await t.pumpAndSettle();
  }

  Future<void> capture(WidgetTester t, String name) async {
    if (!const bool.fromEnvironment('CAPTURE_FIGMA_BATCH_ONE')) return;
    await t.pumpAndSettle();
    await t.runAsync(() async {
      final boundary = t.firstRenderObject<RenderRepaintBoundary>(
        find.byKey(const ValueKey("figma-batch-one")),
      );
      final im = await boundary.toImage();
      final b = await im.toByteData(format: ui.ImageByteFormat.png);
      await File(
        'build/figma-batch-one-$name.png',
      ).writeAsBytes(b!.buffer.asUint8List());
      im.dispose();
    });
  }

  testWidgets(
    'customer Figma page has six truthful fields and disabled mutations',
    (t) async {
      await browser(t, customers: true);
      expect(find.text('Pelanggan Terdaftar'), findsOneWidget);
      expect(find.text('Alamat'), findsOneWidget);
      expect(find.text('Gender'), findsOneWidget);
      expect(find.text('Jalan Bandung'), findsOneWidget);
      expect(find.text('Wanita'), findsOneWidget);
      expect(
        t
            .widget<OutlinedButton>(
              find.widgetWithText(OutlinedButton, 'Tambah'),
            )
            .onPressed,
        isNull,
      );
      expect(
        t
            .widget<OutlinedButton>(
              find.widgetWithText(OutlinedButton, 'Tanpa Pelanggan'),
            )
            .onPressed,
        isNull,
      );
      expect(find.byType(Dialog), findsNothing);
      expect(t.takeException(), isNull);
      for (final entry in {
        'menu': const Size(34.4, 26),
        'back': const Size(32, 25),
        'lock': const Size(46, 46),
        'lock-background': const Size(54, 54),
        'search': const Size(19, 19),
        'add': const Size(24, 24),
        'row-line': const Size(1248, 1),
      }.entries) {
        expect(
          t.getSize(
            find
                .byWidgetPredicate(
                  (w) => w is BrowserDesignIcon && w.name == entry.key,
                )
                .first,
          ),
          entry.value,
        );
      }
      await capture(t, 'customers-desktop');
      await t.tap(find.text('Berikutnya'));
      await t.pumpAndSettle();
      expect(pos.lastPage, 2);
      await t.enterText(find.byType(TextField).first, 'Jane');
      await t.testTextInput.receiveAction(TextInputAction.search);
      await t.pumpAndSettle();
      expect(pos.lastSearch, 'Jane');
      expect(pos.lastPage, 1);
    },
  );
  testWidgets(
    'empty and searched customer states differ and fit narrow widths',
    (t) async {
      pos.empty = true;
      await browser(t, customers: true, width: 390);
      expect(find.textContaining('Masih Kosong'), findsOneWidget);
      await capture(t, 'customers-empty-narrow');
      await t.ensureVisible(find.textContaining('Masih Kosong'));
      await t.pumpAndSettle();
      await capture(t, 'customers-empty-narrow-text');
      t.view.physicalSize = const Size(1340, 800);
      await t.pumpAndSettle();
      await capture(t, 'customers-empty-desktop');
      t.view.physicalSize = const Size(390, 800);
      await t.pumpAndSettle();
      await t.enterText(find.byType(TextField).first, 'missing');
      await t.testTextInput.receiveAction(TextInputAction.search);
      await t.pumpAndSettle();
      expect(find.textContaining('Tidak ada hasil'), findsOneWidget);
      expect(t.takeException(), isNull);
    },
  );
  testWidgets('customer error can retry without losing the page', (t) async {
    pos.fail = true;
    await browser(t, customers: true);
    expect(find.text('Test connection failed'), findsOneWidget);
    await capture(t, 'customers-error');
    pos.fail = false;
    await t.tap(find.text('Coba lagi'));
    await t.pumpAndSettle();
    expect(find.text('Jane Doe'), findsOneWidget);
  });
  testWidgets('late customer results cannot cross session changes', (t) async {
    pos.pendingCustomers = Completer<PosPage>();
    t.view.physicalSize = const Size(1340, 800);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.reset);
    await t.pumpWidget(
      MaterialApp(home: SalesBrowser(viewModel: vm, customers: true)),
    );
    await t.pump();
    auth.logout();
    pos.pendingCustomers!.complete(
      const PosPage(
        items: [
          {'name': 'Secret old customer'},
        ],
        total: 1,
        page: 1,
      ),
    );
    await t.pumpAndSettle();
    expect(find.text('Secret old customer'), findsNothing);
  });
  testWidgets(
    'paid order Figma columns retain table quantities and refund information',
    (t) async {
      await browser(t);
      for (final h in [
        'No Nota',
        'Nama Pelanggan',
        'Tanggal Order',
        'Jumlah',
        'Tagihan',
      ]) {
        expect(find.text(h), findsOneWidget);
      }
      expect(find.text('TRX-42'), findsOneWidget);
      expect(find.text('Dine-In [Meja 5]'), findsOneWidget);
      expect(find.text('7 Produk'), findsOneWidget);
      expect(find.byTooltip('Detail transaksi'), findsOneWidget);
      expect(find.byType(Dialog), findsNothing);
      expect(
        t.getSize(
          find.byWidgetPredicate(
            (w) => w is BrowserDesignIcon && w.name == 'edit',
          ),
        ),
        const Size(22, 22.0007),
      );
      expect(
        t.getSize(
          find.byWidgetPredicate(
            (w) => w is BrowserDesignIcon && w.name == 'down',
          ),
        ),
        const Size(18.093, 10.0653),
      );
      await capture(t, 'orders-desktop');
      expect(t.takeException(), isNull);
      await t.tap(find.text('Tersimpan'));
      await t.pumpAndSettle();
      expect(find.text('Table A'), findsOneWidget);
      expect(find.textContaining('sebelum pajak'), findsWidgets);
      await capture(t, 'saved-desktop');
    },
  );
  testWidgets('paid filters and receipt action retain their behavior', (
    t,
  ) async {
    await browser(t);
    await t.tap(find.text('Filter List Order'));
    await t.pumpAndSettle();
    await t.tap(find.byType(DropdownButtonFormField<String>).first);
    await t.pumpAndSettle();
    await t.tap(find.text('Dikembalikan').last);
    await t.pumpAndSettle();
    await t.tap(find.text('Terapkan'));
    await t.pumpAndSettle();
    expect(pos.lastStatus, 'refunded');
    await t.tap(find.byTooltip('Detail transaksi'));
    await t.pumpAndSettle();
    expect(find.text('Sudah refund: Rp 20.000'), findsOneWidget);
    expect(find.text('Sisa nilai: Rp 100.000'), findsOneWidget);
    expect(t.takeException(), isNull);
  });
  testWidgets('saved open and confirmed delete use existing guarded actions', (
    t,
  ) async {
    await browser(t);
    await t.tap(find.text('Tersimpan'));
    await t.pumpAndSettle();
    await t.tap(find.text('Buka'));
    await t.pumpAndSettle();
    expect(find.byType(SalesBrowser), findsNothing);
    expect(vm.savedOrderId, 'draft');
    await t.tap(find.text('Browse'));
    await t.pumpAndSettle();
    await t.tap(find.text('Tersimpan'));
    await t.pumpAndSettle();
    await t.tap(find.byTooltip('Hapus pesanan'));
    await t.pumpAndSettle();
    await t.tap(find.widgetWithText(FilledButton, 'Hapus Pesanan'));
    await t.pumpAndSettle();
    expect(pos.deleted, isTrue);
    expect(find.text('Table A'), findsNothing);
    expect(t.takeException(), isNull);
  });
  testWidgets('populated narrow order and customer tables remain scrollable', (
    t,
  ) async {
    await browser(t, width: 390);
    expect(find.text('TRX-42'), findsOneWidget);
    await capture(t, 'orders-narrow');
    await t.drag(
      find.byType(SingleChildScrollView).last,
      const Offset(-900, 0),
    );
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);
    final owner = Object();
    vm.beginRefund(owner);
    await t.pumpAndSettle();
    await t.tap(find.text('Tersimpan'));
    await t.pumpAndSettle();
    expect(find.text('Table A'), findsNothing);
    vm.endRefund(owner);
    await t.pumpAndSettle();
    await t.tap(find.byTooltip('Kembali'));
    await t.pumpAndSettle();
    await browser(t, customers: true, width: 390);
    await capture(t, 'customers-narrow');
    expect(t.takeException(), isNull);
  });
  testWidgets('order empty state and narrow table have no overflow', (t) async {
    pos.empty = true;
    await browser(t, width: 390);
    expect(find.textContaining('Masih Kosong'), findsOneWidget);
    await capture(t, 'orders-empty-narrow');
    expect(t.takeException(), isNull);
  });
  testWidgets(
    'payment success shows immutable receipt with disabled unfinished actions',
    (t) async {
      t.view.physicalSize = const Size(1340, 800);
      t.view.devicePixelRatio = 1;
      addTearDown(t.view.reset);
      final snapshot = PaymentSnapshot.fromPayload({
        'subtotal': 200000,
        'tax_percentage': 10,
        'tax_amount': 20000,
        'total_amount': 220000,
        'paid_amount': 250000,
        'change_amount': 30000,
        'rounding_amount': 0,
        'tip_amount': 0,
        'payment_method': 'cash',
        'items': [
          {
            'product_name': 'Nasi Goreng Spesial',
            'quantity': 1,
            'unit_price': 100000,
            'line_total': 100000,
            'notes': 'Tidak pedas',
          },
          {
            'product_name': 'Cumi Goreng',
            'variant_name': 'Asam Manis',
            'quantity': 2,
            'unit_price': 30000,
            'line_total': 60000,
            'notes': '',
          },
          {
            'product_name': 'Se’i Sapi Sambal Matah',
            'quantity': 1,
            'unit_price': 40000,
            'line_total': 40000,
            'notes': '',
          },
        ],
      }, orderTypeLabel: 'Bungkus');
      await t.pumpWidget(
        qa(
          MaterialApp(
            theme: ThemeData(fontFamily: 'Poppins'),
            home: PaymentSuccessView(
              receipt: PaymentReceipt(
                id: 'id',
                number: 'TRX-42',
                total: 220000,
                snapshot: snapshot,
              ),
              user: auth.currentUser,
              auth: auth,
            ),
          ),
        ),
      );
      await t.pumpAndSettle();
      expect(find.text('Transaksi Berhasil'), findsOneWidget);
      expect(find.text('Nasi Goreng Spesial'), findsOneWidget);
      expect(find.text('LUNAS'), findsOneWidget);
      expect(
        t
            .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'Cetak Struk'),
            )
            .onPressed,
        isNull,
      );
      for (final entry in {
        'check': const Size(53, 51),
        'success-line': const Size(446, 2),
        'panel-line': const Size(624, 1),
        'summary-line': const Size(450.01, 1),
      }.entries) {
        expect(
          t.getSize(
            find
                .byWidgetPredicate(
                  (w) => w is BrowserDesignIcon && w.name == entry.key,
                )
                .first,
          ),
          entry.value,
        );
      }
      await capture(t, 'success-desktop');
      expect(t.takeException(), isNull);
      t.view.physicalSize = const Size(390, 844);
      await t.pumpAndSettle();
      await capture(t, 'success-narrow');
      await t.ensureVisible(find.text('Selesai'));
      await t.pumpAndSettle();
      await capture(t, 'success-narrow-actions');
      expect(t.takeException(), isNull);
      auth.logout();
      await t.pumpAndSettle();
      expect(find.text('TRX-42'), findsNothing);
      expect(find.text('Sesi berubah'), findsOneWidget);
    },
  );
}
