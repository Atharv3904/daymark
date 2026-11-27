import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:daymark_tracking/core/get_it/get_injection.dart';
import 'package:daymark_tracking/core/routes/routes.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_entities.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_state.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_background.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_logo_header.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/glass_card.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/gradient_submit_button.dart';

class EmailVerificationPage extends StatefulWidget {
  final String? token;

  const EmailVerificationPage({super.key, this.token});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  late final AuthFormCubit _formCubit;

  @override
  void initState() {
    super.initState();
    _formCubit = getIt<AuthFormCubit>();
    final String? token = widget.token;
    if (token != null && token.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _formCubit.verifyEmail(VerifyEmailEntity(token: token));
        }
      });
    }
  }

  @override
  void dispose() {
    _formCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasToken = widget.token != null && widget.token!.isNotEmpty;
    return BlocProvider<AuthFormCubit>.value(
      value: _formCubit,
      child: AuthBackground(
        child: Column(
          children: <Widget>[
            const AuthLogoHeader(),
            const SizedBox(height: 28),
            if (!hasToken)
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
                    const Text(
                      'Invalid Verification Link',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GradientSubmitButton(
                      label: 'Go to Sign In',
                      onPressed: () => context.go(AppRoutes.login),
                    ),
                  ],
                ),
              )
            else
              BlocConsumer<AuthFormCubit, AuthFormState>(
                listener: (BuildContext context, AuthFormState state) {
                  if (state is AuthFormEmailVerified) {
                    if (state.session.isAuthenticated) {
                      context.read<AuthSessionCubit>().markAuthenticated();
                    } else {
                      context.go(AppRoutes.login);
                    }
                  }
                },
                builder: (BuildContext context, AuthFormState state) {
                  if (state is AuthFormError) {
                    return GlassCard(
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
                            state.failure.message,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          GradientSubmitButton(
                            label: 'Go to Sign In',
                            onPressed: () => context.go(AppRoutes.login),
                          ),
                        ],
                      ),
                    );
                  }
                  return const GlassCard(
                    child: Column(
                      children: <Widget>[
                        CircularProgressIndicator(strokeWidth: 2.4),
                        SizedBox(height: 16),
                        Text('Verifying your email...'),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
