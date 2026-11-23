// lib/features/authethication/presentation/widgets/auth_background.dart
//
// Background container with dark navy color and subtle bottom ambient wave,
// matching the visual reference screens.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:daymark_tracking/core/theme/app_theme.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({
    super.key,
    required this.child,
    this.showBackButton = false,
    this.onBack,
  });

  final Widget child;
  final bool showBackButton;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Bottom ambient wave
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 180,
            child: CustomPaint(painter: _BottomWavePainter()),
          ),
          // Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top App Bar / Back button area
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      if (showBackButton)
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: onBack ?? () => context.pop(),
                        )
                      else
                        const SizedBox(height: 48),
                    ],
                  ),
                ),
                // Main scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0x3338237F), Color(0x66211550)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path1 = Path()
      ..moveTo(0, size.height * 0.4)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.1,
        size.width * 0.5,
        size.height * 0.35,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.6,
        size.width,
        size.height * 0.25,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path1, paint1);

    final paint2 = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0x55442898), Color(0x99190E3F)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path2 = Path()
      ..moveTo(0, size.height * 0.65)
      ..quadraticBezierTo(
        size.width * 0.35,
        size.height * 0.35,
        size.width * 0.65,
        size.height * 0.6,
      )
      ..quadraticBezierTo(
        size.width * 0.85,
        size.height * 0.75,
        size.width,
        size.height * 0.55,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
