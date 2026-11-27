// lib/features/authethication/data/datasource/auth_remote_datasource_impl.dart
//
// Concrete implementation of the unified authentication remote data source.
// All FastAPI REST API calls for authentication are centralised here.

import 'package:dio/dio.dart';
import 'package:daymark_tracking/core/network/dio_client.dart';

import 'auth_remote_datasource.dart';

/// REST implementation of [AuthRemoteDataSource].
///
/// Communicates with the FastAPI backend via [DioClient].
/// [DioException] errors are mapped to typed [AppException] by
/// [DioClient.mapDioException] and rethrown for the repository to handle.
///
/// TODO: Update endpoint paths when FastAPI API documentation is available.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;

  AuthRemoteDataSourceImpl(this._client);

  // TODO: Confirm endpoint paths with FastAPI backend documentation.
  static const String _registerPath = '/api/v1/auth/register';
  static const String _loginPath = '/api/v1/auth/login';
  static const String _forgotPasswordPath = '/api/v1/auth/forgot-password';
  static const String _resetPasswordPath = '/api/v1/auth/reset-password';
  static const String _signOutPath = '/api/v1/auth/sign-out';

  @override
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
  }) async {
    try {
      final Response<dynamic> response = await _client.dio.post(
        _registerPath,
        data: <String, dynamic>{'email': email, 'password': password},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw DioClient.mapDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final Response<dynamic> response = await _client.dio.post(
        _loginPath,
        data: <String, dynamic>{'email': email, 'password': password},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw DioClient.mapDioException(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _client.dio.post(
        _forgotPasswordPath,
        data: <String, dynamic>{'email': email},
      );
    } on DioException catch (e) {
      throw DioClient.mapDioException(e);
    }
  }

  @override
  Future<void> resetPassword({
    required String newPassword,
    required String token,
  }) async {
    try {
      await _client.dio.post(
        _resetPasswordPath,
        data: <String, dynamic>{'new_password': newPassword, 'token': token},
      );
    } on DioException catch (e) {
      throw DioClient.mapDioException(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.dio.post(_signOutPath);
    } on DioException catch (e) {
      throw DioClient.mapDioException(e);
    }
  }
}
