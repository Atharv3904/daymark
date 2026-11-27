/// Application-wide data-layer exception hierarchy.
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, {this.statusCode});

  @override
  String toString() => '$runtimeType: $message (statusCode: $statusCode)';
}

class NetworkException extends AppException {
  const NetworkException([
    super.message = 'Network connection failed',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}

class ValidationException extends AppException {
  final dynamic errorDetails;

  const ValidationException([
    super.message = 'Validation failed',
    int? statusCode = 422,
    this.errorDetails,
  ]) : super(statusCode: statusCode);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([
    super.message = 'Unauthorized',
    int? statusCode = 401,
  ]) : super(statusCode: statusCode);
}

class ForbiddenException extends AppException {
  const ForbiddenException([super.message = 'Forbidden', int? statusCode = 403])
    : super(statusCode: statusCode);
}

class NotFoundException extends AppException {
  const NotFoundException([
    super.message = 'Resource not found',
    int? statusCode = 404,
  ]) : super(statusCode: statusCode);
}

class ConflictException extends AppException {
  const ConflictException([
    super.message = 'Conflict occurred',
    int? statusCode = 409,
  ]) : super(statusCode: statusCode);
}

class RateLimitException extends AppException {
  const RateLimitException([
    super.message = 'Rate limit exceeded',
    int? statusCode = 429,
  ]) : super(statusCode: statusCode);
}

class ServerException extends AppException {
  const ServerException([
    super.message = 'Internal server error',
    int? statusCode = 500,
  ]) : super(statusCode: statusCode);
}

class ParsingException extends AppException {
  const ParsingException([
    super.message = 'Failed to parse response payload',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}

/// Base class for all authentication-specific exceptions per Spec Section 6.
abstract class AppAuthException extends AppException {
  const AppAuthException(super.message, {super.statusCode});
}

class AppInvalidCredentialsException extends AppAuthException {
  const AppInvalidCredentialsException([
    super.message = 'Invalid email or password.',
  ]) : super(statusCode: 401);
}

class AppUserAlreadyExistsException extends AppAuthException {
  const AppUserAlreadyExistsException([
    super.message = 'An account with this email already exists.',
  ]) : super(statusCode: 409);
}

class AppWeakPasswordException extends AppAuthException {
  const AppWeakPasswordException([
    super.message = 'Password does not meet security requirements.',
  ]) : super(statusCode: 422);
}

class AppEmailNotVerifiedException extends AppAuthException {
  const AppEmailNotVerifiedException([
    super.message = 'Please verify your email before signing in.',
  ]) : super(statusCode: 403);
}

class AppEmailVerificationPendingException extends AppAuthException {
  const AppEmailVerificationPendingException([
    super.message = 'Email verification is pending.',
  ]);
}

class AppNetworkException extends AppAuthException {
  const AppNetworkException([
    super.message = 'Unable to reach the server. Please try again.',
  ]);
}

class AppSessionExpiredException extends AppAuthException {
  const AppSessionExpiredException([
    super.message = 'Your session has expired. Please sign in again.',
  ]) : super(statusCode: 401);
}

class AppRefreshTokenRevokedException extends AppAuthException {
  const AppRefreshTokenRevokedException([
    super.message = 'Session has been revoked. Please sign in again.',
  ]) : super(statusCode: 401);
}

class AppUnknownAuthException extends AppAuthException {
  const AppUnknownAuthException([
    super.message = 'An unexpected authentication error occurred.',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}
