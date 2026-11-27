import 'package:equatable/equatable.dart';

class RegisterParams extends Equatable {
  final String email;
  final String password;

  const RegisterParams({required this.email, required this.password});

  @override
  List<Object?> get props => <Object?>[email, password];
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => <Object?>[email, password];
}

class ForgotPasswordParams extends Equatable {
  final String email;

  const ForgotPasswordParams({required this.email});

  @override
  List<Object?> get props => <Object?>[email];
}

class ResetPasswordParams extends Equatable {
  final String token;
  final String newPassword;

  const ResetPasswordParams({required this.token, required this.newPassword});

  @override
  List<Object?> get props => <Object?>[token, newPassword];
}

class VerifyEmailParams extends Equatable {
  final String token;

  const VerifyEmailParams({required this.token});

  @override
  List<Object?> get props => <Object?>[token];
}
