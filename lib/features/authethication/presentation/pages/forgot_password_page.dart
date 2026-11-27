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

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthFormCubit>(
      create: (_) => getIt<AuthFormCubit>(),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AuthFormCubit>().sendPasswordResetEmail(
      ForgotPasswordEntity(email: _emailController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      showBackButton: true,
      child: Column(
        children: <Widget>[
          const AuthLogoHeader(),
          const SizedBox(height: 28),
          BlocBuilder<AuthFormCubit, AuthFormState>(
            builder: (BuildContext context, AuthFormState state) {
              final bool isLoading = state is AuthFormLoading;
              if (state is AuthFormForgotPasswordSuccess) {
                return GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Icon(
                        Icons.mark_email_read_outlined,
                        size: 48,
                        color: AppTheme.successColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Check Your Email',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'If an account exists for that email, we have sent password reset instructions.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      GradientSubmitButton(
                        label: 'Back to Sign In',
                        onPressed: () => context.go(AppRoutes.login),
                      ),
                    ],
                  ),
                );
              }
              return GlassCard(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Forgot Password',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Enter your email to receive reset instructions.',
                      ),
                      const SizedBox(height: 24),
                      GlassTextField(
                        controller: _emailController,
                        hintText: 'Email Address',
                        prefixIcon: Icons.mail_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        validator: AuthValidators.validateEmail,
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
                        label: 'Send Reset Link',
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
