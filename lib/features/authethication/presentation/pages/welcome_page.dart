import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:daymark_tracking/core/routes/routes.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_widgets.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 24),
          const AuthLogoHeader(),
          const SizedBox(height: 36),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Welcome to DayMark',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Organize your day, track progress, and build lasting momentum.',
                ),
                const SizedBox(height: 28),
                GradientSubmitButton(
                  label: 'Create Account',
                  onPressed: () => context.push(AppRoutes.signup),
                ),
                const SizedBox(height: 14),
                OutlinedButton(
                  onPressed: () => context.push(AppRoutes.login),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    side: const BorderSide(color: AppTheme.glassBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
