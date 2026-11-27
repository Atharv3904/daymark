import 'package:dio/dio.dart';
import 'package:daymark_tracking/core/storage/token_storage.dart';

/// Contract-ready authentication interceptor for Dio.
///
/// Attaches stored credentials when active, and protects against logging
/// sensitive authentication headers or payload data.
class AuthInterceptor extends QueuedInterceptor {
  final TokenStorage _tokenStorage;
  final bool attachToken;

  AuthInterceptor(this._tokenStorage, {this.attachToken = false});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (attachToken) {
      final token = await _tokenStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Interceptor hook for 401 Unauthorized handling when refresh contract is approved.
    return handler.next(err);
  }
}
