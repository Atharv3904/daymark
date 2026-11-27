import 'package:equatable/equatable.dart';

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_session_entity.dart';

abstract class AuthFormState extends Equatable {
  const AuthFormState();

  @override
  List<Object?> get props => <Object?>[];
}

class AuthFormInitial extends AuthFormState {
  const AuthFormInitial();
}

class AuthFormLoading extends AuthFormState {
  const AuthFormLoading();
}

class AuthFormRegistrationSuccess extends AuthFormState {
  final AuthSessionEntity session;

  const AuthFormRegistrationSuccess(this.session);

  @override
  List<Object?> get props => <Object?>[session];
}

class AuthFormLoginSuccess extends AuthFormState {
  final AuthSessionEntity session;

  const AuthFormLoginSuccess(this.session);

  @override
  List<Object?> get props => <Object?>[session];
}

class AuthFormForgotPasswordSuccess extends AuthFormState {
  const AuthFormForgotPasswordSuccess();
}

class AuthFormResetPasswordSuccess extends AuthFormState {
  const AuthFormResetPasswordSuccess();
}

class AuthFormEmailVerified extends AuthFormState {
  final AuthSessionEntity session;

  const AuthFormEmailVerified(this.session);

  @override
  List<Object?> get props => <Object?>[session];
}

class AuthFormError extends AuthFormState {
  final AppFailure failure;

  const AuthFormError(this.failure);

  @override
  List<Object?> get props => <Object?>[failure];
}
