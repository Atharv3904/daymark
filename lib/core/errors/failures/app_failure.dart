import 'package:equatable/equatable.dart';

/// Base domain-layer failure returned inside `Either<AppFailure, T>`.
abstract class AppFailure extends Equatable {
  final String message;

  const AppFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends AppFailure {
  const NetworkFailure([
    super.message = 'Unable to connect. Please check your internet connection.',
  ]);
}

class ValidationFailure extends AppFailure {
  const ValidationFailure([super.message = 'Please check your input.']);
}

class ServerFailure extends AppFailure {
  const ServerFailure([
    super.message = 'Something went wrong on the server. Please try again.',
  ]);
}

class InvalidCredentialsFailure extends AppFailure {
  const InvalidCredentialsFailure([
    super.message = 'Invalid email or password.',
  ]);
}

class UserAlreadyExistsFailure extends AppFailure {
  const UserAlreadyExistsFailure([
    super.message = 'An account with this email already exists.',
  ]);
}

class WeakPasswordFailure extends AppFailure {
  const WeakPasswordFailure([
    super.message = 'Password does not meet security requirements.',
  ]);
}

class EmailNotVerifiedFailure extends AppFailure {
  const EmailNotVerifiedFailure([
    super.message = 'Please verify your email before signing in.',
  ]);
}

class EmailVerificationPendingFailure extends AppFailure {
  const EmailVerificationPendingFailure([
    super.message = 'Please verify your email to continue.',
  ]);
}

class SessionExpiredFailure extends AppFailure {
  const SessionExpiredFailure([
    super.message = 'Your session has expired. Please sign in again.',
  ]);
}

class RefreshTokenRevokedFailure extends AppFailure {
  const RefreshTokenRevokedFailure([
    super.message = 'Your session was revoked. Please sign in again.',
  ]);
}

class RateLimitFailure extends AppFailure {
  const RateLimitFailure([
    super.message = 'Too many requests. Please wait a moment and try again.',
  ]);
}

class InvalidResetLinkFailure extends AppFailure {
  const InvalidResetLinkFailure([
    super.message =
        'This link is invalid or has expired. Please request a new one.',
  ]);
}

class UnknownAuthFailure extends AppFailure {
  const UnknownAuthFailure([
    super.message = 'Authentication failed. Please try again.',
  ]);
}
