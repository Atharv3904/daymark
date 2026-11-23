// lib/features/authethication/presentation/widgets/password_input.dart
//
// Reusable password input widget matching the visual reference design:
// - Lock icon prefix
// - Eye visibility toggle suffix
// - Clean rounded border and hint text
// - Preserves whitespace exactly

import 'package:flutter/material.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    required this.controller,
    this.hintText = 'Password',
    this.enforceMinLength = true,
    this.customValidator,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String hintText;
  final bool enforceMinLength;
  final String? Function(String?)? customValidator;
  final ValueChanged<String>? onChanged;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  String? _validator(String? value) {
    if (widget.customValidator != null) {
      return widget.customValidator!(value);
    }
    if (value == null || value.isEmpty) {
      return 'Password required';
    }
    if (widget.enforceMinLength && value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15),
      obscureText: _obscureText,
      validator: _validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
