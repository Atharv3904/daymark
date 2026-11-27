import 'package:flutter/material.dart';

import 'package:daymark_tracking/core/theme/app_theme.dart';

/// DayMark logo badge, wordmark, and tagline header.
class AuthLogoHeader extends StatelessWidget {
  const AuthLogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFF6B8BFF), Color(0xFF4F46E5)],
            ),
            border: Border.all(color: AppTheme.glassBorder, width: 1.2),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x555E7BFF),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.check_rounded, color: Colors.white, size: 36),
        ),
        const SizedBox(height: 14),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
            children: <InlineSpan>[
              TextSpan(
                text: 'Day',
                style: TextStyle(color: AppTheme.textPrimary),
              ),
              TextSpan(
                text: 'Mark',
                style: TextStyle(color: Color(0xFFA78BFA)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Plan · Track · Complete · Grow',
          style: TextStyle(
            fontSize: 13,
            color: AppTheme.textSecondary,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}
