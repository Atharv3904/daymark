// lib/core/failure/auth_failure.dart
//
// This file defines the failure types used throughout the authentication
// feature.  It mirrors the `AppFailure` definitions from
// `core/errors/failures/app_failure.dart` but is kept under the `core/failure`
// namespace because many presentation classes import it from there.

abstract class AuthFailure {
  const AuthFailure();
}

class UserAlreadyExistsFailure extends AuthFailure {
  const UserAlreadyExistsFailure();
}

class WeakPasswordFailure extends AuthFailure {
  const WeakPasswordFailure();
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure();
}

class EmailVerificationPendingFailure extends AuthFailure {
  const EmailVerificationPendingFailure();
}

class UnknownAuthFailure extends AuthFailure {
  final String? message;
  const UnknownAuthFailure({this.message});
}
