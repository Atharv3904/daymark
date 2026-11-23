// lib/features/authethication/domain/usecases/reset_password_usecase.dart
//
// Use-case that orchestrates updating the password after opening
// a password recovery deep link.
// It receives a [ResetPasswordEntity] and returns `Either<AppFailure, void>`.

import 'package:dartz/dartz.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/reset_password_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';

class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<Either<AppFailure, void>> execute(ResetPasswordEntity entity) async {
    return _authRepository.resetPassword(entity);
  }
}
