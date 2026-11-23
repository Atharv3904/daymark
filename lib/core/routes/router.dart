// lib/core/routes/router.dart
//
// Sets up GoRouter for the DayMark app, including authentication routes
// (sign-up, login, forgot-password, reset-password).
// Handles deep link callbacks for password recovery as a singleton.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/registration_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/login_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/forgot_password_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/reset_password_page.dart';

import 'routes_name.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;

  late final GoRouter _router;
  StreamSubscription<AuthState>? _authSubscription;

  AppRouter._internal() {
    _router = GoRouter(
      initialLocation: Routes.login,
      routes: [
        // Login page
        GoRoute(
          path: Routes.login,
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        // Sign-up (registration) page
        GoRoute(
          path: Routes.signup,
          name: 'signup',
          builder: (context, state) => const RegistrationPage(),
        ),
        // Forgot password page
        GoRoute(
          path: Routes.forgotPassword,
          name: 'forgot-password',
          builder: (context, state) => const ForgotPasswordPage(),
        ),
        // Password reset page (public deep link callback)
        GoRoute(
          path: Routes.resetPassword,
          name: 'reset-password',
          builder: (context, state) => const ResetPasswordPage(),
        ),
      ],
    );

    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    try {
      _authSubscription = Supabase.instance.client.auth.onAuthStateChange
          .listen(
            (data) {
              final AuthChangeEvent event = data.event;
              if (event == AuthChangeEvent.passwordRecovery) {
                // User opened password recovery deep link
                _router.go(Routes.resetPassword);
              }
            },
            onError: (error) {
              debugPrint('Auth state change listener error: $error');
            },
          );
    } catch (e) {
      debugPrint('Supabase not yet initialized or subscription error: $e');
    }
  }

  void dispose() {
    _authSubscription?.cancel();
  }

  GoRouter get router => _router;
}
