import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/repositories/product_repository.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/services/product_service.dart';
import 'package:mobile_dikasa/data/services/pos_service.dart';
import 'package:mobile_dikasa/features/new_order/view.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';
import 'package:mobile_dikasa/features/new_order/widgets/opening_cash_dialog.dart';
import 'package:mobile_dikasa/features/new_order/widgets/payment_dialog.dart';
import 'package:mobile_dikasa/features/new_order/widgets/sales_browser.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('cash -> cart -> payment -> persisted receipt in order history', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1340, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    final client = ApiClient();
    var opened = false;
    var paid = false;
    var writes = 0;
    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          dynamic body;
          switch (request.path) {
            case '/products':
              body = {
                'data': [
                  {
                    'id': 'p1',
                    'name': 'Nasi Goreng',
                    'price': 21000,
                    'product_type': 'food',
                    'category': {'name': 'Menu'},
                    'is_highlighted': false,
                  },
                ],
                'meta': {'page': 1, 'page_size': 100, 'total': 1},
              };
            case '/order-types':
              body = {
                'data': [
                  {
                    'id': 'type1',
                    'code': 'takeaway',
                    'name': 'Bungkus',
                    'is_active': true,
                  },
                ],
              };
            case '/cash-sessions/current':
              if (!opened) {
                handler.reject(
                  DioException(
                    requestOptions: request,
                    type: DioExceptionType.badResponse,
                    response: Response(
                      requestOptions: request,
                      statusCode: 404,
                      data: {
                        'error': {'code': 'SESI_KAS_TIDAK_DITEMUKAN'},
                      },
                    ),
                  ),
                );
                return;
              }
              body = {
                'data': {
                  'id': 'cash1',
                  'opening_cash': 100000,
                  'status': 'open',
                },
              };
            case '/cash-sessions':
              expect(request.data, {'opening_cash': 100000});
              opened = true;
              body = {
                'data': {
                  'id': 'cash1',
                  'opening_cash': 100000,
                  'status': 'open',
                },
              };
            case '/payments/tax-percentage':
              body = {'tax_percentage': 10};
            case '/wallets':
              body = {
                'data': [
                  {'id': 'wallet1', 'name': 'GoPay', 'is_active': true},
                ],
              };
            case '/restaurant-tables':
              body = {'data': []};
            case '/transactions':
              writes++;
              expect(opened, isTrue);
              expect(request.data['total_amount'], 23100);
              expect(request.data['change_amount'], 26900);
              paid = true;
              body = {
                'data': {
                  'id': 'trx1',
                  'transaction_number': 'TRX-VERIFIED',
                  'total_amount': 23100,
                },
              };
            case '/orders':
              body = {
                'data': paid
                    ? [
                        {
                          'id': 'trx1',
                          'receipt_number': 'TRX-VERIFIED',
                          'ordered_at': '2026-10-19T10:00:00Z',
                          'order_type': {'name': 'Bungkus'},
                          'total_amount': 23100,
                          'status': 'paid',
                        },
                      ]
                    : [],
                'meta': {'page': 1, 'page_size': 20, 'total': paid ? 1 : 0},
              };
            default:
              throw StateError('Unexpected request ${request.path}');
          }
          handler.resolve(
            Response(requestOptions: request, statusCode: 200, data: body),
          );
        },
      ),
    );
    final vm = NewOrderViewModel(
      productRepository: ProductRepository(
        productService: ProductService(client),
      ),
      authRepository: AuthRepository(
        authService: AuthService(client),
        apiClient: client,
      ),
      posService: PosService(client),
    );
    await tester.pumpWidget(
      Provider<NewOrderViewModel>.value(
        value: vm,
        child: const MaterialApp(home: NewOrderView()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(OpeningCashDialog), findsOneWidget);
    expect(tester.takeException(), isNull, reason: 'opening cash layout');
    await tester.enterText(find.byType(TextField).last, '100000');
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();
    expect(opened, isTrue);
    expect(tester.takeException(), isNull, reason: 'catalog layout');
    await tester.tap(find.text('Nasi Goreng').first);
    await tester.tap(find.byTooltip('-- Pilih Jenis Order --'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bungkus').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bayar'));
    await tester.pumpAndSettle();
    expect(find.byType(PaymentDialog), findsOneWidget);
    expect(tester.takeException(), isNull, reason: 'payment dialog layout');
    await tester.enterText(
      find.widgetWithText(TextField, 'Uang diterima'),
      '50000',
    );
    await tester.tap(find.text('Proses Bayar'));
    await tester.pumpAndSettle();
    expect(find.text('Transaksi Berhasil'), findsOneWidget);
    expect(tester.takeException(), isNull, reason: 'receipt layout');
    expect(writes, 1);
    expect(vm.orderItems, isEmpty);
    await tester.tap(find.text('Selesai'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Daftar Order').first);
    await tester.pumpAndSettle();
    expect(find.byType(SalesBrowser), findsOneWidget);
    expect(find.text('TRX-VERIFIED'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('opening cash stays open when server rejects the amount', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OpeningCashDialog(
            onConfirm: (_) async => 'Gagal menyimpan kas.',
          ),
        ),
      ),
    );
    await tester.enterText(find.byType(TextField), '100000');
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();
    expect(find.byType(OpeningCashDialog), findsOneWidget);
    expect(find.text('Gagal menyimpan kas.'), findsOneWidget);
  });
}
