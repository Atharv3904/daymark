import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:daymark_tracking/core/present/widgets/global_snackbar.dart';
import 'package:daymark_tracking/core/routes/routes.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_entities.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_state.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_form_validators.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/glass_card.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/glass_text_field.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/gradient_submit_button.dart';

class ResetPasswordForm extends StatefulWidget {
  final String token;

  const ResetPasswordForm({super.key, required this.token});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
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
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AuthFormCubit>().resetPassword(
      ResetPasswordEntity(
        token: widget.token,
        newPassword: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthFormCubit, AuthFormState>(
      listener: (BuildContext context, AuthFormState state) {
        if (state is AuthFormResetPasswordSuccess) {
          GlobalSnackbar.showSuccess(
            'Password updated. Please sign in.',
            context: context,
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
                  validator: AuthFormValidators.validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppTheme.textSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
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
                      AuthFormValidators.validateConfirmPassword(
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
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
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
    );
  }
}
