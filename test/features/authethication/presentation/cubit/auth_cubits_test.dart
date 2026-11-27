import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_entities.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/check_session_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/forgot_password_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/login_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/register_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/reset_password_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/sign_out_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/verify_email_usecase.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_state.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_state.dart';

class _FakeAuthRepository implements AuthRepository {
  AppFailure? failure;
  AuthSessionEntity session = const AuthSessionEntity(
    isAuthenticated: true,
    isEmailVerified: true,
  );

  @override
  Future<Either<AppFailure, AuthSessionEntity>> register(
    RegistrationEntity entity,
  ) async => failure != null ? Left(failure!) : Right(session);

  @override
  Future<Either<AppFailure, AuthSessionEntity>> login(
    LoginEntity entity,
  ) async => failure != null ? Left(failure!) : Right(session);

  @override
  Future<Either<AppFailure, void>> sendPasswordResetEmail(
    ForgotPasswordEntity entity,
  ) async => failure != null ? Left(failure!) : const Right(null);

  @override
  Future<Either<AppFailure, void>> resetPassword(
    ResetPasswordEntity entity,
  ) async => failure != null ? Left(failure!) : const Right(null);

  @override
  Future<Either<AppFailure, AuthSessionEntity>> verifyEmail(
    VerifyEmailEntity entity,
  ) async => failure != null ? Left(failure!) : Right(session);

  @override
  Future<Either<AppFailure, AuthSessionEntity>> checkSession() async =>
      failure != null ? Left(failure!) : Right(session);

  @override
  Future<Either<AppFailure, void>> signOut({bool global = false}) async =>
      failure != null ? Left(failure!) : const Right(null);
}

void main() {
  late _FakeAuthRepository repository;
  late AuthSessionCubit sessionCubit;
  late AuthFormCubit formCubit;

  setUp(() {
    repository = _FakeAuthRepository();
    sessionCubit = AuthSessionCubit(
      CheckSessionUseCase(repository),
      SignOutUseCase(repository),
    );
    formCubit = AuthFormCubit(
      RegisterUseCase(repository),
      LoginUseCase(repository),
      ForgotPasswordUseCase(repository),
      ResetPasswordUseCase(repository),
      VerifyEmailUseCase(repository),
    );
  });

  tearDown(() async {
    await sessionCubit.close();
    await formCubit.close();
  });

  test('AuthSessionCubit emits Authenticated when session exists', () async {
    await sessionCubit.checkSession();
    expect(sessionCubit.state, const AuthSessionAuthenticated());
  });

  test('AuthSessionCubit emits Unauthenticated after signOut', () async {
    await sessionCubit.signOut();
    expect(sessionCubit.state, const AuthSessionUnauthenticated());
  });

  test('AuthFormCubit emits LoginSuccess and Error cleanly', () async {
    await formCubit.login(
      const LoginEntity(email: 'a@b.com', password: 'password123'),
    );
    expect(formCubit.state, isA<AuthFormLoginSuccess>());

    repository.failure = const InvalidCredentialsFailure();
    await formCubit.login(
      const LoginEntity(email: 'a@b.com', password: 'wrongpassword'),
    );
    expect(formCubit.state, const AuthFormError(InvalidCredentialsFailure()));
  });
}
