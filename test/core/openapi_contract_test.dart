import 'package:dikasa_api/dikasa_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('kontrak Supabase', () {
    test('login memakai supabase_user_id', () {
      final LoginResponseData data =
          LoginResponseData.fromJson(<String, dynamic>{
            'access_token': 'access-token',
            'refresh_token': 'refresh-token',
            'token_type': 'Bearer',
            'expires_in': 3600,
            'supabase_user_id': 'user-id',
          });

      expect(data.supabaseUserId, 'user-id');
    });

    test('presign URL avatar memuat object dan masa berlaku', () {
      final AvatarUploadIntentData data = AvatarUploadIntentData.fromJson(
        _uploadIntentJson('avatars/user-id/avatar.jpg'),
      );

      expect(data.uploadUrl, startsWith('https://storage.example/'));
      expect(data.objectName, 'avatars/user-id/avatar.jpg');
      expect(data.expiresIn, 7200);
    });

    test('presign URL produk memuat object dan masa berlaku', () {
      final ProductImageUploadIntentData data =
          ProductImageUploadIntentData.fromJson(
            _uploadIntentJson('products/outlet-id/product.jpg'),
          );

      expect(data.objectName, 'products/outlet-id/product.jpg');
      expect(data.expiresIn, 7200);
    });

    test('presign URL bukti kas memuat object dan masa berlaku', () {
      final ProofUploadIntentData data = ProofUploadIntentData.fromJson(
        _uploadIntentJson('cash-proofs/session-id/proof.jpg'),
      );

      expect(data.objectName, 'cash-proofs/session-id/proof.jpg');
      expect(data.expiresIn, 7200);
    });
  });
}

Map<String, dynamic> _uploadIntentJson(String objectName) => <String, dynamic>{
  'upload_url': 'https://storage.example/upload-token',
  'object_name': objectName,
  'expires_in': 7200,
};
