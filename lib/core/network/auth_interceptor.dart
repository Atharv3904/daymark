import 'package:dio/dio.dart';

import 'package:daymark_tracking/core/storage/token_storage.dart';

/// Contract-ready authentication interceptor for Dio.
///
/// Kept dormant (`attachToken: false`) until the FastAPI authentication
/// header/token contract is confirmed. Never logs tokens or payloads.
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
      final String? token = await _tokenStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: Wire 401 refresh/revocation handling once backend refresh contract is confirmed.
    handler.next(err);
  }
}
