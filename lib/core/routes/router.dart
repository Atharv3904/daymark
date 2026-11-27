// lib/core/routes/router.dart
//
// Application router using GoRouter.
// Defines authentication routes for the DayMark app.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:daymark_tracking/core/routes/routes_name.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/forgot_password_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/login_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/registration_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/reset_password_page.dart';

/// Central application router.
///
/// Provides a [GoRouter] with authentication routes. Additional feature routes
/// (dashboard, tasks, etc.) should be added here as they become available.
class AppRouter {
  /// The configured [GoRouter] instance for use in [MaterialApp.router].
  GoRouter get router => _router;

  final GoRouter _router = GoRouter(
    initialLocation: Routes.login,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: Routes.signup,
        builder: (BuildContext context, GoRouterState state) {
          return const RegistrationPage();
        },
      ),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (BuildContext context, GoRouterState state) {
          return const ForgotPasswordPage();
        },
      ),
      GoRoute(
        path: Routes.resetPassword,
        builder: (BuildContext context, GoRouterState state) {
          // The reset token is expected as a query parameter from the
          // deep-link URL, e.g. /reset-password?token=abc123
          final String? token = state.uri.queryParameters['token'];
          return ResetPasswordPage(resetToken: token);
        },
      ),
    ],
  );
}
