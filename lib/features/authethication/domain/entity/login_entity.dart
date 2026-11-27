// lib/features/authethication/domain/entity/login_entity.dart
//
// Domain entity that models the data required for a user login request.
// According to INPUT_SPEC.md, login requires email and password.
// Email is trimmed in the presentation layer before being passed here.
// Password is preserved exactly as entered (never trimmed).

import 'package:equatable/equatable.dart';

/// {@template login_entity}
/// Immutable value object representing the login inputs.
///
/// * **email** – trimmed of surrounding whitespace before being passed to the
///   use-case. Must be a valid e-mail address.
/// * **password** – stored exactly as entered (no trimming).
///
/// This entity lives in the *domain* layer, keeping it free of any framework
/// or infrastructure concerns (e.g., no Flutter widgets, no SDK-specific types).
/// {@endtemplate}
class LoginEntity extends Equatable {
  const LoginEntity({required this.email, required this.password});

  /// The user's e-mail address (already trimmed by the UI layer).
  final String email;

  /// The password entered by the user. **Never** trimmed or altered.
  final String password;

  @override
  List<Object?> get props => [email, password];
}
