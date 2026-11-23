// lib/features/authethication/presentation/widgets/auth_icon_badge.dart
//
// Circular gradient badge used on Forgot Password and Reset Password screens
// matching the visual reference.

import 'package:flutter/material.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';

class AuthIconBadge extends StatelessWidget {
  const AuthIconBadge({super.key, required this.icon, this.size = 80});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppTheme.badgeBackground,
          shape: BoxShape.circle,
          border: Border.all(color: AppTheme.badgeBorder, width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x335E43EC),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, size: size * 0.45, color: const Color(0xFF9E8BFB)),
      ),
    );
  }
}
