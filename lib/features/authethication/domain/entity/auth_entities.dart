import 'package:equatable/equatable.dart';

class RegistrationEntity extends Equatable {
  final String email;
  final String password;

  const RegistrationEntity({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginEntity extends Equatable {
  final String email;
  final String password;

  const LoginEntity({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class ForgotPasswordEntity extends Equatable {
  final String email;

  const ForgotPasswordEntity({required this.email});

  @override
  List<Object?> get props => [email];
}

class ResetPasswordEntity extends Equatable {
  final String token;
  final String newPassword;

  const ResetPasswordEntity({required this.token, required this.newPassword});

  @override
  List<Object?> get props => [token, newPassword];
}

class VerifyEmailEntity extends Equatable {
  final String token;

  const VerifyEmailEntity({required this.token});

  @override
  List<Object?> get props => [token];
}

class AuthSessionEntity extends Equatable {
  final bool isAuthenticated;
  final bool isEmailVerified;

  const AuthSessionEntity({
    required this.isAuthenticated,
    required this.isEmailVerified,
  });

  @override
  List<Object?> get props => [isAuthenticated, isEmailVerified];
}
