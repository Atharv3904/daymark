import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:daymark_tracking/core/theme/app_theme.dart';

/// Ambient dark Liquid Glass background with optional back button.
class AuthBackground extends StatelessWidget {
  final Widget child;
  final bool showBackButton;
  final VoidCallback? onBack;

  const AuthBackground({
    super.key,
    required this.child,
    this.showBackButton = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgObsidian,
      body: Stack(
        children: <Widget>[
          const _AmbientGlow(
            alignment: Alignment.topRight,
            color: Color(0x557B3FE4),
            size: 280,
          ),
          const _AmbientGlow(
            alignment: Alignment.bottomLeft,
            color: Color(0x444C8DFF),
            size: 320,
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (showBackButton)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _GlassCircleButton(
                        icon: Icons.chevron_left_rounded,
                        onPressed:
                            onBack ??
                            () {
                              if (context.canPop()) context.pop();
                            },
                      ),
                    )
                  else
                    const SizedBox(height: 44),
                  const SizedBox(height: 12),
                  child,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  final Alignment alignment;
  final Color color;
  final double size;

  const _AmbientGlow({
    required this.alignment,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: <Color>[color, Colors.transparent]),
        ),
      ),
    );
  }
}

class _GlassCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _GlassCircleButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.glassFill,
          border: Border.all(color: AppTheme.glassBorder),
        ),
        child: Icon(icon, color: AppTheme.textPrimary, size: 24),
      ),
    );
  }
}
