// lib/features/authethication/presentation/pages/registration_page.dart
//
// Registration page matching the visual reference design:
// - Top-left back button
// - Top DayMark logo & tagline
// - Create Account headline & subtitle
// - Email, password, confirm password, requirements checklist
// - Bottom ambient wave background

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_background.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_logo_header.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/registration_form.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => GetIt.I<AuthCubit>(),
      child: const AuthBackground(
        showBackButton: true,
        child: Column(
          children: [
            AuthLogoHeader(height: 56),
            SizedBox(height: 28),
            RegistrationForm(),
          ],
        ),
      ),
    );
  }
}
