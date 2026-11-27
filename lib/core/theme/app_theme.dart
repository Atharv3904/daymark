import 'package:flutter/material.dart';

/// Centralized Liquid Glass dark theme & design tokens for DayMark,
/// derived from the visual reference screenshots.
class AppTheme {
  AppTheme._();

  static const Color bgObsidian = Color(0xFF070B16);
  static const Color bgDeepNavy = Color(0xFF0D1429);
  static const Color accentBlue = Color(0xFF4C8DFF);
  static const Color accentPurple = Color(0xFF9E5CFF);
  static const Color accentIceBlue = Color(0xFFBBD3FA);

  static const Color glassFill = Color(0x18FFFFFF);
  static const Color glassInputFill = Color(0x14FFFFFF);
  static const Color glassBorder = Color(0x38FFFFFF);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3BED6);
  static const Color errorColor = Color(0xFFFF6B7A);
  static const Color warningColor = Color(0xFFFFB84D);
  static const Color successColor = Color(0xFF4CE0A8);

  static const LinearGradient primaryButtonGradient = LinearGradient(
    colors: <Color>[accentBlue, accentPurple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static BoxDecoration glassCardDecoration({double borderRadius = 28}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0x24FFFFFF), Color(0x0CFFFFFF)],
      ),
      border: Border.all(color: glassBorder, width: 1.1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x55000000),
          blurRadius: 32,
          offset: Offset(0, 16),
        ),
      ],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgObsidian,
      colorScheme: const ColorScheme.dark(
        primary: accentBlue,
        secondary: accentPurple,
        surface: bgDeepNavy,
        error: errorColor,
        onPrimary: textPrimary,
        onSecondary: textPrimary,
        onSurface: textPrimary,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        bodyMedium: TextStyle(fontSize: 15, color: textSecondary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: glassInputFill,
        hintStyle: const TextStyle(color: textSecondary, fontSize: 15),
        errorStyle: const TextStyle(color: errorColor, fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: accentBlue, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: errorColor, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: errorColor, width: 1.4),
        ),
      ),
    );
  }
}
