import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/models/pos.dart';
import 'package:mobile_dikasa/data/models/product.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/repositories/product_repository.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/services/product_service.dart';
import 'package:mobile_dikasa/data/services/pos_service.dart';
import 'package:mobile_dikasa/features/new_order/view_model.dart';

void main() {
  late NewOrderViewModel vm;
  late ApiClient client;
  late AuthRepository auth;
  const product = Product(
    id: 'product-uuid',
    name: 'Nasi Goreng',
    price: 21000,
    imageAsset: '',
    group: ProductGroup.makanan,
    category: 'Menu',
    isHighlighted: false,
  );
  setUp(() {
    dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    );
    client = ApiClient();
    auth = AuthRepository(authService: AuthService(client), apiClient: client);
    vm = NewOrderViewModel(
      productRepository: ProductRepository(
        productService: ProductService(client),
      ),
      authRepository: auth,
      posService: PosService(client),
    );
  });

  test(
    'switching accounts clears the prior outlet cart and cash state',
    () async {
      var account = 'first';
      client.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (request, handler) {
            if (request.path == '/login') {
              handler.resolve(
                Response(
                  requestOptions: request,
                  statusCode: 200,
                  data: {
                    'token': 'session',
                    'user': {
                      'id': account,
                      'name': account,
                      'username': account,
                      'role': 'manager',
                      'outlet_name': account,
                    },
                  },
                ),
              );
            } else if (request.path == '/order-types') {
              handler.resolve(
                Response(
                  requestOptions: request,
                  statusCode: 200,
                  data: {
                    'data': [
                      {
                        'id': 'type-$account',
                        'code': 'takeaway',
                        'name': 'Bungkus',
                        'is_active': true,
                      },
                    ],
                  },
                ),
              );
            } else if (request.path == '/products') {
              handler.resolve(
                Response(
                  requestOptions: request,
                  statusCode: 200,
                  data: {
                    'data': [
                      {
                        'id': 'product-$account',
                        'name': 'Menu',
                        'price': 21000,
                        'product_type': 'food',
                        'category': {'name': 'Menu'},
                      },
                    ],
                    'meta': {'page': 1, 'page_size': 100, 'total': 1},
                  },
                ),
              );
            } else if (account == 'first') {
              handler.resolve(
                Response(
                  requestOptions: request,
                  statusCode: 200,
                  data: {
                    'data': {
                      'id': 'cash-first',
                      'opening_cash': 100000,
                      'status': 'open',
                    },
                  },
                ),
              );
            } else {
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
            }
          },
        ),
      );
      await auth.login(username: 'first', password: 'example123');
      await vm.loadPos();
      await vm.loadProducts();
      vm.addProduct(product);
      vm.selectOrderType(vm.orderTypes.single);
      account = 'second';
      auth.logout();
      await auth.login(username: 'second', password: 'example123');
      await vm.loadPos();
      expect(vm.orderItems, isEmpty);
      expect(vm.orderType, isNull);
      expect(vm.cashSession, isNull);
      expect(vm.openingCash, isNull);
      expect(vm.isOpeningCashResolved, isFalse);
      expect(vm.orderTypes.single.id, 'type-second');
      expect(vm.products, isEmpty);
    },
  );

  test('new account load replaces an earlier in-flight POS request', () async {
    var account = 'first';
    final firstResponse = Completer<void>();
    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          final requestedAccount = account;
          if (request.path == '/login') {
            handler.resolve(
              Response(
                requestOptions: request,
                statusCode: 200,
                data: {
                  'token': 'session',
                  'user': {
                    'id': requestedAccount,
                    'name': requestedAccount,
                    'username': requestedAccount,
                    'role': 'manager',
                    'outlet_name': requestedAccount,
                  },
                },
              ),
            );
            return;
          }
          if (requestedAccount == 'first') await firstResponse.future;
          handler.resolve(
            Response(
              requestOptions: request,
              statusCode: 200,
              data: {
                'data': request.path == '/order-types'
                    ? [
                        {
                          'id': 'type-$requestedAccount',
                          'code': 'takeaway',
                          'name': 'Bungkus',
                          'is_active': true,
                        },
                      ]
                    : {
                        'id': 'cash-$requestedAccount',
                        'opening_cash': 0,
                        'status': 'open',
                      },
              },
            ),
          );
        },
      ),
    );
    await auth.login(username: 'first', password: 'example123');
    final oldLoad = vm.loadPos();
    await Future<void>.delayed(Duration.zero);
    account = 'second';
    await auth.login(username: 'second', password: 'example123');
    await vm.loadPos();
    expect(vm.orderTypes.single.id, 'type-second');
    firstResponse.complete();
    await oldLoad;
    expect(vm.orderTypes.single.id, 'type-second');
    expect(vm.cashSession!.id, 'cash-second');
  });

  test(
    'successful payment snapshots totals and clears cart only after server confirms',
    () async {
      final response = Completer<void>();
      var writes = 0;
      client.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (request, handler) async {
            writes++;
            expect(request.path, '/transactions');
            expect(request.data['subtotal'], 42000);
            expect(request.data['tax_amount'], 4200);
            expect(request.data['total_amount'], 46200);
            expect(request.data['paid_amount'], 50000);
            expect(request.data['change_amount'], 3800);
            expect(request.data['order_type_id'], 'type-uuid');
            expect(request.data['items'][0]['quantity'], 2);
            expect(request.data['items'][0]['line_total'], 42000);
            await response.future;
            handler.resolve(
              Response(
                requestOptions: request,
                statusCode: 201,
                data: {
                  'data': {
                    'id': 'transaction-uuid',
                    'transaction_number': 'TRX-001',
                    'total_amount': 46200,
                  },
                },
              ),
            );
          },
        ),
      );
      vm.cashSession = const CashSession(id: 'cash-uuid', openingCash: 100000);
      vm.orderTypes.add(
        const PosOrderType(id: 'type-uuid', code: 'takeaway', label: 'Bungkus'),
      );
      vm.selectOrderType(vm.orderTypes.single);
      vm.taxPercentage = 10;
      vm.addProduct(product);
      vm.addProduct(product);
      final first = vm.pay(method: 'cash', paidAmount: 50000);
      expect(vm.isPaying, isTrue);
      expect(vm.orderItems, isNotEmpty);
      expect(await vm.pay(method: 'cash', paidAmount: 50000), isNull);
      await Future<void>.delayed(Duration.zero);
      response.complete();
      final receipt = await first;
      expect(receipt?.number, 'TRX-001');
      expect(vm.orderItems, isEmpty);
      expect(writes, 1);
      expect(vm.isPaying, isFalse);
    },
  );

  test(
    'validation prevents missing cash, missing type, insufficient cash and missing wallet',
    () async {
      vm.addProduct(product);
      expect(await vm.pay(method: 'cash', paidAmount: 50000), isNull);
      expect(vm.checkoutError, contains('kas'));
      vm.cashSession = const CashSession(id: 'cash-uuid', openingCash: 0);
      expect(await vm.pay(method: 'cash', paidAmount: 50000), isNull);
      vm.orderTypes.add(
        const PosOrderType(id: 'type-uuid', code: 'takeaway', label: 'Bungkus'),
      );
      vm.selectOrderType(vm.orderTypes.single);
      expect(await vm.pay(method: 'cash', paidAmount: 1), isNull);
      expect(await vm.pay(method: 'wallet', paidAmount: 21000), isNull);
      expect(vm.orderItems, isNotEmpty);
    },
  );

  test(
    'network uncertainty keeps cart and blocks another payment attempt',
    () async {
      var writes = 0;
      client.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (request, handler) {
            writes++;
            handler.reject(
              DioException(
                requestOptions: request,
                type: DioExceptionType.receiveTimeout,
              ),
            );
          },
        ),
      );
      vm.cashSession = const CashSession(id: 'cash-uuid', openingCash: 0);
      vm.orderTypes.add(
        const PosOrderType(id: 'type-uuid', code: 'takeaway', label: 'Bungkus'),
      );
      vm.selectOrderType(vm.orderTypes.single);
      vm.addProduct(product);
      expect(await vm.pay(method: 'cash', paidAmount: 50000), isNull);
      expect(vm.paymentUncertain, isTrue);
      expect(vm.orderItems, isNotEmpty);
      expect(await vm.pay(method: 'cash', paidAmount: 50000), isNull);
      expect(writes, 1);
    },
  );
}
