import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:daymark_tracking/core/routes/routes.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_background.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_logo_header.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/glass_card.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/gradient_submit_button.dart';

class VerificationPendingPage extends StatelessWidget {
  const VerificationPendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        children: <Widget>[
          const AuthLogoHeader(),
          const SizedBox(height: 28),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Icon(
                  Icons.mark_email_unread_outlined,
                  size: 48,
                  color: AppTheme.accentIceBlue,
                ),
                const SizedBox(height: 16),
                Text(
                  'Verify Your Email',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please verify your email address before accessing DayMark.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                GradientSubmitButton(
                  label: 'Back to Sign In',
                  onPressed: () {
                    context.read<AuthSessionCubit>().signOut();
                    context.go(AppRoutes.login);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
