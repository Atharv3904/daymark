import 'package:dartz/dartz.dart';

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_entities.dart';

/// Domain contract for all authentication operations.
abstract class AuthRepository {
  Future<Either<AppFailure, AuthSessionEntity>> register(
    RegistrationEntity entity,
  );

  Future<Either<AppFailure, AuthSessionEntity>> login(LoginEntity entity);

  Future<Either<AppFailure, void>> sendPasswordResetEmail(
    ForgotPasswordEntity entity,
  );

  Future<Either<AppFailure, void>> resetPassword(ResetPasswordEntity entity);

  Future<Either<AppFailure, AuthSessionEntity>> verifyEmail(
    VerifyEmailEntity entity,
  );

  Future<Either<AppFailure, AuthSessionEntity>> checkSession();

  Future<Either<AppFailure, void>> signOut({bool global = false});
}
