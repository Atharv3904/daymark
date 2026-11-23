// lib/features/authethication/presentation/pages/login_page.dart
//
// Login page matching the visual reference design:
// - Top DayMark logo & tagline
// - Welcome Back headline & subtitle
// - Email & password inputs with icons
// - Bottom ambient wave background

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_background.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_logo_header.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => GetIt.I<AuthCubit>(),
      child: const AuthBackground(
        showBackButton: false,
        child: Column(
          children: [
            AuthLogoHeader(height: 60),
            SizedBox(height: 32),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
