import 'package:dartz/dartz.dart';

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_session_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/params/auth_params.dart';

/// Domain contract for all authentication operations.
abstract class AuthRepository {
  Future<Either<AppFailure, AuthSessionEntity>> register(RegisterParams params);

  Future<Either<AppFailure, AuthSessionEntity>> login(LoginParams params);

  Future<Either<AppFailure, void>> sendPasswordResetEmail(
    ForgotPasswordParams params,
  );

  Future<Either<AppFailure, void>> resetPassword(ResetPasswordParams params);

  Future<Either<AppFailure, AuthSessionEntity>> verifyEmail(
    VerifyEmailParams params,
  );

  Future<Either<AppFailure, AuthSessionEntity>> checkSession();

  Future<Either<AppFailure, void>> signOut({bool global = false});
}
