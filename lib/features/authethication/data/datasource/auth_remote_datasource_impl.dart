import 'package:dio/dio.dart';

import 'package:daymark_tracking/core/errors/exceptions/app_exception.dart';
import 'package:daymark_tracking/core/network/dio_client.dart';
import 'package:daymark_tracking/features/authethication/data/datasource/auth_remote_datasource.dart';
import 'package:daymark_tracking/features/authethication/data/model/auth_models.dart';

/// Contract-ready REST implementation of [AuthRemoteDataSource].
///
/// Communicates with FastAPI exclusively via [DioClient] and maps errors
/// to [AppAuthException] subtypes per `authethications/spec.md` Section 6.
///
/// TODO: Confirm all endpoint paths, payloads, and error codes against the
/// implemented FastAPI OpenAPI specification before production integration.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;

  AuthRemoteDataSourceImpl(this._client);

  // TODO: Replace placeholder paths when FastAPI auth routes are finalized.
  static const String _registerPath = '/api/v1/auth/register';
  static const String _loginPath = '/api/v1/auth/login';
  static const String _forgotPasswordPath = '/api/v1/auth/forgot-password';
  static const String _resetPasswordPath = '/api/v1/auth/reset-password';
  static const String _verifyEmailPath = '/api/v1/auth/verify-email';
  static const String _signOutPath = '/api/v1/auth/logout';

  @override
  Future<AuthSessionModel> register(RegistrationRequestModel model) async {
    try {
      final Response<dynamic> response = await _client.dio.post(
        _registerPath,
        data: model.toJson(),
      );
      return _parseSession(response.data);
    } on DioException catch (e) {
      throw _mapToAuthException(DioClient.mapDioException(e));
    }
  }

  @override
  Future<AuthSessionModel> login(LoginRequestModel model) async {
    try {
      final Response<dynamic> response = await _client.dio.post(
        _loginPath,
        data: model.toJson(),
      );
      return _parseSession(response.data);
    } on DioException catch (e) {
      throw _mapToAuthException(DioClient.mapDioException(e));
    }
  }

  @override
  Future<void> sendPasswordResetEmail(ForgotPasswordRequestModel model) async {
    try {
      await _client.dio.post(_forgotPasswordPath, data: model.toJson());
    } on DioException catch (e) {
      throw _mapToAuthException(DioClient.mapDioException(e));
    }
  }

  @override
  Future<void> resetPassword(ResetPasswordRequestModel model) async {
    try {
      await _client.dio.post(_resetPasswordPath, data: model.toJson());
    } on DioException catch (e) {
      throw _mapToAuthException(DioClient.mapDioException(e));
    }
  }

  @override
  Future<AuthSessionModel> verifyEmail(VerifyEmailRequestModel model) async {
    try {
      final Response<dynamic> response = await _client.dio.post(
        _verifyEmailPath,
        data: model.toJson(),
      );
      return _parseSession(response.data);
    } on DioException catch (e) {
      throw _mapToAuthException(DioClient.mapDioException(e));
    }
  }

  @override
  Future<void> signOut({bool global = false}) async {
    try {
      await _client.dio.post(
        _signOutPath,
        data: <String, dynamic>{'global': global},
      );
    } on DioException catch (e) {
      throw _mapToAuthException(DioClient.mapDioException(e));
    }
  }

  AuthSessionModel _parseSession(dynamic data) {
    if (data is Map<String, dynamic>) {
      return AuthSessionModel.fromJson(data);
    }
    throw const AppUnknownAuthException('Unexpected authentication response.');
  }

  AppException _mapToAuthException(AppException error) {
    if (error is NetworkException) {
      return AppNetworkException(error.message);
    }
    if (error is ConflictException) {
      return AppUserAlreadyExistsException(error.message);
    }
    if (error is UnauthorizedException) {
      return AppInvalidCredentialsException(error.message);
    }
    if (error is ForbiddenException) {
      final String msg = error.message.toLowerCase();
      if (msg.contains('verif')) {
        return AppEmailNotVerifiedException(error.message);
      }
      return AppUnknownAuthException(error.message, error.statusCode);
    }
    if (error is ValidationException) {
      final String msg = error.message.toLowerCase();
      if (msg.contains('weak')) {
        return AppWeakPasswordException(error.message);
      }
      return AppUnknownAuthException(error.message, error.statusCode);
    }
    if (error is RateLimitException) {
      return error;
    }
    return AppUnknownAuthException(error.message, error.statusCode);
  }
}
