// lib/features/authethication/presentation/pages/reset_password_page.dart
//
// Reset Password page matching the visual reference design:
// - Top-left back button
// - Top DayMark logo & tagline
// - Circular lock badge
// - Reset Password headline & subtitle
// - New password, confirm password, requirements checklist
// - Bottom ambient wave background

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:daymark_tracking/core/routes/routes_name.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_background.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_logo_header.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/reset_password_form.dart';

class ResetPasswordPage extends StatefulWidget {
  /// Token obtained from the password-reset deep-link URL.
  /// When non-null and non-empty the reset form is shown.
  /// When absent an "expired / invalid link" notice is shown instead.
  final String? resetToken;

  const ResetPasswordPage({super.key, this.resetToken});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final bool _hasValidSession;

  @override
  void initState() {
    super.initState();
    // TODO: When the backend contract is confirmed, consider validating the
    // reset token against the API before showing the form.
    _hasValidSession =
        widget.resetToken != null && widget.resetToken!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => GetIt.I<AuthCubit>(),
      child: AuthBackground(
        showBackButton: true,
        child: Column(
          children: [
            const AuthLogoHeader(height: 56),
            const SizedBox(height: 24),
            _hasValidSession
                ? const ResetPasswordForm()
                : Container(
                    padding: const EdgeInsets.all(24),
                    decoration: AppTheme.cardBoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.amberAccent,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Session Expired or Invalid Link',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Your password reset link is invalid, expired, or has already been used. Please request a new one.',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => context.go(Routes.forgotPassword),
                          child: const Text('Request New Reset Link'),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
