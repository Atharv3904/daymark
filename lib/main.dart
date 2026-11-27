import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:daymark_tracking/core/get_it/get_injection.dart';
import 'package:daymark_tracking/core/present/widgets/global_snackbar.dart';
import 'package:daymark_tracking/core/routes/router.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();

  runApp(const DayMarkApp());
}

class DayMarkApp extends StatefulWidget {
  const DayMarkApp({super.key});

  @override
  State<DayMarkApp> createState() => _DayMarkAppState();
}

class _DayMarkAppState extends State<DayMarkApp> {
  late final AuthSessionCubit _sessionCubit;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _sessionCubit = getIt<AuthSessionCubit>();
    _appRouter = AppRouter(_sessionCubit);
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthSessionCubit>.value(
      value: _sessionCubit,
      child: MaterialApp.router(
        title: 'DayMark',
        theme: AppTheme.darkTheme,
        scaffoldMessengerKey: GlobalSnackbar.messengerKey,
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.router,
      ),
    );
  }
}
