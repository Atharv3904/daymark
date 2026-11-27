import 'package:dartz/dartz.dart';

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_entities.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';

class CheckSessionUseCase {
  final AuthRepository _repository;

  const CheckSessionUseCase(this._repository);

  Future<Either<AppFailure, AuthSessionEntity>> execute() =>
      _repository.checkSession();
}
