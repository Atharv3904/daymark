import 'package:dio/dio.dart';

import 'package:daymark_tracking/core/config/api_config.dart';
import 'package:daymark_tracking/core/errors/exceptions/app_exception.dart';
import 'package:daymark_tracking/core/network/auth_interceptor.dart';
import 'package:daymark_tracking/core/storage/token_storage.dart';

/// Centralized Dio HTTP client configured for FastAPI REST communication.
class DioClient {
  final Dio dio;

  DioClient({
    required ApiConfig config,
    required TokenStorage tokenStorage,
    Dio? customDio,
    bool attachToken = false,
  }) : dio =
           customDio ??
           Dio(
             BaseOptions(
               baseUrl: config.baseUrl,
               connectTimeout: Duration(milliseconds: config.connectTimeoutMs),
               receiveTimeout: Duration(milliseconds: config.receiveTimeoutMs),
               sendTimeout: Duration(milliseconds: config.sendTimeoutMs),
               headers: const <String, String>{
                 'Content-Type': 'application/json',
                 'Accept': 'application/json',
               },
             ),
           ) {
    dio.interceptors.add(
      AuthInterceptor(tokenStorage, attachToken: attachToken),
    );
  }

  /// Maps low-level [DioException] errors into typed [AppException] instances.
  static AppException mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
        return NetworkException(error.message ?? 'Network connection failed');
      case DioExceptionType.badResponse:
        final int? statusCode = error.response?.statusCode;
        final dynamic data = error.response?.data;
        final String message = _extractErrorMessage(data, statusCode);

        switch (statusCode) {
          case 400:
          case 422:
            return ValidationException(message, statusCode, data);
          case 401:
            return UnauthorizedException(message, 401);
          case 403:
            return ForbiddenException(message, 403);
          case 404:
            return NotFoundException(message, 404);
          case 409:
            return ConflictException(message, 409);
          case 429:
            return RateLimitException(message, 429);
          default:
            if (statusCode != null && statusCode >= 500) {
              return ServerException(message, statusCode);
            }
            return ValidationException(message, statusCode ?? 0, data);
        }
      case DioExceptionType.unknown:
      default:
        return NetworkException(
          error.message ?? 'An unexpected network error occurred',
        );
    }
  }

  static String _extractErrorMessage(dynamic data, int? statusCode) {
    if (data is Map) {
      if (data['message'] is String && (data['message'] as String).isNotEmpty) {
        return data['message'] as String;
      }
      final dynamic detail = data['detail'];
      if (detail is String && detail.isNotEmpty) {
        return detail;
      }
      if (detail is List && detail.isNotEmpty) {
        final dynamic first = detail.first;
        if (first is Map && first['msg'] is String) {
          return first['msg'] as String;
        }
      }
    }
    return 'Request failed with status $statusCode';
  }
}
