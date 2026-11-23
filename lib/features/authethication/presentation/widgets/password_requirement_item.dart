// lib/features/authethication/presentation/widgets/password_requirement_item.dart
//
// Checklist item widget for password requirements matching the reference screens.
// Displays a checkmark and requirement text.

import 'package:flutter/material.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';

class PasswordRequirementItem extends StatelessWidget {
  const PasswordRequirementItem({
    super.key,
    required this.text,
    this.isValid = false,
  });

  final String text;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    final color = isValid ? AppTheme.checkGreen : AppTheme.textSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        children: [
          Icon(Icons.check_rounded, size: 16, color: color),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 12.5, color: color)),
        ],
      ),
    );
  }
}
