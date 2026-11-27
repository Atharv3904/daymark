import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:daymark_tracking/features/authethication/domain/entity/auth_entities.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/auth_usecases.dart';
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

  Future<void> register(RegistrationEntity entity) async {
    if (state is AuthFormLoading) return;
    emit(const AuthFormLoading());
    final result = await _registerUseCase.execute(entity);
    result.fold(
      (failure) => emit(AuthFormError(failure)),
      (session) => emit(AuthFormRegistrationSuccess(session)),
    );
  }

  Future<void> login(LoginEntity entity) async {
    if (state is AuthFormLoading) return;
    emit(const AuthFormLoading());
    final result = await _loginUseCase.execute(entity);
    result.fold(
      (failure) => emit(AuthFormError(failure)),
      (session) => emit(AuthFormLoginSuccess(session)),
    );
  }

  Future<void> sendPasswordResetEmail(ForgotPasswordEntity entity) async {
    if (state is AuthFormLoading) return;
    emit(const AuthFormLoading());
    final result = await _forgotPasswordUseCase.execute(entity);
    result.fold(
      (failure) => emit(AuthFormError(failure)),
      (_) => emit(const AuthFormForgotPasswordSuccess()),
    );
  }

  Future<void> resetPassword(ResetPasswordEntity entity) async {
    if (state is AuthFormLoading) return;
    emit(const AuthFormLoading());
    final result = await _resetPasswordUseCase.execute(entity);
    result.fold(
      (failure) => emit(AuthFormError(failure)),
      (_) => emit(const AuthFormResetPasswordSuccess()),
    );
  }

  Future<void> verifyEmail(VerifyEmailEntity entity) async {
    if (state is AuthFormLoading) return;
    emit(const AuthFormLoading());
    final result = await _verifyEmailUseCase.execute(entity);
    result.fold(
      (failure) => emit(AuthFormError(failure)),
      (session) => emit(AuthFormEmailVerified(session)),
    );
  }

  void reset() => emit(const AuthFormInitial());
}
