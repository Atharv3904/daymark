// lib/features/authethication/presentation/widgets/email_input.dart
//
// Reusable email input widget matching the visual reference design:
// - Mail icon prefix
// - Translucent filled background
// - Trim whitespace, local email format validation

import 'package:flutter/material.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
    required this.controller,
    this.hintText = 'Email',
  });

  final TextEditingController? controller;
  final String hintText;

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email required';
    }
    final trimmed = value.trim();
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(trimmed)) {
      return 'Enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15),
      keyboardType: TextInputType.emailAddress,
      validator: _validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.mail_outline_rounded, size: 20),
      ),
    );
  }
}
