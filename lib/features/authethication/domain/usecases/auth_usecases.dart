import 'package:dartz/dartz.dart';

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_entities.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  const RegisterUseCase(this._repository);

  Future<Either<AppFailure, AuthSessionEntity>> execute(
    RegistrationEntity entity,
  ) => _repository.register(entity);
}

class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<Either<AppFailure, AuthSessionEntity>> execute(LoginEntity entity) =>
      _repository.login(entity);
}

class ForgotPasswordUseCase {
  final AuthRepository _repository;

  const ForgotPasswordUseCase(this._repository);

  Future<Either<AppFailure, void>> execute(ForgotPasswordEntity entity) =>
      _repository.sendPasswordResetEmail(entity);
}

class ResetPasswordUseCase {
  final AuthRepository _repository;

  const ResetPasswordUseCase(this._repository);

  Future<Either<AppFailure, void>> execute(ResetPasswordEntity entity) =>
      _repository.resetPassword(entity);
}

class VerifyEmailUseCase {
  final AuthRepository _repository;

  const VerifyEmailUseCase(this._repository);

  Future<Either<AppFailure, AuthSessionEntity>> execute(
    VerifyEmailEntity entity,
  ) => _repository.verifyEmail(entity);
}

class CheckSessionUseCase {
  final AuthRepository _repository;

  const CheckSessionUseCase(this._repository);

  Future<Either<AppFailure, AuthSessionEntity>> execute() =>
      _repository.checkSession();
}

class SignOutUseCase {
  final AuthRepository _repository;

  const SignOutUseCase(this._repository);

  Future<Either<AppFailure, void>> execute({bool global = false}) =>
      _repository.signOut(global: global);
}
