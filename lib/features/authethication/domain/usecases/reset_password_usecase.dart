import 'package:dartz/dartz.dart';

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/params/auth_params.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository _repository;

  const ResetPasswordUseCase(this._repository);

  Future<Either<AppFailure, void>> execute(ResetPasswordParams params) =>
      _repository.resetPassword(params);
}
