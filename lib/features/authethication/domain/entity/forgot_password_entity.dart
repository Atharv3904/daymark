// lib/features/authethication/domain/entity/forgot_password_entity.dart
//
// Domain entity that models the input for requesting a password reset email.
// According to specifications, email must be trimmed and valid.

import 'package:equatable/equatable.dart';

class ForgotPasswordEntity extends Equatable {
  const ForgotPasswordEntity({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}
