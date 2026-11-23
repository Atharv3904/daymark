// lib/features/authethication/presentation/widgets/reset_password_form.dart
//
// Reset Password form widget matching the reference "Reset Link Screen".
// Features circular lock badge, new/confirm password fields, dynamic checklist,
// and Reset Password button.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/core/routes/routes_name.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/reset_password_entity.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_state.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_icon_badge.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/password_input.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/password_requirement_item.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/submit_button.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _newPassword = '';
  String _confirmPassword = '';

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _hasMin8Chars => _newPassword.length >= 8;
  bool get _passwordsMatch =>
      _newPassword.isNotEmpty && _newPassword == _confirmPassword;

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final entity = ResetPasswordEntity(
        newPassword: _newPasswordController.text,
      );
      context.read<AuthCubit>().resetPassword(entity);
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
        } else if (state is AuthPasswordResetSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password updated successfully! Please log in.'),
              backgroundColor: AppTheme.primaryPurple,
            ),
          );
          context.go(Routes.login);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Circular Lock Icon Badge
            const AuthIconBadge(icon: Icons.lock_rounded, size: 82),
            const SizedBox(height: 24),

            // Headline
            const Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Subtitle
            const Text(
              'Create a new password for your account.',
              style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            // New Password input
            PasswordInput(
              controller: _newPasswordController,
              hintText: 'New Password',
              enforceMinLength: true,
              onChanged: (val) {
                setState(() {
                  _newPassword = val;
                });
              },
            ),
            const SizedBox(height: 14),

            // Confirm Password input
            PasswordInput(
              controller: _confirmPasswordController,
              hintText: 'Confirm Password',
              enforceMinLength: false,
              onChanged: (val) {
                setState(() {
                  _confirmPassword = val;
                });
              },
              customValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _newPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Requirements Checklist
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Column(
                children: [
                  PasswordRequirementItem(
                    text: 'At least 8 characters',
                    isValid: _hasMin8Chars,
                  ),
                  PasswordRequirementItem(
                    text: 'Passwords must match',
                    isValid: _passwordsMatch,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Reset Password Button
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return SubmitButton(
                  text: 'Reset Password',
                  isLoading: state is AuthLoading,
                  onPressed: _onSubmit,
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _mapFailureToMessage(AppFailure failure) {
    if (failure is WeakPasswordFailure) {
      return 'Password is too weak. Please choose a stronger password.';
    } else if (failure is InvalidResetLinkFailure) {
      return failure.message ??
          'Reset link is invalid or expired. Please request a new one.';
    } else if (failure is NetworkFailure) {
      return 'Network error. Please check your connection and try again.';
    } else {
      return 'Failed to reset password. Please try again.';
    }
  }
}
