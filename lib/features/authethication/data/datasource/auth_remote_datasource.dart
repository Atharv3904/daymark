// lib/features/authethication/data/datasource/auth_remote_datasource.dart
//
// Abstract contract for the unified authentication remote data source.
// All authentication operations (register, login, forgot-password,
// reset-password, sign-out) are defined here. Keeping a single data-source
// allows the repository implementation to be unit-tested by mocking one
// dependency.

/// Contract for authentication REST API calls.
///
/// Methods accept domain-level parameters and return parsed response data.
/// The concrete implementation communicates with the FastAPI backend
/// exclusively through REST API calls via [DioClient].
abstract class AuthRemoteDataSource {
  /// Register a new user. Returns the parsed response body.
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
  });

  /// Authenticate a user. Returns the parsed response body
  /// (expected to contain access / refresh tokens).
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });

  /// Request a password-reset email for the given address.
  Future<void> sendPasswordResetEmail({required String email});

  /// Set a new password using a reset token obtained from the reset email.
  Future<void> resetPassword({
    required String newPassword,
    required String token,
  });

  /// Sign the current user out and invalidate their session.
  Future<void> signOut();
}
