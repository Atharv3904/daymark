import 'package:flutter_test/flutter_test.dart';

import 'package:daymark_tracking/core/storage/token_storage.dart';

class _InMemoryTokenStorage implements TokenStorage {
  String? _access;
  String? _refresh;

  @override
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    _access = accessToken;
    _refresh = refreshToken;
  }

  @override
  Future<String?> getAccessToken() async => _access;

  @override
  Future<String?> getRefreshToken() async => _refresh;

  @override
  Future<void> clearTokens() async {
    _access = null;
    _refresh = null;
  }
}

void main() {
  late TokenStorage storage;

  setUp(() {
    storage = _InMemoryTokenStorage();
  });

  test('saves, reads, and clears tokens', () async {
    await storage.saveTokens(
      accessToken: 'access-123',
      refreshToken: 'refresh-456',
    );
    expect(await storage.getAccessToken(), 'access-123');
    expect(await storage.getRefreshToken(), 'refresh-456');

    await storage.clearTokens();
    expect(await storage.getAccessToken(), isNull);
    expect(await storage.getRefreshToken(), isNull);
  });
}
