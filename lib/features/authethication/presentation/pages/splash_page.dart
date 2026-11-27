import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_background.dart';
import 'package:daymark_tracking/features/authethication/presentation/widgets/auth_logo_header.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AuthSessionCubit>().checkSession();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AuthBackground(
      child: Padding(
        padding: EdgeInsets.only(top: 120),
        child: Column(
          children: <Widget>[
            AuthLogoHeader(),
            SizedBox(height: 36),
            CircularProgressIndicator(strokeWidth: 2.4),
          ],
        ),
      ),
    );
  }
}
