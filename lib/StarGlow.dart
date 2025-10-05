import 'dart:math';

import 'package:flutter/material.dart';

class StarGlow extends StatelessWidget {
  final double size;
  final Color glowColor;
  final Color rayColor;

  const StarGlow({super.key, required this.size, required this.glowColor, required this.rayColor, });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: StarGlowPainter(glowColor,rayColor),
    );
  }
}

class StarGlowPainter extends CustomPainter {
  final Color glowColor;
  final Color rayColor;

  StarGlowPainter(this.glowColor, this.rayColor);

  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = glowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    final center = Offset(size.width / 2, size.height / 2);

    // Draw glow
    canvas.drawCircle(center, size.width * 0.15, paint);

    // Draw star rays
    final rayPaint = Paint()
      ..shader = RadialGradient(
        colors: [rayColor, Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: size.width / 2));

    for (int i = 0; i < 8; i++) {
      double angle = (pi / 4) * i;
      final dx = cos(angle) * size.width * 0.5;
      final dy = sin(angle) * size.width * 0.5;
      canvas.drawLine(center, center + Offset(dx, dy), rayPaint..strokeWidth = 2);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}