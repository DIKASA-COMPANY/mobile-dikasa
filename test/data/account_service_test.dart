import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_dikasa/core/network/api_client.dart';
import 'package:mobile_dikasa/data/services/account_service.dart';
import 'package:mobile_dikasa/data/repositories/auth_repository.dart';
import 'package:mobile_dikasa/data/services/auth_service.dart';
import 'package:mobile_dikasa/data/models/user.dart';

void main() {
  setUp(
    () => dotenv.loadFromString(
      envString: 'API_BASE_URL=http://localhost/dikasa/v1\nUSE_MOCK_API=false',
    ),
  );
  test(
    'account multipart clearing and uncertain credential changes never retry',
    () async {
      final c = ApiClient();
      var calls = 0;
      c.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (o, h) {
            calls++;
            if (o.path.endsWith('/password')) {
              h.reject(
                DioException(
                  requestOptions: o,
                  type: DioExceptionType.receiveTimeout,
                ),
              );
              return;
            }
            expect(o.data, isA<FormData>());
            expect(Map.fromEntries((o.data as FormData).fields)['email'], '');
            h.resolve(
              Response(
                requestOptions: o,
                statusCode: 200,
                data: {
                  'data': {
                    'id': 'a',
                    'first_name': 'Jane',
                    'has_pin': false,
                    'can_change_password': true,
                  },
                },
              ),
            );
          },
        ),
      );
      final s = AccountService(c);
      final p = await s.updateProfile({'email': ''});
      expect(p.user.name, 'Jane');
      await expectLater(
        s.changePassword('oldpassword', 'newpassword', 'newpassword'),
        throwsA(isA<CredentialOutcomeUncertainException>()),
      );
      expect(calls, 2);
    },
  );
  test('session generation rejects a late update after logout', () async {
    final c = ApiClient();
    final r = AuthRepository(authService: AuthService(c), apiClient: c);
    final g = r.sessionGeneration;
    r.logout();
    expect(r.sessionGeneration, greaterThan(g));
    expect(
      r.replaceUser(
        const User(
          id: 'a',
          name: 'A',
          username: 'a',
          role: 'cashier',
          outletName: 'Shop',
        ),
        expectedGeneration: g,
      ),
      isFalse,
    );
  });
  test(
    'malformed profile is rejected instead of becoming null account',
    () async {
      final c = ApiClient();
      c.dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (o, h) => h.resolve(
            Response(requestOptions: o, statusCode: 200, data: {'data': {}}),
          ),
        ),
      );
      await expectLater(AccountService(c).profile(), throwsA(isA<Exception>()));
    },
  );

  test('late login cannot restore bearer token after logout', () async {
    final c = ApiClient();
    final pending = Completer<void>();
    c.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (o, h) async {
          if (o.path == '/login') {
            await pending.future;
            h.resolve(
              Response(
                requestOptions: o,
                statusCode: 200,
                data: {
                  'data': {'access_token': 'old-token'},
                },
              ),
            );
          } else if (o.path == '/users/me') {
            h.resolve(
              Response(
                requestOptions: o,
                statusCode: 200,
                data: {
                  'data': {'id': 'a', 'first_name': 'A'},
                },
              ),
            );
          } else {
            expect(o.headers['Authorization'], isNull);
            h.resolve(Response(requestOptions: o, statusCode: 200, data: {}));
          }
        },
      ),
    );
    final r = AuthRepository(authService: AuthService(c), apiClient: c);
    final login = r.login(username: 'a', password: 'password');
    final failure = expectLater(login, throwsStateError);
    r.logout();
    pending.complete();
    await failure;
    await c.dio.get<dynamic>('/probe');
  });

  test('mock avatar survives save and can be removed', () async {
    dotenv.loadFromString(
      envString: 'API_BASE_URL=http://localhost/dikasa/v1\nUSE_MOCK_API=true',
    );
    final s = AccountService(ApiClient());
    final bytes = base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+j7mQAAAAASUVORK5CYII=',
    );
    final p = await s.updateProfile(
      {},
      avatarBytes: bytes,
      avatarFilename: 'avatar.png',
    );
    expect(p.avatarUrl, startsWith('data:image/png;base64,'));
    expect((await s.profile()).avatarUrl, p.avatarUrl);
    expect(
      (await s.updateProfile({'remove_avatar': 'true'})).avatarUrl,
      isNull,
    );
  });
  test('initial PIN setup omits the optional current PIN field', () async {
    final c = ApiClient();
    c.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (o, h) {
          expect((o.data as Map).containsKey('current_pin'), isFalse);
          expect(o.data['new_pin'], '012345');
          h.resolve(Response(requestOptions: o, statusCode: 204));
        },
      ),
    );
    await AccountService(c).changePIN('', '012345', '012345');
  });
}
