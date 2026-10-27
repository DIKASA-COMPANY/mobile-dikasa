import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile_dikasa/core/network/api_endpoints.dart';

/// Penjawab request tiruan sementara backend belum ada; data mengikuti Figma dan dinonaktifkan lewat `USE_MOCK_API=false`.
class MockApiInterceptor extends Interceptor {
  /// Kredensial demo untuk mencoba alur login.
  static const String demoUsername = 'admin';
  static const String demoPassword = 'dikasa123';

  /// Jeda buatan supaya indikator loading benar-benar terlihat saat dicoba.
  static const Duration _latency = Duration(milliseconds: 700);

  Map<String, dynamic>? _currentCashSession;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await Future<void>.delayed(_latency);

    switch (options.path) {
      case ApiEndpoints.login:
        return _handleLogin(options, handler);
      case ApiEndpoints.currentUser:
        return _handleCurrentUser(options, handler);
      case ApiEndpoints.currentCashSession:
        return _handleCurrentCashSession(options, handler);
      case ApiEndpoints.cashSessions:
        return _handleOpenCashSession(options, handler);
      case ApiEndpoints.orderTypes:
        return _handleOrderTypes(options, handler);
      case ApiEndpoints.products:
        return _handleProducts(options, handler);
      default:
        return handler.next(options);
    }
  }

  void _handleLogin(RequestOptions options, RequestInterceptorHandler handler) {
    final Object? requestData = options.data;
    final Map<String, dynamic> body = requestData is String
        ? jsonDecode(requestData) as Map<String, dynamic>
        : (requestData as Map<String, dynamic>?) ?? <String, dynamic>{};
    final String username = (body['identifier'] as String? ?? '').trim();
    final String password = body['password'] as String? ?? '';

    final bool isValid =
        username.toLowerCase() == demoUsername && password == demoPassword;

    if (!isValid) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: _errorResponse(
            options,
            401,
            'AUTH_INVALID_CREDENTIALS',
            'Username atau password salah.',
          ),
        ),
      );
    }

    handler.resolve(
      _response(options, 200, <String, dynamic>{
        'data': <String, dynamic>{
          'access_token': 'mock-token-dikasa',
          'refresh_token': 'mock-refresh-token-dikasa',
          'token_type': 'Bearer',
          'expires_in': 3600,
          'firebase_uid': 'user-1',
        },
      }),
    );
  }

  void _handleCurrentCashSession(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final Map<String, dynamic>? session = _currentCashSession;
    if (session == null) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: _errorResponse(
            options,
            404,
            'CASH_SESSION_NOT_FOUND',
            'Belum ada sesi kas aktif.',
          ),
        ),
      );
    }

    handler.resolve(
      _response(options, 200, <String, dynamic>{'data': session}),
    );
  }

  void _handleOpenCashSession(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final Object? requestData = options.data;
    final Map<String, dynamic> body = requestData is String
        ? jsonDecode(requestData) as Map<String, dynamic>
        : (requestData as Map<String, dynamic>?) ?? <String, dynamic>{};

    _currentCashSession = <String, dynamic>{
      'id': 'cash-session-1',
      'user_id': 'user-1',
      'outlet_id': 'warteg-bahari',
      'opening_cash': body['opening_cash'] as int? ?? 0,
      'opened_at': DateTime.utc(2026, 9, 14).toIso8601String(),
      'status': 'open',
    };

    handler.resolve(
      _response(options, 201, <String, dynamic>{'data': _currentCashSession}),
    );
  }

  void _handleOrderTypes(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    handler.resolve(
      _response(options, 200, <String, dynamic>{
        'data': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': 'order-type-dine-in',
            'code': 'dine_in',
            'name': 'Bebas Pilih Meja',
            'sort_order': 1,
            'is_active': true,
          },
          <String, dynamic>{
            'id': 'order-type-reservation',
            'code': 'reservation',
            'name': 'Pesan Meja',
            'sort_order': 2,
            'is_active': true,
          },
          <String, dynamic>{
            'id': 'order-type-takeaway',
            'code': 'takeaway',
            'name': 'Bawa Pulang',
            'sort_order': 3,
            'is_active': true,
          },
        ],
      }),
    );
  }

  void _handleCurrentUser(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    handler.resolve(
      _response(options, 200, <String, dynamic>{
        'data': <String, dynamic>{
          'id': 'user-1',
          'role_id': 'kasir',
          'outlet_id': 'warteg-bahari',
          'username': demoUsername,
          'phone_number': '081234567890',
          'first_name': 'Jane',
          'last_name': 'Doe',
          'is_active': true,
        },
      }),
    );
  }

  void _handleProducts(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final List<Map<String, dynamic>> products = _products.indexed
        .map((entry) {
          final int index = entry.$1;
          final Map<String, dynamic> product = entry.$2;
          final String category = product['category'] as String;
          final String group = product['group'] as String;

          return <String, dynamic>{
            'id': product['id'],
            'name': product['name'],
            'price': product['price'],
            'selling_price': product['price'],
            'stock_status': 'available',
            'description': '',
            'is_highlighted': product['is_highlighted'],
            'sort_order': index + 1,
            'is_active': true,
            'category': <String, dynamic>{
              'id': 'category-${category.toLowerCase().replaceAll(' ', '-')}',
              'name': category,
              'sort_order': index + 1,
              'is_active': true,
            },
            'product_type': switch (group) {
              'minuman' => 'drink',
              'tambahan' => 'additional',
              _ => 'food',
            },
            'variations': null,
          };
        })
        .toList(growable: false);

    handler.resolve(
      _response(options, 200, <String, dynamic>{
        'data': products,
        'meta': <String, dynamic>{
          'page': 1,
          'page_size': 100,
          'total': products.length,
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

  Response<dynamic> _errorResponse(
    RequestOptions options,
    int statusCode,
    String code,
    String message,
  ) {
    return _response(options, statusCode, <String, dynamic>{
      'error': <String, dynamic>{
        'code': code,
        'message': message,
        'details': <String, String>{},
      },
    });
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
