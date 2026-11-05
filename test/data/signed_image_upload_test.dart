import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/core/network/api_exception.dart';
import 'package:mobile_dikasa/data/services/image_upload_service.dart';
import 'package:mobile_dikasa/data/services/account_service.dart';
import 'package:mobile_dikasa/data/services/catalog_service.dart';
import 'package:mobile_dikasa/data/services/cash_movement_service.dart';
import 'package:mobile_dikasa/data/models/catalog_product.dart';
import 'package:mobile_dikasa/data/models/cash_movement.dart';

class _StorageAdapter implements HttpClientAdapter {
  List<int>? body;
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    expect(options.headers.containsKey('Authorization'), isFalse);
    expect(options.contentType, 'image/png');
    body = await requestStream!.fold<List<int>>(
      [],
      (bytes, chunk) => bytes..addAll(chunk),
    );
    return ResponseBody.fromString('', 200);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  setUp(
    () => dotenv.loadFromString(
      envString:
          'API_BASE_URL=https://api.example/dikasa/v1\nUSE_MOCK_API=false',
    ),
  );

  for (final kind in ['avatar', 'product', 'proof']) {
    test(
      '$kind uploads raw bytes without bearer and returns object name',
      () async {
        final storage = Dio();
        final client = ApiClient(storageDio: storage);
        client.updateAuthToken('private-access-token');
        final bytes = Uint8List.fromList([137, 80, 78, 71]);
        var uploaded = false;
        client.dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (o, h) {
              expect(o.headers['Authorization'], 'Bearer private-access-token');
              final body = jsonDecode(o.data as String) as Map;
              expect(body['content_type'], 'image/png');
              expect(body['size'], bytes.length);
              if (kind == 'proof') expect(body['request_id'], 'request');
              expect(o.path, switch (kind) {
                'avatar' => '/users/me/avatar-upload-intents',
                'product' => '/products/image-upload-intents',
                _ => '/cash-sessions/session/movement-proof-upload-intents',
              });
              h.resolve(
                Response(
                  requestOptions: o,
                  statusCode: 200,
                  data: {
                    'data': {
                      'upload_url':
                          'https://storage.example/upload/signed?token=secret',
                      'object_name': 'images/object.png',
                      'expires_in': 7200,
                    },
                  },
                ),
              );
            },
          ),
        );
        storage.interceptors.add(
          InterceptorsWrapper(
            onRequest: (o, h) {
              expect(o.method, 'PUT');
              expect(o.uri.host, 'storage.example');
              expect(o.headers.containsKey('Authorization'), isFalse);
              expect(o.headers['Content-Type'] ?? o.contentType, 'image/png');
              expect(o.data, bytes);
              expect(o.followRedirects, isFalse);
              uploaded = true;
              h.resolve(Response(requestOptions: o, statusCode: 200));
            },
          ),
        );
        final uploader = ImageUploadService(client);
        final object = await switch (kind) {
          'avatar' => uploader.avatar(bytes, 'photo.png'),
          'product' => uploader.product(bytes, 'image/png'),
          _ => uploader.cashProof('session', 'request', bytes, 'proof.png'),
        };
        expect(uploaded, isTrue);
        expect(object, 'images/object.png');
      },
    );
  }

  test(
    'failed storage upload surfaces an error without returning an object',
    () async {
      final storage = Dio();
      final client = ApiClient(storageDio: storage);
      client.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (o, h) => h.resolve(
            Response(
              requestOptions: o,
              statusCode: 200,
              data: {
                'data': {
                  'upload_url': 'https://storage.example/signed',
                  'object_name': 'image.png',
                  'expires_in': 7200,
                },
              },
            ),
          ),
        ),
      );
      storage.interceptors.add(
        InterceptorsWrapper(
          onRequest: (o, h) => h.reject(
            DioException(
              requestOptions: o,
              type: DioExceptionType.connectionError,
            ),
          ),
        ),
      );
      await expectLater(
        ImageUploadService(client).avatar(Uint8List.fromList([1]), 'p.png'),
        throwsA(isA<ApiException>()),
      );
    },
  );
  test('logout during upload prevents adopting a completed object', () async {
    final storage = Dio();
    final client = ApiClient(storageDio: storage);
    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (o, h) => h.resolve(
          Response(
            requestOptions: o,
            statusCode: 200,
            data: {
              'data': {
                'upload_url': 'https://storage.example/signed',
                'object_name': 'image.png',
                'expires_in': 7200,
              },
            },
          ),
        ),
      ),
    );
    storage.interceptors.add(
      InterceptorsWrapper(
        onRequest: (o, h) {
          client.updateAuthToken(null);
          h.resolve(Response(requestOptions: o, statusCode: 200));
        },
      ),
    );
    await expectLater(
      ImageUploadService(client).avatar(Uint8List.fromList([1]), 'p.png'),
      throwsA(isA<ApiException>()),
    );
  });

  test('missing intent response is a user-facing error', () async {
    final client = ApiClient();
    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (o, h) =>
            h.resolve(Response(requestOptions: o, statusCode: 200)),
      ),
    );
    await expectLater(
      ImageUploadService(client).avatar(Uint8List.fromList([1]), 'p.png'),
      throwsA(isA<ApiException>()),
    );
  });
  for (final kind in ['avatar', 'product', 'proof']) {
    test('$kind failed upload never submits its mutation', () async {
      final storage = Dio();
      final client = ApiClient(storageDio: storage);
      var requests = 0;
      client.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (o, h) {
            requests++;
            expect(o.path.endsWith('upload-intents'), isTrue);
            h.resolve(
              Response(
                requestOptions: o,
                statusCode: 200,
                data: {
                  'data': {
                    'upload_url': 'https://storage.example/signed',
                    'object_name': 'image.png',
                    'expires_in': 7200,
                  },
                },
              ),
            );
          },
        ),
      );
      storage.interceptors.add(
        InterceptorsWrapper(
          onRequest: (o, h) => h.reject(
            DioException(
              requestOptions: o,
              type: DioExceptionType.connectionError,
            ),
          ),
        ),
      );
      final bytes = Uint8List.fromList([1]);
      final operation = switch (kind) {
        'avatar' => AccountService(
          client,
        ).updateProfile({}, avatarBytes: bytes, avatarFilename: 'p.png'),
        'product' => CatalogService(client).saveProduct(
          CatalogProduct(
            name: 'P',
            category: const CatalogCategory(id: 'c', name: 'C'),
            productType: 'food',
            price: 1,
            image: CatalogImage(
              name: 'p.png',
              bytes: bytes,
              mimeType: 'image/png',
            ),
          ),
        ),
        _ => CashMovementService(client).create(
          'session',
          PendingCashMovement(
            sessionId: 'session',
            requestId: 'request',
            kind: 'in',
            name: 'N',
            amount: 1,
            reason: 'R',
            proofBytes: bytes,
          ),
        ),
      };
      await expectLater(operation, throwsA(isA<ApiException>()));
      expect(requests, 1);
    });
  }
  test('Storage transport sends the original byte stream', () async {
    final storage = Dio();
    final adapter = _StorageAdapter();
    storage.httpClientAdapter = adapter;
    final client = ApiClient(storageDio: storage);
    client.updateAuthToken('private-token');
    client.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (o, h) => h.resolve(
          Response(
            requestOptions: o,
            statusCode: 200,
            data: {
              'data': {
                'upload_url': 'https://storage.example/signed',
                'object_name': 'image.png',
                'expires_in': 7200,
              },
            },
          ),
        ),
      ),
    );
    await ImageUploadService(
      client,
    ).avatar(Uint8List.fromList([137, 80, 78, 71]), 'p.png');
    expect(adapter.body, [137, 80, 78, 71]);
  });
}
