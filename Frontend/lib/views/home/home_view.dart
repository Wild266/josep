import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../loginSignup/login_view.dart';
import '../loginSignup/signup_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _rotationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  // For the login link hover effect
  bool _isLoginHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Continuous rotation for the planet
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeIn),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
    ));

    _slideAnimation = Tween<double>(
      begin: 30,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea), // Purple
              Color(0xFF764ba2), // Darker Purple
              Color(0xFF6B8DD6), // Blue Purple
              Color(0xFF8E37D7), // Vibrant Purple
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.0),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Minimal Header
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.white,
                        size: 36,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Planot',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Content
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 3D Planet with Ring
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: ScaleTransition(
                                scale: _scaleAnimation,
                                child: Container(
                                  width: 360,
                                  height: 360,
                                  child: AnimatedBuilder(
                                    animation: _rotationController,
                                    builder: (context, child) {
                                      return CustomPaint(
                                        painter: PlanetPainter(
                                          rotation: _rotationController.value *
                                              2 *
                                              math.pi,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 48),

                            // Content Section
                            AnimatedBuilder(
                              animation: _slideAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _slideAnimation.value),
                                  child: FadeTransition(
                                    opacity: _fadeAnimation,
                                    child: Column(
                                      children: [
                                        // Tagline
                                        const Text(
                                          'Plan Smarter, Live Better',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 20,
                                                color: Colors.black26,
                                                offset: Offset(0, 5),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Your intelligent planning companion\nfor a more organized life',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            height: 1.5,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 48),

                                        // Primary CTA Button
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                blurRadius: 20,
                                                offset: const Offset(0, 10),
                                              ),
                                            ],
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const SignupView()),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              foregroundColor:
                                                  const Color(0xFF764ba2),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 48,
                                                vertical: 20,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              elevation: 0,
                                            ),
                                            child: const Text(
                                              'Get Started Free',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 24),

                                        // Login Link with Hover Effect
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Already have an account? ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                            MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              onEnter: (_) => setState(
                                                  () => _isLoginHovered = true),
                                              onExit: (_) => setState(() =>
                                                  _isLoginHovered = false),
                                              child: GestureDetector(
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          const LoginView()),
                                                ),
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 200),
                                                  curve: Curves.easeInOut,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: _isLoginHovered
                                                        ? 12
                                                        : 4,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: _isLoginHovered
                                                        ? Colors.white
                                                            .withOpacity(0.15)
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                      color: _isLoginHovered
                                                          ? Colors.white
                                                              .withOpacity(0.3)
                                                          : Colors.transparent,
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                  child:
                                                      AnimatedDefaultTextStyle(
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          _isLoginHovered
                                                              ? FontWeight.w700
                                                              : FontWeight.w600,
                                                      letterSpacing:
                                                          _isLoginHovered
                                                              ? 0.5
                                                              : 0,
                                                      shadows: _isLoginHovered
                                                          ? [
                                                              const Shadow(
                                                                blurRadius: 10,
                                                                color: Colors
                                                                    .black26,
                                                                offset: Offset(
                                                                    0, 2),
                                                              ),
                                                            ]
                                                          : [],
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Text('Log in'),
                                                        AnimatedContainer(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      200),
                                                          width: _isLoginHovered
                                                              ? 8
                                                              : 0,
                                                        ),
                                                        AnimatedOpacity(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      200),
                                                          opacity:
                                                              _isLoginHovered
                                                                  ? 1.0
                                                                  : 0.0,
                                                          child: const Icon(
                                                            Icons
                                                                .arrow_forward_rounded,
                                                            size: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Painter for 3D Planet with Ring
class PlanetPainter extends CustomPainter {
  final double rotation;

  PlanetPainter({required this.rotation});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final planetRadius = size.width * 0.3;

    // Draw planet shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    canvas.drawCircle(
      center + const Offset(10, 15),
      planetRadius,
      shadowPaint,
    );

    // Draw ring back part (behind planet)
    _drawRingPart(canvas, center, planetRadius, rotation, true);

    // Draw planet
    final planetPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        radius: 1.2,
        colors: [
          Colors.blue.shade100,
          Colors.blue.shade300,
          Colors.blue.shade600,
          Colors.blue.shade900,
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: planetRadius));

    canvas.drawCircle(center, planetRadius, planetPaint);

    // Draw planet surface details
    _drawPlanetDetails(canvas, center, planetRadius, rotation);

    // Draw ring front part (in front of planet)
    _drawRingPart(canvas, center, planetRadius, rotation, false);

    // Add glow effect
    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    canvas.drawCircle(center, planetRadius * 1.1, glowPaint);
  }

  void _drawPlanetDetails(
      Canvas canvas, Offset center, double radius, double rotation) {
    final detailPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw latitude lines
    for (double lat = -60; lat <= 60; lat += 30) {
      final y = center.dy + (lat / 90) * radius;
      final width = radius * math.cos(lat * math.pi / 180);

      if (width > 0) {
        final path = Path();
        path.moveTo(center.dx - width, y);

        // Create curved line effect
        for (double x = -width; x <= width; x += 5) {
          final angle = (x / width) * math.pi / 2;
          final yOffset = math.sin(angle + rotation) * 5;
          path.lineTo(center.dx + x, y + yOffset);
        }

        canvas.drawPath(path, detailPaint);
      }
    }
  }

  void _drawRingPart(Canvas canvas, Offset center, double planetRadius,
      double rotation, bool isBack) {
    final ringRadius = planetRadius * 1.8;
    final ringWidth = planetRadius * 0.4;

    final path = Path();
    final rect = Rect.fromCenter(
      center: center,
      width: ringRadius * 2,
      height: ringRadius * 0.7, // Elliptical ring
    );

    // Calculate the angle where ring intersects planet
    final intersectionAngle = math.asin(planetRadius / ringRadius);

    double startAngle, sweepAngle;
    if (isBack) {
      startAngle = intersectionAngle;
      sweepAngle = math.pi - 2 * intersectionAngle;
    } else {
      startAngle = math.pi + intersectionAngle;
      sweepAngle = math.pi - 2 * intersectionAngle;
    }

    // Apply rotation
    startAngle += rotation * 0.5;

    path.addArc(rect, startAngle, sweepAngle);

    // Create gradient for ring
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isBack
          ? [
              Colors.grey.shade600.withOpacity(0.3),
              Colors.grey.shade400.withOpacity(0.2),
            ]
          : [
              Colors.white.withOpacity(0.6),
              Colors.grey.shade300.withOpacity(0.4),
            ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = ringWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);

    // Add ring shadow
    if (!isBack) {
      final shadowPath = Path();
      shadowPath.addArc(rect.translate(5, 10), startAngle, sweepAngle);

      final shadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.2)
        ..strokeWidth = ringWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawPath(shadowPath, shadowPaint);
    }

    // Add ring shimmer effect
    if (!isBack) {
      final shimmerPath = Path();
      shimmerPath.addArc(rect, startAngle + sweepAngle * 0.3, sweepAngle * 0.2);

      final shimmerPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withOpacity(0.0),
            Colors.white.withOpacity(0.8),
            Colors.white.withOpacity(0.0),
          ],
        ).createShader(rect)
        ..strokeWidth = ringWidth * 0.6
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(shimmerPath, shimmerPaint);
    }
  }

  @override
  bool shouldRepaint(PlanetPainter oldDelegate) {
    return rotation != oldDelegate.rotation;
  }
}
