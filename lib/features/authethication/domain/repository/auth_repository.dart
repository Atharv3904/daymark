// lib/features/authethication/domain/repository/auth_repository.dart
//
// Unified abstract contract for all authentication data operations.
// The domain depends only on this abstraction, never on concrete
// implementations or external SDKs.

import 'package:dartz/dartz.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/forgot_password_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/login_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/registration_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/reset_password_entity.dart';

/// {@template auth_repository}
/// Repository interface that defines all authentication use-case contracts.
/// Implementations live in the data layer.
///
/// All methods return an `Either<AppFailure, void>` to keep error handling
/// explicit and avoid throwing exceptions to the presentation layer.
/// {@endtemplate}
abstract class AuthRepository {
  /// Register a new user with the given [entity].
  Future<Either<AppFailure, void>> register(RegistrationEntity entity);

  /// Authenticate a user with the given [entity].
  Future<Either<AppFailure, void>> login(LoginEntity entity);

  /// Sends a password reset email for the given [entity].
  Future<Either<AppFailure, void>> sendPasswordResetEmail(
    ForgotPasswordEntity entity,
  );

  /// Updates the user's password for the recovery session using [entity].
  Future<Either<AppFailure, void>> resetPassword(ResetPasswordEntity entity);
}
