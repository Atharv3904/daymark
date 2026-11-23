// lib/features/authethication/data/datasource/auth_remote_datasource_impl.dart
//
// Concrete implementation of the unified authentication remote data source.
// All Supabase auth API calls are centralised here.

import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabase;

  AuthRemoteDataSourceImpl(this._supabase);

  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

  @override
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> sendPasswordResetEmail({
    required String email,
    String? redirectTo,
  }) async {
    await _supabase.auth.resetPasswordForEmail(email, redirectTo: redirectTo);
  }

  @override
  Future<UserResponse> updatePassword({required String newPassword}) async {
    return await _supabase.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }
}
