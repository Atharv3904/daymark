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
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthFormCubit>(
      create: (_) => getIt<AuthFormCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AuthFormCubit>().login(
      LoginEntity(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
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
          BlocConsumer<AuthFormCubit, AuthFormState>(
            listener: (BuildContext context, AuthFormState state) {
              if (state is AuthFormLoginSuccess) {
                if (state.session.isAuthenticated) {
                  context.read<AuthSessionCubit>().markAuthenticated();
                } else {
                  context.read<AuthSessionCubit>().markVerificationPending();
                  context.go(AppRoutes.verificationPending);
                }
              } else if (state is AuthFormError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.failure.message),
                    backgroundColor: AppTheme.errorColor,
                  ),
                );
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
                        'Welcome Back',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 6),
                      const Text('Sign in to continue with DayMark'),
                      const SizedBox(height: 24),
                      GlassTextField(
                        controller: _emailController,
                        hintText: 'Email Address',
                        prefixIcon: Icons.mail_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                        validator: AuthValidators.validateEmail,
                      ),
                      const SizedBox(height: 16),
                      GlassTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        validator: AuthValidators.validatePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppTheme.textSecondary,
                          ),
                          onPressed: () {
                            setState(
                              () => _obscurePassword = !_obscurePassword,
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: isLoading
                              ? null
                              : () => context.push(AppRoutes.forgotPassword),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: AppTheme.accentIceBlue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GradientSubmitButton(
                        label: 'Sign In',
                        isLoading: isLoading,
                        onPressed: _submit,
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: isLoading
                            ? null
                            : () => context.go(AppRoutes.signup),
                        child: const Text(
                          "Don't have an account? Create Account",
                          style: TextStyle(color: AppTheme.accentIceBlue),
                        ),
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
