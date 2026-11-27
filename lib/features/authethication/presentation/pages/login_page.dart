import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:daymark_tracking/core/get_it/get_injection.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_background.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_logo_header.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthFormCubit>(
      create: (_) => getIt<AuthFormCubit>(),
      child: const AuthBackground(
        showBackButton: true,
        child: Column(
          children: <Widget>[
            AuthLogoHeader(),
            SizedBox(height: 28),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
