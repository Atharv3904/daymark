import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:daymark_tracking/core/get_it/get_injection.dart';
import 'package:daymark_tracking/core/routes/routes.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_background.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_logo_header.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/glass_card.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/gradient_submit_button.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/reset_password_form.dart';

class ResetPasswordPage extends StatelessWidget {
  final String? token;

  const ResetPasswordPage({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    final String? resetToken = token;
    final bool hasValidToken = resetToken != null && resetToken.isNotEmpty;

    return BlocProvider<AuthFormCubit>(
      create: (_) => getIt<AuthFormCubit>(),
      child: AuthBackground(
        showBackButton: true,
        child: Column(
          children: <Widget>[
            const AuthLogoHeader(),
            const SizedBox(height: 28),
            if (!hasValidToken)
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Icon(
                      Icons.error_outline_rounded,
                      size: 48,
                      color: AppTheme.errorColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Invalid or Expired Link',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Your password reset link is invalid or expired. Please request a new one.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    GradientSubmitButton(
                      label: 'Request New Link',
                      onPressed: () => context.go(AppRoutes.forgotPassword),
                    ),
                  ],
                ),
              )
            else
              ResetPasswordForm(token: resetToken),
          ],
        ),
      ),
    );
  }
}
