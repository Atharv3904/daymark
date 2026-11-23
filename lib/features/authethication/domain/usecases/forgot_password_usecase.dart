// lib/features/authethication/domain/usecases/forgot_password_usecase.dart
//
// Use-case that orchestrates requesting a password reset email.
// It receives a [ForgotPasswordEntity] from the presentation layer,
// forwards it to the [AuthRepository], and returns `Either<AppFailure, void>`.

import 'package:dartz/dartz.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/forgot_password_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';

class ForgotPasswordUseCase {
  const ForgotPasswordUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<Either<AppFailure, void>> execute(ForgotPasswordEntity entity) async {
    return _authRepository.sendPasswordResetEmail(entity);
  }
}
