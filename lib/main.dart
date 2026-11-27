// lib/main.dart

import 'package:daymark_tracking/core/get_it/get_injection.dart';
import 'package:daymark_tracking/core/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();

  runApp(const DayMarkApp());
}

class DayMarkApp extends StatelessWidget {
  const DayMarkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DayMark',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter().router,
    );
  }
}
