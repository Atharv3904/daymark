// lib/features/authethication/presentation/cubit/auth_cubit.dart
//
// Unified authentication Cubit for all auth flows (login, registration,
// forgot-password, reset-password). One Cubit for the entire authentication feature.
// Each method invokes its corresponding use case and emits appropriate states.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/forgot_password_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/login_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/registration_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/reset_password_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/forgot_password_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/login_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/registration_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/reset_password_usecase.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegistrationUseCase _registrationUseCase;
  final LoginUseCase _loginUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  AuthCubit(
    this._registrationUseCase,
    this._loginUseCase,
    this._forgotPasswordUseCase,
    this._resetPasswordUseCase,
  ) : super(const AuthInitial());

  /// Submits a registration request.
  Future<void> register(RegistrationEntity entity) async {
    emit(const AuthLoading());

    final result = await _registrationUseCase.execute(entity);

    result.fold(
      (failure) => emit(AuthError(failure)),
      (_) => emit(const AuthRegistrationSuccess()),
    );
  }

  /// Submits a login request.
  Future<void> login(LoginEntity entity) async {
    emit(const AuthLoading());

    final result = await _loginUseCase.execute(entity);

    result.fold(
      (failure) => emit(AuthError(failure)),
      (_) => emit(const AuthLoginSuccess()),
    );
  }

  /// Submits a forgot password request to send a reset link.
  Future<void> forgotPassword(ForgotPasswordEntity entity) async {
    emit(const AuthLoading());

    final result = await _forgotPasswordUseCase.execute(entity);

    result.fold(
      (failure) => emit(AuthError(failure)),
      (_) => emit(const AuthForgotPasswordSuccess()),
    );
  }

  /// Submits a new password during the reset password flow.
  Future<void> resetPassword(ResetPasswordEntity entity) async {
    emit(const AuthLoading());

    final result = await _resetPasswordUseCase.execute(entity);

    result.fold(
      (failure) => emit(AuthError(failure)),
      (_) => emit(const AuthPasswordResetSuccess()),
    );
  }

  /// Resets the cubit to the initial state.
  void reset() => emit(const AuthInitial());
}
