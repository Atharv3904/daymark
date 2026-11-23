// lib/features/authethication/presentation/pages/forgot_password_page.dart
//
// Forgot Password page matching the visual reference design:
// - Top-left back button
// - Top DayMark logo & tagline
// - Circular envelope badge
// - Forgot Password headline & subtitle
// - Email input & Send Reset Link button
// - Bottom ambient wave background

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_background.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_logo_header.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => GetIt.I<AuthCubit>(),
      child: const AuthBackground(
        showBackButton: true,
        child: Column(
          children: [
            AuthLogoHeader(height: 56),
            SizedBox(height: 24),
            ForgotPasswordForm(),
          ],
        ),
      ),
    );
  }
}
