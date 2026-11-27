import 'package:flutter_test/flutter_test.dart';
import 'package:daymark_tracking/core/storage/token_storage.dart';

class FakeTokenStorage implements TokenStorage {
  String? _accessToken;
  String? _refreshToken;

  @override
  Future<void> saveTokens({required String accessToken, String? refreshToken}) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  @override
  Future<String?> getAccessToken() async => _accessToken;

  @override
  Future<String?> getRefreshToken() async => _refreshToken;

  @override
  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
  }
}

void main() {
  group('TokenStorage Tests', () {
    late TokenStorage storage;

    setUp(() {
      storage = FakeTokenStorage();
    });

    test('saves and retrieves tokens correctly', () async {
      await storage.saveTokens(
        accessToken: 'mock_access_token',
        refreshToken: 'mock_refresh_token',
      );

      expect(await storage.getAccessToken(), 'mock_access_token');
      expect(await storage.getRefreshToken(), 'mock_refresh_token');
    });

    test('clears tokens properly', () async {
      await storage.saveTokens(accessToken: 'token_to_clear');
      expect(await storage.getAccessToken(), 'token_to_clear');

      await storage.clearTokens();
      expect(await storage.getAccessToken(), isNull);
      expect(await storage.getRefreshToken(), isNull);
    });
  });
}
