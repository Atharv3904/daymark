// lib/features/authethication/domain/registration_entity.dart
//
// Domain entity that models the data required for a user registration
// request.  According to the specifications (INPUT_SPEC.md, BOUNDARY_CONDITIONS_SPEC.md)
// registration only needs **email** and **password** – the confirm‑password
// field is handled in the presentation layer and is not part of the domain
// model.

import 'package:equatable/equatable.dart';

/// {@template registration_entity}
/// Immutable value object representing the registration inputs.
///
/// * **email** – trimmed of surrounding whitespace before being passed to the
///   use‑case. Must be a valid e‑mail address.
/// * **password** – stored exactly as entered (no trimming). Must be at least
///   8 characters long.
///
/// This entity lives in the *domain* layer, keeping it free of any framework
/// or infrastructure concerns (e.g., no Flutter widgets, no SDK-specific types).
/// {@endtemplate}
class RegistrationEntity extends Equatable {
  const RegistrationEntity({required this.email, required this.password});

  /// The user's e‑mail address (already trimmed by the UI layer).
  final String email;

  /// The password entered by the user. **Never** trimmed or altered.
  final String password;

  @override
  List<Object?> get props => [email, password];
}
