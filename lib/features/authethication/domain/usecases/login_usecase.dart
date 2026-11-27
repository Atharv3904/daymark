import 'package:dartz/dartz.dart';

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_session_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/params/auth_params.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<Either<AppFailure, AuthSessionEntity>> execute(LoginParams params) =>
      _repository.login(params);
}
