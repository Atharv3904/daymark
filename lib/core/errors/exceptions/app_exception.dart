/// Application-wide data layer exception hierarchy.
///
/// Thrown exclusively by Remote Data Sources and HTTP clients.
/// Caught and mapped to [AppFailure] by Repository implementations.
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, {this.statusCode});

  @override
  String toString() => '$runtimeType: $message (statusCode: $statusCode)';
}

/// Thrown when connection fails, times out, or host is unreachable.
class NetworkException extends AppException {
  const NetworkException([super.message = 'Network connection failed', int? statusCode])
      : super(statusCode: statusCode);
}

/// Thrown when the server returns 400 Bad Request or 422 Unprocessable Entity.
class ValidationException extends AppException {
  final dynamic errorDetails;

  const ValidationException([
    super.message = 'Validation failed',
    int? statusCode = 422,
    this.errorDetails,
  ]) : super(statusCode: statusCode);
}

/// Thrown when the server returns 401 Unauthorized.
class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Unauthorized', int? statusCode = 401])
      : super(statusCode: statusCode);
}

/// Thrown when the server returns 403 Forbidden.
class ForbiddenException extends AppException {
  const ForbiddenException([super.message = 'Forbidden', int? statusCode = 403])
      : super(statusCode: statusCode);
}

/// Thrown when the server returns 404 Not Found.
class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Resource not found', int? statusCode = 404])
      : super(statusCode: statusCode);
}

/// Thrown when the server returns 409 Conflict.
class ConflictException extends AppException {
  const ConflictException([super.message = 'Conflict occurred', int? statusCode = 409])
      : super(statusCode: statusCode);
}

/// Thrown when the server returns 429 Too Many Requests.
class RateLimitException extends AppException {
  const RateLimitException([super.message = 'Rate limit exceeded', int? statusCode = 429])
      : super(statusCode: statusCode);
}

/// Thrown when the server returns a 5xx Internal Server Error.
class ServerException extends AppException {
  const ServerException([super.message = 'Internal server error', int? statusCode = 500])
      : super(statusCode: statusCode);
}

/// Thrown when response parsing or JSON deserialization fails.
class ParsingException extends AppException {
  const ParsingException([super.message = 'Failed to parse response payload', int? statusCode])
      : super(statusCode: statusCode);
}
