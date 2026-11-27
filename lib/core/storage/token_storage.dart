import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Abstract contract for secure token and session storage.
///
/// Feature and infrastructure layers depend on this abstraction rather than
/// accessing platform-specific storage APIs directly.
abstract class TokenStorage {
  Future<void> saveTokens({required String accessToken, String? refreshToken});
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
}

/// Concrete implementation of [TokenStorage] backed by [FlutterSecureStorage].
///
/// Stores encrypted credentials in the Android Keystore and iOS Keychain.
class SecureTokenStorageImpl implements TokenStorage {
  final FlutterSecureStorage _storage;

  static const String _accessTokenKey = 'daymark_access_token';
  static const String _refreshTokenKey = 'daymark_refresh_token';

  SecureTokenStorageImpl([FlutterSecureStorage? storage])
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
              iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
            );

  @override
  Future<void> saveTokens({required String accessToken, String? refreshToken}) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  @override
  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
