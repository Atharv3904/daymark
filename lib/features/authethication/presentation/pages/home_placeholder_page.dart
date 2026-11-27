import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_widgets.dart';

/// Minimal protected Home & Sign-out placeholder until Dashboard/Profile
/// features are implemented.
class HomePlaceholderPage extends StatelessWidget {
  const HomePlaceholderPage({super.key});

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
                Text(
                  'DayMark Home',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'You are signed in. Dashboard and Tasks will live here.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                GradientSubmitButton(
                  label: 'Sign Out',
                  onPressed: () => context.read<AuthSessionCubit>().signOut(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
