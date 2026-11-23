// lib/core/errors/failures/app_failure.dart
//
// Application-wide failure definitions. The authentication flows
// use these failures to represent error conditions without leaking
// SDK-specific exception types to the presentation layer.
//
// The hierarchy mirrors the custom exceptions described in
// `CUSTOM_EXCEPTIONS_SPEC.md` and the unified authentication specification.

abstract class AppFailure {
  const AppFailure();
}

// ---------------------------------------------------------------------------
// Authentication-related failures
// ---------------------------------------------------------------------------

class UserAlreadyExistsFailure extends AppFailure {
  const UserAlreadyExistsFailure();
}

class WeakPasswordFailure extends AppFailure {
  const WeakPasswordFailure();
}

class NetworkFailure extends AppFailure {
  const NetworkFailure();
}

class EmailVerificationPendingFailure extends AppFailure {
  const EmailVerificationPendingFailure();
}

class InvalidCredentialsFailure extends AppFailure {
  const InvalidCredentialsFailure();
}

class EmailNotVerifiedFailure extends AppFailure {
  const EmailNotVerifiedFailure();
}

class RateLimitFailure extends AppFailure {
  final String? message;
  const RateLimitFailure({this.message});
}

class InvalidResetLinkFailure extends AppFailure {
  final String? message;
  const InvalidResetLinkFailure({this.message});
}

class UnknownAuthFailure extends AppFailure {
  final String? message;
  const UnknownAuthFailure({this.message});
}
