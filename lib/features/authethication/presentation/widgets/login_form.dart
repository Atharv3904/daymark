// lib/features/authethication/presentation/widgets/login_form.dart
//
// Login form widget matching the reference "Login Screen" design.
// Contains email, password, forgot-password link, Login button, and Sign Up navigation.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/core/routes/routes_name.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/login_entity.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_state.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/email_input.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/password_input.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/submit_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final entity = LoginEntity(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      context.read<AuthCubit>().login(entity);
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
        } else if (state is AuthLoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: AppTheme.primaryPurple,
            ),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Headline & Subtitle
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Log in to continue your productivity journey.',
              style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Email input
            EmailInput(controller: _emailController),
            const SizedBox(height: 16),

            // Password input
            PasswordInput(
              controller: _passwordController,
              enforceMinLength: false,
            ),
            const SizedBox(height: 10),

            // Forgot Password link
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => context.push(Routes.forgotPassword),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Login Button
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return SubmitButton(
                  text: 'Login',
                  isLoading: state is AuthLoading,
                  onPressed: _onSubmit,
                );
              },
            ),
            const SizedBox(height: 28),

            // Bottom Navigation to Register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                ),
                GestureDetector(
                  onTap: () => context.push(Routes.signup),
                  child: const Text(
                    'Sign Up',
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
    if (failure is InvalidCredentialsFailure) {
      return 'Invalid email or password. Please try again.';
    } else if (failure is EmailNotVerifiedFailure) {
      return 'Please verify your email before logging in.';
    } else if (failure is NetworkFailure) {
      return 'Network error. Please check your connection and try again.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
