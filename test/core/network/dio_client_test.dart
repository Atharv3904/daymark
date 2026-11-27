import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:daymark_tracking/core/config/api_config.dart';
import 'package:daymark_tracking/core/errors/exceptions/app_exception.dart';
import 'package:daymark_tracking/core/network/dio_client.dart';
import 'package:daymark_tracking/core/storage/token_storage.dart';

class MockTokenStorage implements TokenStorage {
  String? token;

  @override
  Future<String?> getAccessToken() async => token;

  @override
  Future<String?> getRefreshToken() async => null;

  @override
  Future<void> saveTokens({required String accessToken, String? refreshToken}) async {
    token = accessToken;
  }

  @override
  Future<void> clearTokens() async {
    token = null;
  }
}

void main() {
  group('DioClient & Network Exception Mapping Tests', () {
    late MockTokenStorage tokenStorage;
    late ApiConfig config;
    late DioClient client;

    setUp(() {
      tokenStorage = MockTokenStorage();
      config = const ApiConfig(
        baseUrl: 'http://test-api.daymark.local',
        connectTimeoutMs: 10000,
      );
      client = DioClient(config: config, tokenStorage: tokenStorage);
    });

    test('DioClient initializes with expected options', () {
      expect(client.dio.options.baseUrl, 'http://test-api.daymark.local');
      expect(client.dio.options.connectTimeout, const Duration(milliseconds: 10000));
      expect(client.dio.options.headers['Content-Type'], 'application/json');
      expect(client.dio.options.headers['Accept'], 'application/json');
    });

    test('mapDioException maps connectionTimeout to NetworkException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
        message: 'Timeout exceeded',
      );

      final result = DioClient.mapDioException(dioException);
      expect(result, isA<NetworkException>());
    });

    test('mapDioException maps 401 to UnauthorizedException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
          data: {'detail': 'Invalid credentials'},
        ),
      );

      final result = DioClient.mapDioException(dioException);
      expect(result, isA<UnauthorizedException>());
      expect(result.message, 'Invalid credentials');
    });

    test('mapDioException maps 422 to ValidationException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 422,
          data: {'detail': 'Field missing'},
        ),
      );

      final result = DioClient.mapDioException(dioException);
      expect(result, isA<ValidationException>());
      expect(result.message, 'Field missing');
    });

    test('mapDioException maps 500 to ServerException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
        ),
      );

      final result = DioClient.mapDioException(dioException);
      expect(result, isA<ServerException>());
      expect(result.statusCode, 500);
    });
  });
}
