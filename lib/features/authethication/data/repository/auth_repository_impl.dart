// lib/features/authethication/data/repository/auth_repository_impl.dart
//
// Concrete implementation of the unified authentication repository.
// Uses [AuthRemoteDataSource] for all Supabase operations and maps
// exceptions to domain-level [AppFailure] types.
//
// Error mapping follows CUSTOM_EXCEPTIONS_SPEC.md and BOUNDARY_CONDITIONS_SPEC.md.

import 'package:dartz/dartz.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/data/datasource/auth_remote_datasource.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/forgot_password_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/login_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/registration_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/reset_password_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;
  final SupabaseClient _supabase;

  AuthRepositoryImpl(this._dataSource, this._supabase);

  // ---------------------------------------------------------------------------
  // Registration
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppFailure, void>> register(RegistrationEntity entity) async {
    try {
      final response = await _dataSource.signUp(
        email: entity.email,
        password: entity.password,
      );

      // User created and email already verified.
      if (response.user != null && response.user?.emailConfirmedAt != null) {
        return const Right(null);
      }

      // Email verification is required.
      return const Left(EmailVerificationPendingFailure());
    } on AuthException catch (e) {
      return Left(_mapRegistrationAuthException(e));
    } catch (_) {
      return const Left(NetworkFailure());
    }
  }

  AppFailure _mapRegistrationAuthException(AuthException e) {
    final msg = e.message.toLowerCase();

    if (msg.contains('already registered') || msg.contains('duplicate key')) {
      return const UserAlreadyExistsFailure();
    }
    if (msg.contains('weak password')) {
      return const WeakPasswordFailure();
    }
    return UnknownAuthFailure(message: e.message);
  }

  // ---------------------------------------------------------------------------
  // Login
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppFailure, void>> login(LoginEntity entity) async {
    try {
      final response = await _dataSource.signIn(
        email: entity.email,
        password: entity.password,
      );

      // Authenticated with a valid session.
      if (response.session != null && response.user != null) {
        return const Right(null);
      }

      // User exists but email is not verified.
      if (response.user != null && response.user?.emailConfirmedAt == null) {
        return const Left(EmailNotVerifiedFailure());
      }

      return const Left(
        UnknownAuthFailure(message: 'Login failed: no session returned.'),
      );
    } on AuthException catch (e) {
      return Left(_mapLoginAuthException(e));
    } catch (_) {
      return const Left(NetworkFailure());
    }
  }

  AppFailure _mapLoginAuthException(AuthException e) {
    final msg = e.message.toLowerCase();

    if (msg.contains('invalid') || msg.contains('credentials')) {
      return const InvalidCredentialsFailure();
    }
    if (msg.contains('email not confirmed') || msg.contains('not verified')) {
      return const EmailNotVerifiedFailure();
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
      // Per Section 8 of spec: Deep link callback URL for password reset
      await _dataSource.sendPasswordResetEmail(
        email: entity.email,
        redirectTo: 'io.supabase.daymark://reset-password',
      );

      // Per spec: Always return success for neutral confirmation (prevent account enumeration)
      return const Right(null);
    } on AuthException catch (e) {
      final msg = e.message.toLowerCase();
      if (msg.contains('rate limit') || msg.contains('too many requests')) {
        return const Left(
          RateLimitFailure(
            message: 'Too many requests. Please wait a few moments before trying again.',
          ),
        );
      }
      return Left(UnknownAuthFailure(message: e.message));
    } catch (_) {
      return const Left(NetworkFailure());
    }
  }

  // ---------------------------------------------------------------------------
  // Password Reset (Deep Link)
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppFailure, void>> resetPassword(
    ResetPasswordEntity entity,
  ) async {
    try {
      // Per Section 8: Validate recovery link/session before updating password
      final currentSession = _supabase.auth.currentSession;
      if (currentSession == null) {
        return const Left(
          InvalidResetLinkFailure(
            message: 'Recovery session is missing or expired. Please request a new reset link.',
          ),
        );
      }

      await _dataSource.updatePassword(newPassword: entity.newPassword);

      return const Right(null);
    } on AuthException catch (e) {
      final msg = e.message.toLowerCase();
      if (msg.contains('weak password')) {
        return const Left(WeakPasswordFailure());
      }
      if (msg.contains('expired') ||
          msg.contains('invalid') ||
          msg.contains('unauthorized')) {
        return Left(InvalidResetLinkFailure(message: e.message));
      }
      return Left(UnknownAuthFailure(message: e.message));
    } catch (_) {
      return const Left(NetworkFailure());
    }
  }
}
