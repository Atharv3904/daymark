import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:daymark_tracking/features/authethication/domain/params/auth_params.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/forgot_password_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/login_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/register_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/reset_password_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/verify_email_usecase.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_state.dart';

/// Handles per-screen authentication form submissions without mutating
/// global session state on recoverable failures.
class AuthFormCubit extends Cubit<AuthFormState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;

  AuthFormCubit(
    this._registerUseCase,
    this._loginUseCase,
    this._forgotPasswordUseCase,
    this._resetPasswordUseCase,
    this._verifyEmailUseCase,
  ) : super(const AuthFormInitial());

  Future<void> register(RegisterParams params) async {
    if (state is AuthFormLoading) return;
    emit(const AuthFormLoading());
    final result = await _registerUseCase.execute(params);
    result.fold(
      (failure) => emit(AuthFormError(failure)),
      (session) => emit(AuthFormRegistrationSuccess(session)),
    );
  }

  Future<void> login(LoginParams params) async {
    if (state is AuthFormLoading) return;
    emit(const AuthFormLoading());
    final result = await _loginUseCase.execute(params);
    result.fold(
      (failure) => emit(AuthFormError(failure)),
      (session) => emit(AuthFormLoginSuccess(session)),
    );
  }

  Future<void> sendPasswordResetEmail(ForgotPasswordParams params) async {
    if (state is AuthFormLoading) return;
    emit(const AuthFormLoading());
    final result = await _forgotPasswordUseCase.execute(params);
    result.fold(
      (failure) => emit(AuthFormError(failure)),
      (_) => emit(const AuthFormForgotPasswordSuccess()),
    );
  }

  Future<void> resetPassword(ResetPasswordParams params) async {
    if (state is AuthFormLoading) return;
    emit(const AuthFormLoading());
    final result = await _resetPasswordUseCase.execute(params);
    result.fold(
      (failure) => emit(AuthFormError(failure)),
      (_) => emit(const AuthFormResetPasswordSuccess()),
    );
  }

  Future<void> verifyEmail(VerifyEmailParams params) async {
    if (state is AuthFormLoading) return;
    emit(const AuthFormLoading());
    final result = await _verifyEmailUseCase.execute(params);
    result.fold(
      (failure) => emit(AuthFormError(failure)),
      (session) => emit(AuthFormEmailVerified(session)),
    );
  }

  void reset() => emit(const AuthFormInitial());
}
