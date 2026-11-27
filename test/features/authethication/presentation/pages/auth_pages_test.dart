import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/core/get_it/get_injection.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_entities.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/auth_usecases.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/registration_page.dart';

class _StubAuthRepo implements AuthRepository {
  @override
  Future<Either<AppFailure, AuthSessionEntity>> checkSession() async =>
      const Right(
        AuthSessionEntity(isAuthenticated: false, isEmailVerified: false),
      );

  @override
  Future<Either<AppFailure, AuthSessionEntity>> login(LoginEntity e) async =>
      const Right(
        AuthSessionEntity(isAuthenticated: true, isEmailVerified: true),
      );

  @override
  Future<Either<AppFailure, AuthSessionEntity>> register(
    RegistrationEntity e,
  ) async => const Right(
    AuthSessionEntity(isAuthenticated: true, isEmailVerified: true),
  );

  @override
  Future<Either<AppFailure, void>> resetPassword(ResetPasswordEntity e) async =>
      const Right(null);

  @override
  Future<Either<AppFailure, void>> sendPasswordResetEmail(
    ForgotPasswordEntity e,
  ) async => const Right(null);

  @override
  Future<Either<AppFailure, void>> signOut({bool global = false}) async =>
      const Right(null);

  @override
  Future<Either<AppFailure, AuthSessionEntity>> verifyEmail(
    VerifyEmailEntity e,
  ) async => const Right(
    AuthSessionEntity(isAuthenticated: true, isEmailVerified: true),
  );
}

void main() {
  setUp(() async {
    await getIt.reset();
    final _StubAuthRepo repo = _StubAuthRepo();
    getIt.registerFactory<AuthFormCubit>(
      () => AuthFormCubit(
        RegisterUseCase(repo),
        LoginUseCase(repo),
        ForgotPasswordUseCase(repo),
        ResetPasswordUseCase(repo),
        VerifyEmailUseCase(repo),
      ),
    );
    getIt.registerLazySingleton<AuthSessionCubit>(
      () => AuthSessionCubit(CheckSessionUseCase(repo), SignOutUseCase(repo)),
    );
  });

  testWidgets('RegistrationPage validates empty email and short password', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      BlocProvider<AuthSessionCubit>.value(
        value: getIt<AuthSessionCubit>(),
        child: MaterialApp(
          theme: AppTheme.darkTheme,
          home: const RegistrationPage(),
        ),
      ),
    );

    await tester.tap(find.widgetWithText(ElevatedButton, 'Create Account'));
    await tester.pump();

    expect(find.text('Email required'), findsOneWidget);
    expect(find.text('Password must be at least 8 characters'), findsOneWidget);
  });
}
