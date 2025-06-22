import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A simple custom painter that draws an interactive 3-D-looking planet
/// whose rotation reacts to the mouse/touch position.
class PlanetPainter extends CustomPainter {
  const PlanetPainter({required this.mousePosition, required this.screenSize});

  final Offset mousePosition;
  final Size screenSize;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    // Rotation based on cursor position (clamped to ±45° on each axis).
    final dx = (mousePosition.dx - screenSize.width / 2) / screenSize.width;
    final dy = (mousePosition.dy - screenSize.height / 2) / screenSize.height;
    final rotationX = dy * math.pi / 4; // max ±45°
    final rotationY = dx * math.pi / 4;

    // ---- planet outline ----
    final planetPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, radius, planetPaint);

    // ---- latitude lines ----
    final latPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int i = -2; i <= 2; i++) {
      if (i == 0) continue; // skip equator (reserved for the ring)
      final y = center.dy + (i * radius / 3);
      final latRadius = radius * math.cos(math.asin(i / 3));

      final path = Path()
        ..addOval(
          Rect.fromCenter(
            center: Offset(center.dx, y),
            width: latRadius * 2 * math.cos(rotationX),
            height: latRadius * 0.3,
          ),
        );
      canvas.drawPath(path, latPaint);
    }

    // ---- longitude lines ----
    for (int i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      final path = Path();

      // Elliptical path for each meridian
      final ovalRect = Rect.fromCenter(
        center: center,
        width: radius * 2 * math.sin(angle + rotationY).abs() + 10,
        height: radius * 2,
      );

      path.addArc(ovalRect, -math.pi / 2, math.pi);

      // rotate around planet centre
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);
      canvas.translate(-center.dx, -center.dy);
      canvas.drawPath(path, latPaint);
      canvas.restore();
    }

    // ---- planet ring ----
    final ringPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    const ringHeightFactor = 0.4;
    final ringWidth = radius * 1.4;
    final ringHeight = radius * ringHeightFactor;

    final ringPath = Path();
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotationY * 0.3); // subtle tilt with mouse

    final ringRect = Rect.fromCenter(
      center: Offset.zero,
      width: ringWidth * 2,
      height: ringHeight * 2 * (1 + rotationX * 0.5),
    );
    ringPath.addOval(ringRect);

    canvas.drawPath(ringPath, ringPaint);

    // blurred shadow for extra depth
    final shadowPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(ringPath, shadowPaint);

    canvas.restore();

    // ---- glow around the planet ----
    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    canvas.drawCircle(center, radius * 1.1, glowPaint);
  }

  @override
  bool shouldRepaint(covariant PlanetPainter oldDelegate) =>
      oldDelegate.mousePosition != mousePosition;
}
