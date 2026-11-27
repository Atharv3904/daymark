import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:daymark_tracking/core/config/api_config.dart';
import 'package:daymark_tracking/core/errors/exceptions/app_exception.dart';
import 'package:daymark_tracking/core/network/dio_client.dart';
import 'package:daymark_tracking/core/storage/token_storage.dart';

class _FakeTokenStorage implements TokenStorage {
  @override
  Future<void> clearTokens() async {}

  @override
  Future<String?> getAccessToken() async => null;

  @override
  Future<String?> getRefreshToken() async => null;

  @override
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {}
}

void main() {
  group('DioClient', () {
    test('initializes BaseOptions from ApiConfig', () {
      const ApiConfig config = ApiConfig(
        baseUrl: 'http://localhost:8000',
        connectTimeoutMs: 10000,
      );
      final DioClient client = DioClient(
        config: config,
        tokenStorage: _FakeTokenStorage(),
      );

      expect(client.dio.options.baseUrl, 'http://localhost:8000');
      expect(
        client.dio.options.connectTimeout,
        const Duration(milliseconds: 10000),
      );
      expect(client.dio.options.headers['Content-Type'], 'application/json');
    });

    test('mapDioException maps timeouts to NetworkException', () {
      final DioException err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );

      expect(DioClient.mapDioException(err), isA<NetworkException>());
    });

    test('mapDioException maps 401 to UnauthorizedException', () {
      final RequestOptions req = RequestOptions(path: '/test');
      final DioException err = DioException(
        requestOptions: req,
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: req,
          statusCode: 401,
          data: <String, dynamic>{'detail': 'Invalid credentials'},
        ),
      );

      final AppException mapped = DioClient.mapDioException(err);
      expect(mapped, isA<UnauthorizedException>());
      expect(mapped.message, 'Invalid credentials');
    });

    test('mapDioException extracts FastAPI 422 detail list message', () {
      final RequestOptions req = RequestOptions(path: '/test');
      final DioException err = DioException(
        requestOptions: req,
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: req,
          statusCode: 422,
          data: <String, dynamic>{
            'detail': <Map<String, dynamic>>[
              <String, dynamic>{'msg': 'value is not a valid email address'},
            ],
          },
        ),
      );

      final AppException mapped = DioClient.mapDioException(err);
      expect(mapped, isA<ValidationException>());
      expect(mapped.message, 'value is not a valid email address');
    });

    test('mapDioException maps 500 to ServerException', () {
      final RequestOptions req = RequestOptions(path: '/test');
      final DioException err = DioException(
        requestOptions: req,
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(requestOptions: req, statusCode: 500),
      );

      expect(DioClient.mapDioException(err), isA<ServerException>());
    });
  });
}
