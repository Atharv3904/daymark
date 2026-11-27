import 'package:flutter/material.dart';

import 'package:daymark_tracking/core/theme/app_theme.dart';

enum SnackbarType { success, error, warning, info }

/// Reusable shared Presentation-layer Snackbar for application-wide feedback.
class GlobalSnackbar {
  GlobalSnackbar._();

  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSuccess(String message, {BuildContext? context}) {
    _show(message: message, type: SnackbarType.success, context: context);
  }

  static void showError(String message, {BuildContext? context}) {
    _show(message: message, type: SnackbarType.error, context: context);
  }

  static void showWarning(String message, {BuildContext? context}) {
    _show(message: message, type: SnackbarType.warning, context: context);
  }

  static void showInfo(String message, {BuildContext? context}) {
    _show(message: message, type: SnackbarType.info, context: context);
  }

  static void _show({
    required String message,
    required SnackbarType type,
    BuildContext? context,
  }) {
    final String safeMessage = message.trim();
    if (safeMessage.isEmpty) return;

    final ScaffoldMessengerState? messenger =
        messengerKey.currentState ??
        (context != null ? ScaffoldMessenger.maybeOf(context) : null);
    if (messenger == null) return;

    final _SnackbarVisuals visuals = _visualsFor(type);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          backgroundColor: AppTheme.bgDeepNavy,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: visuals.accent.withValues(alpha: 0.6)),
          ),
          content: Row(
            children: <Widget>[
              Icon(visuals.icon, color: visuals.accent, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  safeMessage,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  static _SnackbarVisuals _visualsFor(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return const _SnackbarVisuals(
          icon: Icons.check_circle_outline_rounded,
          accent: AppTheme.successColor,
        );
      case SnackbarType.error:
        return const _SnackbarVisuals(
          icon: Icons.error_outline_rounded,
          accent: AppTheme.errorColor,
        );
      case SnackbarType.warning:
        return const _SnackbarVisuals(
          icon: Icons.warning_amber_rounded,
          accent: AppTheme.warningColor,
        );
      case SnackbarType.info:
        return const _SnackbarVisuals(
          icon: Icons.info_outline_rounded,
          accent: AppTheme.accentBlue,
        );
    }
  }
}

class _SnackbarVisuals {
  final IconData icon;
  final Color accent;

  const _SnackbarVisuals({required this.icon, required this.accent});
}
