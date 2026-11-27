// lib/features/authethication/domain/usecases/registration_usecase.dart
//
// Use-case that orchestrates the registration flow. It receives a
// [RegistrationEntity] from the presentation layer, forwards it to the
// [AuthRepository] and returns the result as an `Either<AppFailure, void>`.

import 'package:dartz/dartz.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/registration_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';

/// {@template registration_usecase}
/// Register a new user with email & password.
///
/// - Email is trimmed in the presentation layer.
/// - Password is preserved exactly as entered.
/// - Calls the repository which talks to the FastAPI backend via the data source.
/// - Returns `Right(void)` on success or `Left(AppFailure)` on error.
/// {@endtemplate}
class RegistrationUseCase {
  const RegistrationUseCase(this._authRepository);

  final AuthRepository _authRepository;

  /// Executes the registration flow.
  Future<Either<AppFailure, void>> execute(RegistrationEntity entity) async {
    return _authRepository.register(entity);
  }
}
