// lib/features/authethication/data/repository/auth_repository_impl.dart
//
// Concrete implementation of the unified authentication repository.
// Uses [AuthRemoteDataSource] for all REST API operations and maps
// [AppException] types to domain-level [AppFailure] types.
//
// Error mapping follows CUSTOM_EXCEPTIONS_SPEC.md and BOUNDARY_CONDITIONS_SPEC.md.

import 'package:dartz/dartz.dart';
import 'package:daymark_tracking/core/errors/exceptions/app_exception.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/core/storage/token_storage.dart';
import 'package:daymark_tracking/features/authethication/data/datasource/auth_remote_datasource.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/forgot_password_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/login_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/registration_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/reset_password_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._dataSource, this._tokenStorage);

  // ---------------------------------------------------------------------------
  // Registration
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppFailure, void>> register(RegistrationEntity entity) async {
    try {
      await _dataSource.register(
        email: entity.email,
        password: entity.password,
      );

      // TODO: When backend contract is confirmed, check response for
      // email-verification status. If verification is required, return
      // Left(EmailVerificationPendingFailure()) instead.
      return const Right(null);
    } on AppException catch (e) {
      return Left(_mapRegistrationException(e));
    } catch (_) {
      return const Left(NetworkFailure());
    }
  }

  AppFailure _mapRegistrationException(AppException e) {
    if (e is ConflictException) {
      return const UserAlreadyExistsFailure();
    }
    if (e is ValidationException) {
      final String msg = e.message.toLowerCase();
      if (msg.contains('weak password')) {
        return const WeakPasswordFailure();
      }
      return UnknownAuthFailure(message: e.message);
    }
    if (e is RateLimitException) {
      return RateLimitFailure(message: e.message);
    }
    if (e is NetworkException) {
      return const NetworkFailure();
    }
    return UnknownAuthFailure(message: e.message);
  }

  // ---------------------------------------------------------------------------
  // Login
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppFailure, void>> login(LoginEntity entity) async {
    try {
      final Map<String, dynamic> response = await _dataSource.login(
        email: entity.email,
        password: entity.password,
      );

      // Persist tokens returned by the backend.
      // TODO: Confirm token field names with backend contract.
      final String? accessToken = response['access_token'] as String?;
      final String? refreshToken = response['refresh_token'] as String?;

      if (accessToken != null && accessToken.isNotEmpty) {
        await _tokenStorage.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      }

      return const Right(null);
    } on AppException catch (e) {
      return Left(_mapLoginException(e));
    } catch (_) {
      return const Left(NetworkFailure());
    }
  }

  AppFailure _mapLoginException(AppException e) {
    if (e is UnauthorizedException) {
      return const InvalidCredentialsFailure();
    }
    if (e is ValidationException) {
      final String msg = e.message.toLowerCase();
      if (msg.contains('email not confirmed') || msg.contains('not verified')) {
        return const EmailNotVerifiedFailure();
      }
      return UnknownAuthFailure(message: e.message);
    }
    if (e is RateLimitException) {
      return RateLimitFailure(message: e.message);
    }
    if (e is NetworkException) {
      return const NetworkFailure();
    }
    return UnknownAuthFailure(message: e.message);
  }

  // ---------------------------------------------------------------------------
  // Forgot Password
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppFailure, void>> sendPasswordResetEmail(
    ForgotPasswordEntity entity,
  ) async {
    try {
      await _dataSource.sendPasswordResetEmail(email: entity.email);

      // Per spec: Always return success for neutral confirmation
      // (prevent account enumeration).
      return const Right(null);
    } on AppException catch (e) {
      return Left(_mapForgotPasswordException(e));
    } catch (_) {
      return const Left(NetworkFailure());
    }
  }

  AppFailure _mapForgotPasswordException(AppException e) {
    if (e is RateLimitException) {
      return const RateLimitFailure(
        message:
            'Too many requests. Please wait a few moments before trying again.',
      );
    }
    if (e is NetworkException) {
      return const NetworkFailure();
    }
    return UnknownAuthFailure(message: e.message);
  }

  // ---------------------------------------------------------------------------
  // Password Reset
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppFailure, void>> resetPassword(
    ResetPasswordEntity entity,
  ) async {
    try {
      // TODO: The reset token should be obtained from the deep-link URL
      // parameter and passed through the domain layer. Currently the domain
      // entity only carries `newPassword`. When the backend contract is
      // confirmed, either:
      //   1. Add a `token` field to ResetPasswordEntity, or
      //   2. Pass the token through a different mechanism.
      await _dataSource.resetPassword(
        newPassword: entity.newPassword,
        token: '', // Placeholder — requires backend contract confirmation
      );
      return const Right(null);
    } on AppException catch (e) {
      return Left(_mapResetPasswordException(e));
    } catch (_) {
      return const Left(NetworkFailure());
    }
  }

  AppFailure _mapResetPasswordException(AppException e) {
    if (e is ValidationException) {
      final String msg = e.message.toLowerCase();
      if (msg.contains('weak password')) {
        return const WeakPasswordFailure();
      }
      return UnknownAuthFailure(message: e.message);
    }
    if (e is UnauthorizedException || e is ForbiddenException) {
      return InvalidResetLinkFailure(message: e.message);
    }
    if (e is RateLimitException) {
      return RateLimitFailure(message: e.message);
    }
    if (e is NetworkException) {
      return const NetworkFailure();
    }
    return UnknownAuthFailure(message: e.message);
  }
}
