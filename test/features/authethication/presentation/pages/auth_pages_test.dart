import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/core/get_it/get_injection.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_session_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/params/auth_params.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/check_session_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/forgot_password_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/login_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/register_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/reset_password_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/sign_out_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/verify_email_usecase.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/registration_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_form_validators.dart';

class _StubAuthRepo implements AuthRepository {
  @override
  Future<Either<AppFailure, AuthSessionEntity>> checkSession() async =>
      const Right(
        AuthSessionEntity(isAuthenticated: false, isEmailVerified: false),
      );

  @override
  Future<Either<AppFailure, AuthSessionEntity>> login(LoginParams p) async =>
      const Right(
        AuthSessionEntity(isAuthenticated: true, isEmailVerified: true),
      );

  @override
  Future<Either<AppFailure, AuthSessionEntity>> register(
    RegisterParams p,
  ) async => const Right(
    AuthSessionEntity(isAuthenticated: true, isEmailVerified: true),
  );

  @override
  Future<Either<AppFailure, void>> resetPassword(ResetPasswordParams p) async =>
      const Right(null);

  @override
  Future<Either<AppFailure, void>> sendPasswordResetEmail(
    ForgotPasswordParams p,
  ) async => const Right(null);

  @override
  Future<Either<AppFailure, void>> signOut({bool global = false}) async =>
      const Right(null);

  @override
  Future<Either<AppFailure, AuthSessionEntity>> verifyEmail(
    VerifyEmailParams p,
  ) async => const Right(
    AuthSessionEntity(isAuthenticated: true, isEmailVerified: true),
  );
}

void main() {
  _registerValidatorTests();

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

void _registerValidatorTests() {
  group('AuthFormValidators', () {
    test('rejects empty or whitespace-only email', () {
      expect(AuthFormValidators.validateEmail(''), 'Email required');
      expect(AuthFormValidators.validateEmail('   '), 'Email required');
    });

    test('trims email and validates format', () {
      expect(AuthFormValidators.validateEmail('  user@daymark.app  '), isNull);
      expect(
        AuthFormValidators.validateEmail('invalid-email'),
        'Enter a valid email',
      );
    });

    test('never trims password and enforces 8-character minimum', () {
      expect(
        AuthFormValidators.validatePassword('short'),
        'Password must be at least 8 characters',
      );
      expect(AuthFormValidators.validatePassword('        '), isNull);
      expect(AuthFormValidators.validatePassword('pass1234'), isNull);
    });

    test('confirm password requires exact match', () {
      expect(
        AuthFormValidators.validateConfirmPassword('pass1234 ', 'pass1234'),
        'Passwords do not match',
      );
      expect(
        AuthFormValidators.validateConfirmPassword('pass1234', 'pass1234'),
        isNull,
      );
    });
  });
}
