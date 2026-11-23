// lib/features/authethication/presentation/widgets/registration_form.dart
//
// Registration form widget matching the reference "Register Screen" design.
// Contains Email, Password, Confirm Password, dynamic requirement checklist,
// Sign Up button, and Login navigation.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/core/routes/routes_name.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/registration_entity.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_state.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/email_input.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/password_input.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/password_requirement_item.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/submit_button.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _password = '';
  String _confirmPassword = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _hasMin8Chars => _password.length >= 8;
  bool get _isStrongPassword =>
      _password.length >= 8 &&
      RegExp(r'[A-Za-z]').hasMatch(_password) &&
      RegExp(r'[0-9]').hasMatch(_password);
  bool get _passwordsMatch =>
      _password.isNotEmpty && _password == _confirmPassword;

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final entity = RegistrationEntity(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      context.read<AuthCubit>().register(entity);
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
        } else if (state is AuthRegistrationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Account created! Please check your email to verify.',
              ),
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
            // Headline & Subtitle
            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Get started with DayMark.',
              style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            // Email input
            EmailInput(controller: _emailController),
            const SizedBox(height: 14),

            // Password input
            PasswordInput(
              controller: _passwordController,
              hintText: 'Password',
              enforceMinLength: true,
              onChanged: (val) {
                setState(() {
                  _password = val;
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
                if (value != _passwordController.text) {
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
                    text: 'Use a strong and secure password',
                    isValid: _isStrongPassword,
                  ),
                  PasswordRequirementItem(
                    text: 'Passwords must match',
                    isValid: _passwordsMatch,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Sign Up Button
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return SubmitButton(
                  text: 'Sign Up',
                  isLoading: state is AuthLoading,
                  onPressed: _onSubmit,
                );
              },
            ),
            const SizedBox(height: 24),

            // Bottom Navigation to Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                ),
                GestureDetector(
                  onTap: () => context.push(Routes.login),
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
    if (failure is UserAlreadyExistsFailure) {
      return 'This email is already registered.';
    } else if (failure is WeakPasswordFailure) {
      return 'Password is too weak. Please choose a stronger password.';
    } else if (failure is EmailVerificationPendingFailure) {
      return 'Please check your email to verify your account.';
    } else if (failure is NetworkFailure) {
      return 'Network error. Please check your connection and try again.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
