// lib/features/authethication/domain/entity/reset_password_entity.dart
//
// Domain entity that models the input for updating a user's password
// during the recovery/reset flow.
// Passwords are never trimmed and must be at least 8 characters.

import 'package:equatable/equatable.dart';

class ResetPasswordEntity extends Equatable {
  const ResetPasswordEntity({required this.newPassword});

  final String newPassword;

  @override
  List<Object?> get props => [newPassword];
}
