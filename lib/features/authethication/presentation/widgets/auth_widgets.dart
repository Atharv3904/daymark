import 'dart:ui';

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

/// Frosted Liquid Glass card container.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: padding,
          decoration: AppTheme.glassCardDecoration(),
          child: child,
        ),
      ),
    );
  }
}

/// Pill-shaped frosted glass text input field.
class GlassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  const GlassTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, color: AppTheme.textSecondary, size: 20),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

/// Gradient pill CTA button with loading state.
class GradientSubmitButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  const GradientSubmitButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppTheme.primaryButtonGradient,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x444C8DFF),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
      ),
    );
  }
}
