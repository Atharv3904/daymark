// lib/features/authethication/presentation/widgets/forgot_password_form.dart
//
// Forgot Password form widget matching the reference "Forgot Password Screen".
// Features circular email badge, clear messaging, email input, Send Reset Link button,
// and neutral confirmation feedback.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/core/routes/routes_name.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/forgot_password_entity.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_state.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_icon_badge.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/email_input.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/submit_button.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final entity = ForgotPasswordEntity(email: _emailController.text.trim());
      context.read<AuthCubit>().forgotPassword(entity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_mapFailureToMessage(state.failure)),
              backgroundColor: Colors.redAccent,
            ),
          );
        } else if (state is AuthForgotPasswordSuccess) {
          setState(() {
            _emailSent = true;
          });
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Circular Mail Icon Badge
            const AuthIconBadge(
              icon: Icons.mark_email_unread_rounded,
              size: 82,
            ),
            const SizedBox(height: 24),

            // Headline
            const Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Subtitle / Confirmation
            Text(
              _emailSent
                  ? 'If an account exists with this email, we have sent a password reset link to it.'
                  : 'Enter your email and we\'ll send you a password reset link.',
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            if (!_emailSent) ...[
              // Email Input
              EmailInput(controller: _emailController),
              const SizedBox(height: 24),

              // Send Reset Link Button
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return SubmitButton(
                    text: 'Send Reset Link',
                    isLoading: state is AuthLoading,
                    onPressed: _onSubmit,
                  );
                },
              ),
            ] else ...[
              // Done state: Back to login
              SubmitButton(
                text: 'Back to Login',
                onPressed: () => context.go(Routes.login),
              ),
            ],
            const SizedBox(height: 24),

            // Bottom Navigation to Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Remember your password? ',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                ),
                GestureDetector(
                  onTap: () => context.go(Routes.login),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _mapFailureToMessage(AppFailure failure) {
    if (failure is RateLimitFailure) {
      return failure.message ??
          'Too many requests. Please wait a few moments before trying again.';
    } else if (failure is NetworkFailure) {
      return 'Network error. Please check your connection and try again.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
