import 'package:dio/dio.dart';
import 'package:daymark_tracking/core/config/api_config.dart';
import 'package:daymark_tracking/core/errors/exceptions/app_exception.dart';
import 'package:daymark_tracking/core/network/auth_interceptor.dart';
import 'package:daymark_tracking/core/storage/token_storage.dart';

/// Centralized Dio network client.
///
/// Injected via GetIt into Remote Data Sources.
class DioClient {
  final Dio dio;

  DioClient({
    required ApiConfig config,
    required TokenStorage tokenStorage,
    Dio? customDio,
    bool attachToken = false,
  }) : dio = customDio ??
            Dio(
              BaseOptions(
                baseUrl: config.baseUrl,
                connectTimeout: Duration(milliseconds: config.connectTimeoutMs),
                receiveTimeout: Duration(milliseconds: config.receiveTimeoutMs),
                sendTimeout: Duration(milliseconds: config.sendTimeoutMs),
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            ) {
    dio.interceptors.add(
      AuthInterceptor(tokenStorage, attachToken: attachToken),
    );
  }

  /// Maps [DioException] into typed domain-layer [AppException].
  static AppException mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return NetworkException(
          'Network connection timeout or failed: ${error.message}',
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        String message = error.message ?? 'HTTP error $statusCode';

        if (data is Map && data.containsKey('detail')) {
          message = data['detail'].toString();
        }

        switch (statusCode) {
          case 400:
            return ValidationException(message, 400, data);
          case 401:
            return UnauthorizedException(message, 401);
          case 403:
            return ForbiddenException(message, 403);
          case 404:
            return NotFoundException(message, 404);
          case 409:
            return ConflictException(message, 409);
          case 422:
            return ValidationException(message, 422, data);
          case 429:
            return RateLimitException(message, 429);
          default:
            if (statusCode != null && statusCode >= 500) {
              return ServerException(message, statusCode);
            }
            return ValidationException(message, statusCode ?? 0, data);
        }
      case DioExceptionType.cancel:
        return const NetworkException('Request was cancelled');
      case DioExceptionType.badCertificate:
        return const NetworkException('Invalid SSL certificate');
      case DioExceptionType.unknown:
      default:
        return NetworkException(error.message ?? 'An unexpected network error occurred');
    }
  }
}
