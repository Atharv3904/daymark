import 'package:dartz/dartz.dart';

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _repository;

  const SignOutUseCase(this._repository);

  Future<Either<AppFailure, void>> execute({bool global = false}) =>
      _repository.signOut(global: global);
}
