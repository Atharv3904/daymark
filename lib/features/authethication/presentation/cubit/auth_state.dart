// lib/features/authethication/presentation/cubit/auth_state.dart
//
// Unified authentication states for all auth flows (login, registration,
// forgot-password, reset-password, etc.). One state file for the entire authentication feature.

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any interaction.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading state while any authentication request is in progress.
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// State emitted when registration succeeds.
class AuthRegistrationSuccess extends AuthState {
  const AuthRegistrationSuccess();
}

/// State emitted when login succeeds.
class AuthLoginSuccess extends AuthState {
  const AuthLoginSuccess();
}

/// State emitted when a password reset email request succeeds.
class AuthForgotPasswordSuccess extends AuthState {
  const AuthForgotPasswordSuccess();
}

/// State emitted when a password reset operation succeeds.
class AuthPasswordResetSuccess extends AuthState {
  const AuthPasswordResetSuccess();
}

/// State emitted when any authentication operation fails.
class AuthError extends AuthState {
  const AuthError(this.failure);

  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}
