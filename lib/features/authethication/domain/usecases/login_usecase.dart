// lib/features/authethication/domain/usecases/login_usecase.dart
//
// Use-case that orchestrates the login flow. It receives a [LoginEntity]
// from the presentation layer, forwards it to the [AuthRepository]
// and returns the result as an `Either<AppFailure, void>`.

import 'package:dartz/dartz.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/login_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';

/// {@template login_usecase}
/// Authenticate a user with email & password.
///
/// - Email is trimmed in the presentation layer.
/// - Password is preserved exactly as entered.
/// - Calls the repository which talks to the FastAPI backend via the data source.
/// - Returns `Right(void)` on success or `Left(AppFailure)` on error.
/// {@endtemplate}
class LoginUseCase {
  const LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  /// Executes the login flow.
  Future<Either<AppFailure, void>> execute(LoginEntity entity) async {
    return _authRepository.login(entity);
  }
}
