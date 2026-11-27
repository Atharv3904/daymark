import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:daymark_tracking/core/get_it/get_injection.dart';
import 'package:daymark_tracking/core/routes/routes.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_entities.dart';
import 'package:daymark_tracking/features/authethication/domain/validators/auth_validators.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_state.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_widgets.dart';

class ResetPasswordPage extends StatelessWidget {
  final String? token;

  const ResetPasswordPage({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthFormCubit>(
      create: (_) => getIt<AuthFormCubit>(),
      child: _ResetPasswordView(token: token),
    );
  }
}

class _ResetPasswordView extends StatefulWidget {
  final String? token;

  const _ResetPasswordView({required this.token});

  @override
  State<_ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<_ResetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    final String? token = widget.token;
    if (token == null || token.isEmpty) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AuthFormCubit>().resetPassword(
      ResetPasswordEntity(token: token, newPassword: _passwordController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasValidToken = widget.token != null && widget.token!.isNotEmpty;
    return AuthBackground(
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
            BlocConsumer<AuthFormCubit, AuthFormState>(
              listener: (BuildContext context, AuthFormState state) {
                if (state is AuthFormResetPasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password updated. Please sign in.'),
                      backgroundColor: AppTheme.successColor,
                    ),
                  );
                  context.go(AppRoutes.login);
                }
              },
              builder: (BuildContext context, AuthFormState state) {
                final bool isLoading = state is AuthFormLoading;
                return GlassCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Reset Password',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 6),
                        const Text('Enter your new password below.'),
                        const SizedBox(height: 24),
                        GlassTextField(
                          controller: _passwordController,
                          hintText: 'New Password',
                          prefixIcon: Icons.lock_outline_rounded,
                          obscureText: _obscurePassword,
                          validator: AuthValidators.validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppTheme.textSecondary,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        GlassTextField(
                          controller: _confirmController,
                          hintText: 'Confirm Password',
                          prefixIcon: Icons.lock_outline_rounded,
                          obscureText: _obscureConfirm,
                          textInputAction: TextInputAction.done,
                          validator: (String? v) =>
                              AuthValidators.validateConfirmPassword(
                                v,
                                _passwordController.text,
                              ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirm
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppTheme.textSecondary,
                            ),
                            onPressed: () => setState(
                              () => _obscureConfirm = !_obscureConfirm,
                            ),
                          ),
                        ),
                        if (state is AuthFormError) ...<Widget>[
                          const SizedBox(height: 12),
                          Text(
                            state.failure.message,
                            style: const TextStyle(color: AppTheme.errorColor),
                          ),
                        ],
                        const SizedBox(height: 24),
                        GradientSubmitButton(
                          label: 'Update Password',
                          isLoading: isLoading,
                          onPressed: _submit,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
