import 'dart:typed_data';
import 'mock_account.dart';
import 'mock_reports.dart';
import 'mock_cash_sessions.dart';
import 'mock_refunds.dart';
import 'package:mobile_dikasa/core/network/mock_saved_orders.dart';
import 'package:dio/dio.dart';
import 'package:mobile_dikasa/core/network/api_endpoints.dart';
import 'package:mobile_dikasa/core/network/mock_catalog.dart';

/// Penjawab request tiruan sementara backend belum ada; data mengikuti Figma dan dinonaktifkan lewat `USE_MOCK_API=false`.
class MockApiInterceptor extends Interceptor {
  final _account = MockAccount();
  final _savedOrders = MockSavedOrders();
  late final _reports = MockReports(_orders, () => _refunds.cashActivity);
  late final _refunds = MockRefunds(
    _orders,
    _catalog,
    () => _cash != null,
    currentSessionId: () => _cash?['id'] as String?,
  );
  late final _cashLedger = MockCashSessions(
    _orders,
    () => _refunds.cashActivity,
  );
  Map<String, dynamic>? get _cash => _cashLedger.current;
  final List<Map<String, dynamic>> _orders = [];
  late final MockCatalog _catalog = MockCatalog(_products);

  /// Kredensial demo untuk mencoba alur login.
  static const String demoUsername = 'admin';
  static const String demoPassword = 'dikasa123';

