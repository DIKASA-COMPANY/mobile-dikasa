import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/services/product_service.dart';
import 'package:mobile_dikasa/data/models/product.dart';

void main() {
  setUp(
    () => dotenv.loadFromString(
      envString:
          'API_BASE_URL=http://localhost:8081/dikasa/v1\nUSE_MOCK_API=false',
    ),
  );

  test(
    'login sends backend identifier and loads profile with bearer token',
    () async {
      final client = ApiClient();
      final requests = <RequestOptions>[];
      client.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            requests.add(options);
            if (options.path == '/login') {
              handler.resolve(
                Response(
                  requestOptions: options,
                  statusCode: 200,
                  data: {
                    'data': {
                      'access_token': 'local-token',
                      'refresh_token': '',
                      'token_type': 'Bearer',
                      'expires_in': 3600,
                      'firebase_uid': 'user-uuid',
                    },
                  },
                ),
              );
            } else if (options.path == '/users/me') {
              handler.resolve(
                Response(
                  requestOptions: options,
                  statusCode: 200,
                  data: {
                    'data': {
                      'id': 'user-uuid',
                      'role_id': 'role-uuid',
                      'outlet_id': 'outlet-uuid',
                      'username': 'admin',
                      'phone_number': '080000000001',
                      'first_name': 'Local',
                      'last_name': 'Manager',
                      'is_active': true,
                    },
                  },
                ),
              );
            } else {
              handler.reject(
                DioException(
                  requestOptions: options,
                  type: DioExceptionType.badResponse,
                  response: Response(requestOptions: options, statusCode: 404),
                ),
              );
            }
          },
        ),
      );
      final repository = AuthRepository(
        authService: AuthService(client),
        apiClient: client,
      );
      final user = await repository.login(
        username: 'admin',
        password: 'dikasa123',
      );
      expect(user.id, 'user-uuid');
      expect(user.name, 'Local Manager');
      expect(requests.first.uri.path, '/dikasa/v1/login');
      expect(requests.first.data, {
        'identifier': 'admin',
        'password': 'dikasa123',
      });
      expect(requests.last.headers['Authorization'], 'Bearer local-token');
      expect(repository.isLoggedIn, isTrue);
    },
  );

  test(
    'catalog reads all backend pages and maps product groups and categories',
    () async {
      final client = ApiClient();
      client.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final page = options.queryParameters['page'] ?? 1;
            handler.resolve(
              Response(
                requestOptions: options,
                statusCode: 200,
                data: {
                  'data': [
                    {
                      'id': 'p$page',
                      'name': 'Es Teh',
                      'price': 5000,
                      'product_type': 'drink',
                      'category': {'id': 'c1', 'name': 'Minuman'},
                      'is_highlighted': false,
                      'stock_status': 'available',
                      'variations': [],
                    },
                  ],
                  'meta': {'page': page, 'page_size': 1, 'total': 2},
                },
              ),
            );
          },
        ),
      );
      final products = await ProductService(client).fetchProducts();
      expect(products.length, 2);
      expect(products.last.id, 'p2');
      expect(products.first.group, ProductGroup.minuman);
      expect(products.first.category, 'Minuman');
      expect(products.first.price, 5000);
    },
  );

  test('nested backend errors retain the useful message', () {
    final request = RequestOptions(path: '/login');
    final error = ApiException.fromDio(
      DioException(
        requestOptions: request,
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: request,
          statusCode: 403,
          data: {
            'error': {
              'code': 'AKUN_DINONAKTIFKAN',
              'message': 'Akun dinonaktifkan.',
            },
          },
        ),
      ),
    );
    expect(error.message, 'Akun dinonaktifkan.');
  });
}
