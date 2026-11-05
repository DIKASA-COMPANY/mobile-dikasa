import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Memuat environment tiruan untuk test.
///
/// `USE_MOCK_API=true` membuat MockApiInterceptor aktif, sehingga test
/// tidak pernah menyentuh jaringan sungguhan.
void loadTestEnv({bool useMockApi = true}) {
  dotenv.loadFromString(
    envString:
        'API_BASE_URL=https://api.dikasa.local/dikasa/v1\n'
        'USE_MOCK_API=$useMockApi',
  );
}
