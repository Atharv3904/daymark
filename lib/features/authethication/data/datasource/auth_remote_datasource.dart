// lib/features/authethication/data/datasource/auth_remote_datasource.dart
//
// Abstract contract for the unified authentication remote data source.
// All authentication operations (sign-up, sign-in, forgot-password, reset-password)
// are defined here. Keeping a single data-source allows the repository
// implementation to be unit-tested by mocking one dependency.

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  /// Calls Supabase's `signUp` endpoint.
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  });

  /// Calls Supabase's `signInWithPassword` endpoint.
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  });

  /// Sends a password reset email via Supabase's `resetPasswordForEmail` endpoint.
  Future<void> sendPasswordResetEmail({
    required String email,
    String? redirectTo,
  });

  /// Updates the user's password using an authenticated recovery session.
  Future<UserResponse> updatePassword({required String newPassword});
}
