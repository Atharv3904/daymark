import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:daymark_tracking/core/theme/app_theme.dart';

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
