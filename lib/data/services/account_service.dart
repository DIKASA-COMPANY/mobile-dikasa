import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../models/account_profile.dart';

/// A credential command may have committed; it must never be retried automatically.
class CredentialOutcomeUncertainException implements Exception {}

class AccountService {
  AccountService(this.client);
  final ApiClient client;
  Map<String, dynamic> _data(Response<dynamic> r) =>
      Map<String, dynamic>.from((r.data as Map)['data'] as Map);
  Future<T> _read<T>(Future<T> Function() f) async {
    try {
      return await f();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    } on TypeError {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format profil dari server tidak sesuai.',
      );
    } on FormatException {
      throw const ApiException(
        type: ApiErrorType.parsing,
        message: 'Format profil dari server tidak sesuai.',
      );
    }
  }

  Future<AccountProfile> profile() => _read(
    () async => AccountProfile.fromJson(
      _data(await client.dio.get<dynamic>('/users/me')),
    ),
  );
  Future<List<GenderOption>> genders() => _read(
    () async =>
        ((await client.dio.get<dynamic>('/users/me/genders')).data['data']
                as List)
            .map(
              (e) => GenderOption.fromJson(Map<String, dynamic>.from(e as Map)),
            )
            .toList(),
  );
  Future<AccountProfile> updateProfile(
    Map<String, String> fields, {
    Uint8List? avatarBytes,
    String? avatarFilename,
  }) => _read(() async {
    final data = FormData.fromMap(fields);
    if (avatarBytes != null) {
      final name = avatarFilename ?? 'avatar.png';
      data.files.add(
        MapEntry(
          'avatar',
          MultipartFile.fromBytes(
            avatarBytes,
            filename: name,
            contentType: DioMediaType(
              'image',
              name.toLowerCase().endsWith('.png') ? 'png' : 'jpeg',
            ),
          ),
        ),
      );
    }
    return AccountProfile.fromJson(
      _data(await client.dio.patch<dynamic>('/users/me', data: data)),
    );
  });
  Future<void> _credential(String path, Map<String, String> data) async {
    try {
      final r = await client.dio.patch<dynamic>(path, data: data);
      if (r.statusCode != 204) {
        throw CredentialOutcomeUncertainException();
      }
    } on DioException catch (e) {
      if (e.response == null || (e.response!.statusCode ?? 500) >= 500) {
        throw CredentialOutcomeUncertainException();
      }
      throw ApiException.fromDio(e);
    }
  }

  Future<void> changePIN(String current, String next, String confirmation) =>
      _credential('/users/me/pin', {
        if (current.isNotEmpty) 'current_pin': current,
        'new_pin': next,
        'new_pin_confirmation': confirmation,
      });
  Future<void> changePassword(
    String current,
    String next,
    String confirmation,
  ) => _credential('/users/me/password', {
    'current_password': current,
    'new_password': next,
    'new_password_confirmation': confirmation,
  });
}
