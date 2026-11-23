// lib/features/authethication/presentation/widgets/auth_logo_header.dart
//
// Centralized DayMark logo header following Global Branding & Logo Rules (AGENTS.md).
// Uses the approved logo asset: assets/images/logo/daymark_logo.png
// Fallbacks cleanly to daymark_icon.png if necessary.

import 'package:flutter/material.dart';

class AuthLogoHeader extends StatelessWidget {
  const AuthLogoHeader({super.key, this.height = 60});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/logo/daymark_logo.png',
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/logo/daymark_icon.png',
            height: height,
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}
