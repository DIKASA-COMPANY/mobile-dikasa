import 'dart:convert';
import 'package:dio/dio.dart';

/// In-memory account fixture; never used when USE_MOCK_API is false.
class MockAccount {
  String password = 'dikasa123', pin = '';
  final profile = <String, dynamic>{
    'id': '1',
    'username': 'admin',
    'first_name': 'Jane',
    'last_name': 'Doe',
    'phone_number': '08123456789',
    'email': 'jane@example.com',
    'role': 'Kasir',
    'outlet_name': 'Warteg Bahari',
    'has_pin': false,
    'can_change_password': true,
    'date_of_birth': null,
    'gender_id': null,
    'personal_address': null,
  };
  Future<bool> handle(RequestOptions o, RequestInterceptorHandler h) async {
    if (!o.path.startsWith('/users/me')) return false;
    void reply(int code, dynamic body) {
      final r = Response<dynamic>(
        requestOptions: o,
        statusCode: code,
        data: body,
      );
      if (code >= 400) {
        h.reject(
          DioException(
            requestOptions: o,
            type: DioExceptionType.badResponse,
            response: r,
          ),
        );
      } else {
        h.resolve(r);
      }
    }

    void reject() => reply(422, {
      'error': {'message': 'Data atau kredensial lama tidak valid.'},
    });
    if (o.path == '/users/me/genders') {
      reply(200, {
        'data': [
          {'id': 'male', 'name': 'Pria'},
          {'id': 'female', 'name': 'Wanita'},
        ],
      });
      return true;
    }
    if (o.method == 'GET') {
      reply(200, {'data': Map<String, dynamic>.from(profile)});
      return true;
    }
    if (o.path == '/users/me') {
      final f = o.data as FormData;
      for (final e in f.fields) {
        if (profile.containsKey(e.key) &&
            ![
              'id',
              'role',
              'outlet_name',
              'username',
              'has_pin',
              'can_change_password',
            ].contains(e.key)) {
          profile[e.key] = e.value.isEmpty ? null : e.value;
        }
        if (e.key == 'remove_avatar' && e.value == 'true') {
          profile['avatar_url'] = null;
        }
      }
      for (final entry in f.files) {
        if (entry.key == 'avatar') {
          final file = entry.value;
          final bytes = await file.finalize().fold<List<int>>(
            [],
            (a, b) => a..addAll(b),
          );
          profile['avatar_url'] =
              'data:${file.contentType};base64,${base64Encode(bytes)}';
        }
      }
      reply(200, {'data': Map<String, dynamic>.from(profile)});
      return true;
    }
    final data = Map<String, dynamic>.from(o.data as Map);
    final isPIN = o.path.endsWith('/pin');
    final old = isPIN ? pin : password;
    final next = data[isPIN ? 'new_pin' : 'new_password'] as String? ?? '';
    final current = data[isPIN ? 'current_pin' : 'current_password'];
    if ((old.isNotEmpty && current != old) ||
        next == old ||
        data[isPIN ? 'new_pin_confirmation' : 'new_password_confirmation'] !=
            next ||
        (isPIN
            ? !RegExp(r'^[0-9]{6}$').hasMatch(next)
            : utf8.encode(next).length < 8 || utf8.encode(next).length > 72)) {
      reject();
      return true;
    }
    if (isPIN) {
      pin = next;
      profile['has_pin'] = true;
    } else {
      password = next;
    }
    reply(204, null);
    return true;
  }
}
