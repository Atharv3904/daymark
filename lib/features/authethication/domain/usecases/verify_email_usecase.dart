import 'package:dartz/dartz.dart';

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_entities.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';

class VerifyEmailUseCase {
  final AuthRepository _repository;

  const VerifyEmailUseCase(this._repository);

  Future<Either<AppFailure, AuthSessionEntity>> execute(
    VerifyEmailEntity entity,
  ) => _repository.verifyEmail(entity);
}