  /// Jeda buatan supaya indikator loading benar-benar terlihat saat dicoba.
  static const Duration _latency = Duration(milliseconds: 700);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await Future<void>.delayed(_latency);
    if (await _account.handle(options, handler)) return;
    if (await _catalog.handle(options, handler)) return;
    if (options.path.startsWith('/reports/')) {
      try {
        final parts = options.path.split('/');
        final kind = parts[2];
        final exporting = parts.last == 'export.xlsx';
        handler.resolve(
          _response(
            options,
            200,
            exporting
                ? _reports.export(kind, options.queryParameters)
                : _reports.read(kind, options.queryParameters),
          ),
        );
      } on MockReportError catch (e) {
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            response: _response(options, e.status, {
              'error': {'code': e.code, 'message': e.message},
            }),
          ),
        );
      }
      return;
    }

    if (options.path == '/saved-orders' ||
        options.path.startsWith('/saved-orders/')) {
      try {
        final id = options.path == '/saved-orders'
            ? null
            : options.path.split('/').last;
        final Map<String, dynamic> result;
        if (options.method == 'GET') {
          result = id == null
              ? _savedOrders.list(
                  options.queryParameters['search'] as String? ?? '',
                  (options.queryParameters['page'] as num?)?.toInt() ?? 1,
                )
              : {'data': _savedOrders.get(id)};
        } else {
          final body = Map<String, dynamic>.from(
            (options.method == 'DELETE'
                    ? options.queryParameters
                    : options.data)
                as Map,
          );
          result = {'data': _savedOrders.execute(options.method, id, body)};
        }
        handler.resolve(_response(options, 200, result));
      } on MockSavedOrderError catch (e) {
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            response: _response(options, e.status, {
              'error': {'code': e.code, 'message': e.message},
            }),
          ),
        );
      }
      return;
    }

    if (options.path.startsWith('/transactions/') ||
        options.path.startsWith('/refunds/by-request/')) {
      try {
        final parts = options.path.split('/');
        final Map<String, dynamic> result;
        var status = 200;
        if (parts[1] == 'refunds') {
          final record = _refunds.byRequest(parts.last);
          if (record == null) {
            throw const MockRefundError(
              404,
              'DATA_TIDAK_DITEMUKAN',
              'Belum ada hasil terkonfirmasi.',
            );
          }
          result = {'data': record};
        } else if (parts.length == 3) {
          result = {'data': _refunds.detail(parts[2])};
        } else if (options.method == 'GET') {
          result = _refunds.history(
            parts[2],
            (options.queryParameters['page'] as num?)?.toInt() ?? 1,
          );
        } else {
          final body = Map<String, dynamic>.from(options.data as Map);
          if (parts.last == 'preview') {
            result = {'data': _refunds.preview(parts[2], body)};
          } else {
            result = {'data': _refunds.confirm(parts[2], body)};
            status = 201;
          }
        }
        handler.resolve(_response(options, status, result));
      } on MockRefundError catch (e) {
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            response: _response(options, e.status, {
              'error': {'code': e.code, 'message': e.message},
            }),
          ),
        );
      }
      return;
    }
    if (options.path.contains('/cash-sessions/') &&
        (options.path.endsWith('/activity') ||
            options.path.contains('/movements'))) {
      try {
        final parts = options.path.split('/');
        final sid = parts[2];
        dynamic result;
        var status = 200;
        if (parts.last == 'activity') {
          result = _cashLedger.movementActivity(
            sid,
            (options.queryParameters['page'] as num?)?.toInt() ?? 1,
          );
        } else if (options.method == 'POST' && parts.last == 'movements') {
          final f = options.data as FormData;
          final data = Map<String, dynamic>.from(Map.fromEntries(f.fields));
          final text = data['amount'] as String? ?? '';
          if (!RegExp(r'^[0-9]+$').hasMatch(text)) {
            throw const MockCashError(
              422,
              'CASH_MOVEMENT_INVALID',
              'Nominal harus bulat.',
            );
          }
          data['amount'] = int.parse(text);
          Uint8List? proof;
          if (f.files.isNotEmpty) {
            final b = await f.files.first.value.finalize().fold<List<int>>(
              [],
              (a, b) => a..addAll(b),
            );
            proof = Uint8List.fromList(b);
          }
          result = {
            'data': _cashLedger.movementCreate(sid, data, proof: proof),
          };
          status = 201;
        } else if (parts.last == 'reverse') {
          result = {
            'data': _cashLedger.movementReverse(
              sid,
              parts[4],
              Map<String, dynamic>.from(options.data as Map),
            ),
          };
          status = 201;
        } else if (parts.last == 'proof') {
          result = _cashLedger.movementProof(sid, parts[4]);
        } else if (parts.contains('by-request')) {
          result = {'data': _cashLedger.movementByRequest(sid, parts.last)};
        } else {
          result = {'data': _cashLedger.movementDetail(sid, parts[4])};
        }
        handler.resolve(_response(options, status, result));
      } on MockCashError catch (e) {
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            response: _response(options, e.status, {
              'error': {'code': e.code, 'message': e.message},
            }),
          ),
        );
      }
      return;
    }
    if (options.path == '/cash-sessions' ||
        options.path.startsWith('/cash-sessions/')) {
      try {
        final Map<String, dynamic> response;
        var status = 200;
        if (options.path == '/cash-sessions/current') {
          final active = _cash;
          if (active == null) {
            throw const MockCashError(
              404,
              'SESI_KAS_TIDAK_DITEMUKAN',
              'Belum ada sesi kas.',
            );
          }
          response = {'data': active};
        } else if (options.path == '/cash-sessions') {
          if (options.method == 'POST') {
            response = {
              'data': _cashLedger.open(options.data['opening_cash'] as int),
            };
            status = 201;
          } else {
            response = _cashLedger.list(
              (options.queryParameters['page'] as num?)?.toInt() ?? 1,
            );
          }
        } else {
          final parts = options.path.split('/');
          final id = parts[2];
          response = {
            'data': options.method == 'GET'
                ? _cashLedger.detail(id)
                : parts.last == 'preview'
                ? _cashLedger.preview(
                    id,
                    Map<String, dynamic>.from(options.data as Map),
                  )
                : _cashLedger.close(
                    id,
                    Map<String, dynamic>.from(options.data as Map),
                  ),
          };
        }
        handler.resolve(_response(options, status, response));
      } on MockCashError catch (e) {
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            response: _response(options, e.status, {
              'error': {'code': e.code, 'message': e.message},
            }),
          ),
        );
      }
      return;
    }
    switch (options.path) {
      case '/order-types':
        return handler.resolve(
          _response(options, 200, {
            'data': [
              {
                'id': 'mock-takeaway',
                'code': 'takeaway',
                'name': 'Bawa Pulang',
                'is_active': true,
              },
            ],
          }),
        );
      case '/payments/tax-percentage':
        return handler.resolve(_response(options, 200, {'tax_percentage': 10}));
      case '/wallets':
        return handler.resolve(
          _response(options, 200, {
            'data': [
              {'id': 'mock-gopay', 'name': 'GoPay', 'is_active': true},
            ],
          }),
        );
      case '/restaurant-tables':
        return handler.resolve(_response(options, 200, {'data': []}));
      case '/transactions':
        if (_cash == null) {
          handler.reject(
            DioException(
              requestOptions: options,
              type: DioExceptionType.badResponse,
              response: _response(options, 409, {
                'error': {
                  'code': 'SESI_KAS_BELUM_AKTIF',
                  'message': 'Buka sesi kas terlebih dahulu.',
                },
              }),
            ),
          );
          return;
        }
        final payload = Map<String, dynamic>.from(options.data as Map);
        try {
          _savedOrders.validatePayment(payload);
        } on MockSavedOrderError catch (e) {
          handler.reject(
            DioException(
              requestOptions: options,
              type: DioExceptionType.badResponse,
              response: _response(options, e.status, {
                'error': {'code': e.code, 'message': e.message},
              }),
            ),
          );
          return;
        }
        final stockError = _catalog.applySale(payload);
        if (stockError != null) {
          handler.reject(
            DioException(
              requestOptions: options,
              type: DioExceptionType.badResponse,
              response: _response(options, 409, {
                'error': {'message': stockError},
              }),
            ),
          );
          return;
        }
        final number = 'DEMO-${_orders.length + 1}';
        _savedOrders.completePayment(payload, number);
        _orders.insert(0, {
          ...payload,
          'cash_session_id': _cash!['id'],
          'id': number,
          'receipt_number': number,
          'customer_name': '',
          'ordered_at': DateTime.now().toUtc().toIso8601String(),
          'order_type': {'id': 'mock-takeaway', 'name': 'Bawa Pulang'},
          'status': 'paid',
          'total_quantity': (payload['items'] as List).fold<int>(
            0,
            (total, item) => total + (item['quantity'] as int),
          ),
        });
        _refunds.registerSale(_orders.first);
        return handler.resolve(
          _response(options, 201, {
            'data': {
              'id': number,
              'transaction_number': number,
              'total_amount': payload['total_amount'],
            },
          }),
        );
      case '/orders':
      case '/customers':
        final page = options.queryParameters['page'] as int? ?? 1;
        final search = (options.queryParameters['search'] as String? ?? '')
            .toLowerCase();
        final results = options.path == '/customers'
            ? <Map<String, dynamic>>[]
            : _orders
                  .where(
                    (item) =>
                        (item['receipt_number'] as String)
                            .toLowerCase()
                            .contains(search) &&
                        (options.queryParameters['status'] == null ||
                            options.queryParameters['status'] ==
                                item['status']),
                  )
                  .toList();
        return handler.resolve(
          _response(options, 200, {
            'data': results.skip((page - 1) * 20).take(20).toList(),
            'meta': {'page': page, 'page_size': 20, 'total': results.length},
          }),
        );
      case ApiEndpoints.login:
        return _handleLogin(options, handler);
      default:
        return handler.next(options);
    }
  }

  void _handleLogin(RequestOptions options, RequestInterceptorHandler handler) {
    final Map<String, dynamic> body =
        (options.data as Map<String, dynamic>?) ?? <String, dynamic>{};
    final String username = (body['identifier'] as String? ?? '').trim();
    final String password = body['password'] as String? ?? '';

    final bool isValid =
        username.toLowerCase() == demoUsername && password == _account.password;

    if (!isValid) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: _response(options, 401, <String, dynamic>{
            'message': 'Username atau password salah.',
          }),
        ),
      );
    }

    handler.resolve(
      _response(options, 200, <String, dynamic>{
        'token': 'mock-token-dikasa',
        'user': <String, dynamic>{
          'id': '1',
          'name':
              '${_account.profile['first_name'] ?? ''} ${_account.profile['last_name'] ?? ''}'
                  .trim(),
          'username': demoUsername,
          'role': 'Kasir',
          'outlet_name': 'Warteg Bahari',
        },
      }),
    );
  }

  Response<dynamic> _response(
    RequestOptions options,
    int statusCode,
    dynamic data,
  ) {
    return Response<dynamic>(
      requestOptions: options,
      statusCode: statusCode,
      data: data,
    );
  }

  /// Katalog contoh. Nama, harga, dan gambar mengikuti desain Figma
  /// "Order - Clean" beserta variannya.
  static const List<Map<String, dynamic>> _products = <Map<String, dynamic>>[
    <String, dynamic>{
      'id': 'p1',
      'name': 'Cumi Goreng Asam Manis',
      'price': 21000,
      'image_asset': 'assets/images/cumia_goreng_asam_manis.png',
      'group': 'makanan',
      'category': 'Seafood',
      'is_highlighted': false,
    },
    <String, dynamic>{
      'id': 'p2',
      'name': 'Cumi Goreng Mentega',
      'price': 21000,
      'image_asset': 'assets/images/cumi_goreng_mentega.png',
      'group': 'makanan',
      'category': 'Seafood',
      'is_highlighted': true,
    },
    <String, dynamic>{
      'id': 'p3',
      'name': "Se'i Sapi Single Portion",
      'price': 21000,
      'image_asset': 'assets/images/sei_sapi_single_portion.png',
      'group': 'makanan',
      'category': 'Daging',
      'is_highlighted': false,
    },
    <String, dynamic>{
      'id': 'p4',
      'name': 'Ayam Geprek Sambal Matah',
      'price': 21000,
      'image_asset': 'assets/images/ayam_geprek_sambel_matah.png',
      'group': 'makanan',
      'category': 'Ayam',
      'is_highlighted': false,
    },
    <String, dynamic>{
      'id': 'p5',
      'name': 'Nasi Goreng Nugget',
      'price': 21000,
      'image_asset': 'assets/images/nasi_goreng_nugget.png',
      'group': 'makanan',
      'category': 'Nasi Goreng',
      'is_highlighted': false,
    },
    <String, dynamic>{
      'id': 'p6',
      'name': "Se'i Sapi Double Portion",
      'price': 21000,
      'image_asset': 'assets/images/sei_sapi_double_portion.png',
      'group': 'makanan',
      'category': 'Daging',
      'is_highlighted': false,
    },
    <String, dynamic>{
      'id': 'p7',
      'name': 'Nasi Goreng Spesial',
      'price': 21000,
      'image_asset': 'assets/images/nasi_goreng_spesial.png',
      'group': 'makanan',
      'category': 'Nasi Goreng',
      'is_highlighted': false,
    },
    <String, dynamic>{
      'id': 'p8',
      'name': 'Nasi Goreng Sosis',
      'price': 21000,
      'image_asset': 'assets/images/nasi_goreng_sosis.png',
      'group': 'makanan',
      'category': 'Nasi Goreng',
      'is_highlighted': false,
    },
    <String, dynamic>{
      'id': 'p9',
      'name': 'Ayam Geprek Spesial',
      'price': 21000,
      'image_asset': 'assets/images/ayam_geprek_spesial.png',
      'group': 'makanan',
      'category': 'Ayam',
      'is_highlighted': true,
    },
    <String, dynamic>{
      'id': 'p10',
      'name': 'Nasi Goreng Katsu',
      'price': 21000,
      'image_asset': 'assets/images/nasi_goreng_katsu.png',
      'group': 'makanan',
      'category': 'Nasi Goreng',
      'is_highlighted': false,
    },
    <String, dynamic>{
      'id': 'p11',
      'name': 'Chicken Katsu with Rice',
      'price': 21000,
      'image_asset': 'assets/images/chicken_katsu_with_rice.png',
      'group': 'makanan',
      'category': 'Ayam',
      'is_highlighted': false,
    },
    <String, dynamic>{
      'id': 'p12',
      'name': 'Es Teh Manis Jumbo',
      'price': 10000,
      'image_asset': 'assets/images/es_teh_manis_jumbo.png',
      'group': 'minuman',
      'category': 'Teh',
      'is_highlighted': false,
    },
    <String, dynamic>{
      'id': 'p13',
      'name': 'Teh Manis Panas',
      'price': 8000,
      'image_asset': 'assets/images/teh_manis_panas.png',
      'group': 'minuman',
      'category': 'Teh',
      'is_highlighted': false,
    },
    <String, dynamic>{
      'id': 'p14',
      'name': 'Ice Lemon Tea',
      'price': 12000,
      'image_asset': 'assets/images/ice_lemon_tea.png',
      'group': 'minuman',
      'category': 'Teh',
      'is_highlighted': false,
    },
    <String, dynamic>{
      'id': 'p15',
      'name': 'Ice Choco Hazelnut',
      'price': 25000,
      'image_asset': 'assets/images/ice_choco_hazelnut.png',
      'group': 'minuman',
      'category': 'Kopi & Coklat',
      'is_highlighted': false,
    },
  ];
}
