// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';

/// Centralized theme for DayMark matching the reference UI design.
///
/// * Deep dark navy background (#0C0D1C).
/// * Card/Input surface (#16182E).
/// * Subtle border (#282C4E).
/// * Vibrant purple accent/button (#5E43EC).
/// * Soft mint/green success accent (#4ADE80).
/// * Muted lavender text (#9EA3C7).
class AppTheme {
  // Brand colors
  static const Color background = Color(0xFF0C0D1C);
  static const Color surface = Color(0xFF16182E);
  static const Color border = Color(0xFF282C4E);
  static const Color primaryPurple = Color(0xFF5E43EC);
  static const Color primaryPurpleHover = Color(0xFF7056FA);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF9EA3C7);
  static const Color checkGreen = Color(0xFF4ADE80);
  static const Color badgeBackground = Color(0xFF23254B);
  static const Color badgeBorder = Color(0xFF383670);

  // Bottom ambient wave colors
  static const Color waveColorStart = Color(0xFF38237F);
  static const Color waveColorEnd = Color(0xFF211550);

  // Card box decoration
  static BoxDecoration cardBoxDecoration({double borderRadius = 16.0}) {
    return BoxDecoration(
      color: surface,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: border, width: 1),
      boxShadow: const [
        BoxShadow(color: Colors.black45, blurRadius: 16, offset: Offset(0, 8)),
      ],
    );
  }

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryPurple,
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.dark(
      primary: primaryPurple,
      surface: surface,
      onSurface: textPrimary,
    ),
    useMaterial3: true,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: textPrimary),
      bodyMedium: TextStyle(fontSize: 14, color: textSecondary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: border, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primaryPurple, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      hintStyle: const TextStyle(color: textSecondary, fontSize: 14),
      prefixIconColor: textSecondary,
      suffixIconColor: textSecondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: textPrimary,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: textPrimary),
    ),
  );
}
