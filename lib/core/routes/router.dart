import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:daymark_tracking/core/routes/routes.dart';
import 'package:daymark_tracking/core/routes/routes_name.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_state.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/email_verification_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/forgot_password_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/home_placeholder_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/login_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/registration_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/reset_password_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/splash_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/verification_pending_page.dart';
import 'package:daymark_tracking/features/authethication/presentation/pages/welcome_page.dart';

class AppRouter {
  final AuthSessionCubit _sessionCubit;
  late final _CubitRefreshNotifier _refreshNotifier;
  late final GoRouter router;

  AppRouter(this._sessionCubit) {
    _refreshNotifier = _CubitRefreshNotifier(_sessionCubit.stream);
    router = GoRouter(
      initialLocation: AppRoutes.splash,
      refreshListenable: _refreshNotifier,
      redirect: _handleRedirect,
      routes: <RouteBase>[
        GoRoute(
          name: RouteNames.splash,
          path: AppRoutes.splash,
          builder: (_, _) => const SplashPage(),
        ),
        GoRoute(
          name: RouteNames.welcome,
          path: AppRoutes.welcome,
          builder: (_, _) => const WelcomePage(),
        ),
        GoRoute(
          name: RouteNames.login,
          path: AppRoutes.login,
          builder: (_, _) => const LoginPage(),
        ),
        GoRoute(
          name: RouteNames.signup,
          path: AppRoutes.signup,
          builder: (_, _) => const RegistrationPage(),
        ),
        GoRoute(
          name: RouteNames.forgotPassword,
          path: AppRoutes.forgotPassword,
          builder: (_, _) => const ForgotPasswordPage(),
        ),
        GoRoute(
          name: RouteNames.resetPassword,
          path: AppRoutes.resetPassword,
          builder: (_, GoRouterState state) =>
              ResetPasswordPage(token: state.uri.queryParameters['token']),
        ),
        GoRoute(
          name: RouteNames.verifyEmail,
          path: AppRoutes.verifyEmail,
          builder: (_, GoRouterState state) =>
              EmailVerificationPage(token: state.uri.queryParameters['token']),
        ),
        GoRoute(
          name: RouteNames.verificationPending,
          path: AppRoutes.verificationPending,
          builder: (_, _) => const VerificationPendingPage(),
        ),
        GoRoute(
          name: RouteNames.home,
          path: AppRoutes.home,
          builder: (_, _) => const HomePlaceholderPage(),
        ),
        GoRoute(
          name: RouteNames.settings,
          path: AppRoutes.settings,
          builder: (_, _) => const HomePlaceholderPage(),
        ),
      ],
    );
  }

  String? _handleRedirect(BuildContext context, GoRouterState state) {
    final AuthSessionState session = _sessionCubit.state;
    final String loc = state.matchedLocation;

    const Set<String> publicAuthRoutes = <String>{
      AppRoutes.welcome,
      AppRoutes.login,
      AppRoutes.signup,
      AppRoutes.forgotPassword,
      AppRoutes.resetPassword,
      AppRoutes.verifyEmail,
      AppRoutes.verificationPending,
    };

    if (session is AuthSessionInitial || session is AuthSessionChecking) {
      return loc == AppRoutes.splash ? null : AppRoutes.splash;
    }

    if (session is AuthSessionAuthenticated) {
      if (loc == AppRoutes.splash || publicAuthRoutes.contains(loc)) {
        return AppRoutes.home;
      }
      return null;
    }

    if (session is AuthSessionVerificationPending) {
      if (loc == AppRoutes.home ||
          loc == AppRoutes.settings ||
          loc == AppRoutes.splash) {
        return AppRoutes.verificationPending;
      }
      return null;
    }

    // Unauthenticated or failure
    if (loc == AppRoutes.splash ||
        loc == AppRoutes.home ||
        loc == AppRoutes.settings) {
      return AppRoutes.welcome;
    }
    return null;
  }

  void dispose() {
    _refreshNotifier.dispose();
  }
}

class _CubitRefreshNotifier extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  _CubitRefreshNotifier(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
