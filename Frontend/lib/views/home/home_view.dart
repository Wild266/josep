// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart' show Ticker; // ← ticker
// import 'dart:math' as math;

// import '../loginSignup/login_view.dart';
// import '../loginSignup/signup_view.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
//   // ── hero intro animations ────────────────────────────────────────────────
//   late final AnimationController _heroCtrl;
//   late final Animation<double> _fade, _scale, _slide;

//   // ── planet angles driven by one ticker ───────────────────────────────────
//   late final Ticker _planetTicker;
//   double _surfaceAngle = 0; // radians
//   double _cloudAngle = 0; // radians

//   // hover state for the “Log in” link
//   bool _isLoginHovered = false;

//   @override
//   void initState() {
//     super.initState();

//     // hero / entrance animations
//     _heroCtrl = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     )..forward();

//     _fade = Tween(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _heroCtrl, curve: const Interval(0.0, 0.8)),
//     );
//     _scale = Tween(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(
//           parent: _heroCtrl,
//           curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack)),
//     );
//     _slide = Tween(begin: 30.0, end: 0.0).animate(
//       CurvedAnimation(
//           parent: _heroCtrl,
//           curve: const Interval(0.4, 1.0, curve: Curves.easeOut)),
//     );

//     // planet ticker – 30 s per surface revolution, 24 s per cloud revolution
//     _planetTicker = createTicker((elapsed) {
//       setState(() {
//         _surfaceAngle =
//             (elapsed.inMilliseconds / 30000.0) * 2 * math.pi; // 30 s
//         _cloudAngle = (elapsed.inMilliseconds / 24000.0) * 2 * math.pi; // 24 s
//       });
//     })
//       ..start();
//   }

//   @override
//   void dispose() {
//     _heroCtrl.dispose();
//     _planetTicker.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF667eea),
//               Color(0xFF764ba2),
//               Color(0xFF6B8DD6),
//               Color(0xFF8E37D7),
//             ],
//             stops: [0.0, 0.3, 0.7, 1.0],
//           ),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.white.withOpacity(.1),
//                 Colors.white.withOpacity(0),
//               ],
//             ),
//           ),
//           child: SafeArea(
//             child: Column(
//               children: [
//                 // ── header ────────────────────────────────────────────────
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(Icons.calendar_month_rounded,
//                           color: Colors.white, size: 36),
//                       SizedBox(width: 12),
//                       Text(
//                         'Planot',
//                         style: TextStyle(
//                           fontSize: 36,
//                           fontWeight: FontWeight.w800,
//                           color: Colors.white,
//                           letterSpacing: 1.2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // ── main content ──────────────────────────────────────────
//                 Expanded(
//                   child: Center(
//                     child: SingleChildScrollView(
//                       child: Padding(
//                         padding: const EdgeInsets.all(24),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             // ── planet ────────────────────────────────────
//                             FadeTransition(
//                               opacity: _fade,
//                               child: ScaleTransition(
//                                 scale: _scale,
//                                 child: CustomPaint(
//                                   size: const Size.square(360),
//                                   painter: PlanetPainter(
//                                     rotation: _surfaceAngle,
//                                     cloudRotation: _cloudAngle,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 48),

//                             // ── tagline & buttons ────────────────────────
//                             AnimatedBuilder(
//                               animation: _slide,
//                               builder: (_, child) => Transform.translate(
//                                 offset: Offset(0, _slide.value),
//                                 child: FadeTransition(
//                                     opacity: _fade, child: child),
//                               ),
//                               child: Column(
//                                 children: [
//                                   const Text(
//                                     'Plan Smarter, Live Better',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: 32,
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.white,
//                                       letterSpacing: 0.5,
//                                       shadows: [
//                                         Shadow(
//                                           blurRadius: 20,
//                                           color: Colors.black26,
//                                           offset: Offset(0, 5),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(height: 16),
//                                   Text(
//                                     'Your intelligent planning companion\nfor a more organized life',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       height: 1.5,
//                                       color: Colors.white.withOpacity(.9),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 48),

//                                   // CTA button
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(30),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(.3),
//                                           blurRadius: 20,
//                                           offset: const Offset(0, 10),
//                                         ),
//                                       ],
//                                     ),
//                                     child: ElevatedButton(
//                                       onPressed: () => Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (_) => const SignupView()),
//                                       ),
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.white,
//                                         foregroundColor:
//                                             const Color(0xFF764ba2),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 48, vertical: 20),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(30),
//                                         ),
//                                         elevation: 0,
//                                       ),
//                                       child: const Text(
//                                         'Get Started Free',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w700,
//                                           letterSpacing: 0.5,
//                                         ),
//                                       ),
//                                     ),
//                                   ),

//                                   const SizedBox(height: 24),

//                                   // login link with hover
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'Already have an account? ',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.white.withOpacity(.8),
//                                         ),
//                                       ),
//                                       MouseRegion(
//                                         cursor: SystemMouseCursors.click,
//                                         onEnter: (_) => setState(
//                                             () => _isLoginHovered = true),
//                                         onExit: (_) => setState(
//                                             () => _isLoginHovered = false),
//                                         child: GestureDetector(
//                                           onTap: () => Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (_) =>
//                                                     const LoginView()),
//                                           ),
//                                           child: AnimatedContainer(
//                                             duration: const Duration(
//                                                 milliseconds: 200),
//                                             curve: Curves.easeInOut,
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal:
//                                                   _isLoginHovered ? 12 : 4,
//                                               vertical: 4,
//                                             ),
//                                             decoration: BoxDecoration(
//                                               color: _isLoginHovered
//                                                   ? Colors.white
//                                                       .withOpacity(.15)
//                                                   : Colors.transparent,
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                               border: Border.all(
//                                                 color: _isLoginHovered
//                                                     ? Colors.white
//                                                         .withOpacity(.3)
//                                                     : Colors.transparent,
//                                                 width: 1.5,
//                                               ),
//                                             ),
//                                             child: AnimatedDefaultTextStyle(
//                                               duration: const Duration(
//                                                   milliseconds: 200),
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.white,
//                                                 fontWeight: _isLoginHovered
//                                                     ? FontWeight.w700
//                                                     : FontWeight.w600,
//                                                 letterSpacing:
//                                                     _isLoginHovered ? .5 : 0,
//                                                 shadows: _isLoginHovered
//                                                     ? [
//                                                         const Shadow(
//                                                           blurRadius: 10,
//                                                           color: Colors.black26,
//                                                           offset: Offset(0, 2),
//                                                         )
//                                                       ]
//                                                     : [],
//                                               ),
//                                               child: Row(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   const Text('Log in'),
//                                                   AnimatedContainer(
//                                                     duration: const Duration(
//                                                         milliseconds: 200),
//                                                     width:
//                                                         _isLoginHovered ? 8 : 0,
//                                                   ),
//                                                   AnimatedOpacity(
//                                                     duration: const Duration(
//                                                         milliseconds: 200),
//                                                     opacity:
//                                                         _isLoginHovered ? 1 : 0,
//                                                     child: const Icon(
//                                                       Icons
//                                                           .arrow_forward_rounded,
//                                                       size: 16,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  Custom painter for the planet with ring (unchanged from previous step)
// // ─────────────────────────────────────────────────────────────────────────────
// class PlanetPainter extends CustomPainter {
//   final double rotation; // radians
//   final double cloudRotation; // radians
//   PlanetPainter({required this.rotation, required this.cloudRotation});

//   static const double _axisTilt = 0.35;
//   static const double _ringTilt = 0.55;
//   static const double _sunDir = -1.2;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Offset c = size.center(Offset.zero);
//     final double r = size.width * .30;

//     Offset map(double lon, double lat, double rad) {
//       final double x = rad * math.cos(lat) * math.sin(lon);
//       final double y = rad * math.sin(lat);
//       return c + Offset(x, y);
//     }

//     _drawRing(canvas, c, r, isBack: true); // back ring
//     _drawSphere(canvas, c, r, map); // planet body
//     _drawClouds(canvas, c, r, map); // cloud layer
//     _drawRing(canvas, c, r, isBack: false); // front ring
//   }

//   // ---------------- sphere, shading, highlight -----------------------------
//   void _drawSphere(Canvas canvas, Offset c, double r,
//       Offset Function(double, double, double) map) {
//     final Rect sphere = Rect.fromCircle(center: c, radius: r);

//     // base colour
//     final Paint base = Paint()
//       ..shader = RadialGradient(
//         center: const Alignment(-.4, -.4),
//         radius: 1.1,
//         colors: const [Color(0xffc7dcff), Color(0xff1b3d8e)],
//         stops: const [.3, 1],
//       ).createShader(sphere);
//     canvas.drawCircle(c, r, base);

//     // lambert shading
//     final double sunDx = math.cos(_sunDir) * r * 2;
//     final double sunDy = math.sin(_sunDir) * r * 2;
//     final Paint shade = Paint()
//       ..blendMode = BlendMode.multiply
//       ..shader = RadialGradient(
//         center: Alignment(-sunDx / r, -sunDy / r),
//         radius: 1.4,
//         colors: [Colors.transparent, Colors.black87],
//         stops: const [.55, 1],
//       ).createShader(sphere);
//     canvas.drawCircle(c, r, shade);

//     // specular highlight
//     final Offset h = map(rotation + .9, .2, r * .88);
//     canvas.drawCircle(
//       h,
//       r * .20,
//       Paint()
//         ..color = Colors.white.withOpacity(.25)
//         ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20),
//     );
//   }

//   // ---------------- moving cloud bands -------------------------------------
//   void _drawClouds(Canvas canvas, Offset c, double r,
//       Offset Function(double, double, double) map) {
//     final Rect sphere = Rect.fromCircle(center: c, radius: r);
//     final Paint cloudPaint = Paint()
//       ..blendMode = BlendMode.plus
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = r * .02
//       ..shader = RadialGradient(
//         colors: [Colors.white.withOpacity(.12), Colors.white.withOpacity(0)],
//         stops: const [.6, 1],
//       ).createShader(sphere);

//     for (double lat = -.9; lat <= .9; lat += .35) {
//       final Path band = Path();
//       for (double lon = 0; lon <= 2 * math.pi + .1; lon += .15) {
//         final Offset p = map(
//           lon + cloudRotation * .9,
//           lat + math.sin(lon * 3 + cloudRotation) * .05,
//           r * (1.001 + math.sin(lon * 5) * .001),
//         );
//         if (lon == 0) {
//           band.moveTo(p.dx, p.dy);
//         } else {
//           band.lineTo(p.dx, p.dy);
//         }
//       }
//       canvas.drawPath(band, cloudPaint);
//     }
//   }

//   // ---------------- ring (front or back) -----------------------------------
//   void _drawRing(Canvas canvas, Offset c, double planetR,
//       {required bool isBack}) {
//     final double ringR = planetR * 1.9;
//     final double ringW = planetR * .38;

//     canvas.save();
//     canvas.translate(c.dx, c.dy);
//     canvas.rotate(_axisTilt);
//     canvas.scale(1, math.cos(_ringTilt));
//     canvas.translate(-c.dx, -c.dy);

//     final Path full = Path()
//       ..addOval(Rect.fromCircle(center: c, radius: ringR));

//     final metric = full.computeMetrics().first;
//     final Path backHalf = metric.extractPath(0, metric.length / 2);
//     final Path frontHalf = metric.extractPath(metric.length / 2, metric.length);

//     final SweepGradient grad = SweepGradient(
//       startAngle: rotation,
//       endAngle: rotation + 2 * math.pi,
//       colors: isBack
//           ? [
//               Colors.grey.shade700.withOpacity(.15),
//               Colors.grey.shade500.withOpacity(.05),
//             ]
//           : [
//               Colors.white.withOpacity(.8),
//               Colors.grey.shade300.withOpacity(.4),
//               Colors.white.withOpacity(.8),
//             ],
//     );

//     final Paint ringPaint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = ringW
//       ..strokeCap = StrokeCap.round
//       ..shader = grad.createShader(Rect.fromCircle(center: c, radius: ringR));

//     canvas.drawPath(isBack ? backHalf : frontHalf, ringPaint);

//     if (!isBack) {
//       canvas.drawPath(
//         frontHalf.shift(const Offset(4, 6)),
//         Paint()
//           ..color = Colors.black.withOpacity(.25)
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = ringW
//           ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
//       );
//     }

//     canvas.restore();
//   }

//   @override
//   bool shouldRepaint(covariant PlanetPainter old) =>
//       rotation != old.rotation || cloudRotation != old.cloudRotation;
// }

import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../loginSignup/login_view.dart';
import '../loginSignup/signup_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  // For the login link hover effect
  bool _isLoginHovered = false;

  // For mouse tracking
  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePosition = event.position;
        });
      },
      child: Scaffold(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
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
                              // Hero Section with 3D Planet
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: ScaleTransition(
                                  scale: _scaleAnimation,
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 360,
                                      maxHeight: 360,
                                    ),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return CustomPaint(
                                          size: Size(constraints.maxWidth,
                                              constraints.maxHeight),
                                          painter: PlanetPainter(
                                            mousePosition: _mousePosition,
                                            screenSize:
                                                MediaQuery.of(context).size,
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
                                                cursor:
                                                    SystemMouseCursors.click,
                                                onEnter: (_) => setState(() =>
                                                    _isLoginHovered = true),
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          _isLoginHovered
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
                                                                .withOpacity(
                                                                    0.3)
                                                            : Colors
                                                                .transparent,
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
                                                                ? FontWeight
                                                                    .w700
                                                                : FontWeight
                                                                    .w600,
                                                        letterSpacing:
                                                            _isLoginHovered
                                                                ? 0.5
                                                                : 0,
                                                        shadows: _isLoginHovered
                                                            ? [
                                                                const Shadow(
                                                                  blurRadius:
                                                                      10,
                                                                  color: Colors
                                                                      .black26,
                                                                  offset:
                                                                      Offset(
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
                                                            width:
                                                                _isLoginHovered
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
                                                              color:
                                                                  Colors.white,
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
      ),
    );
  }
}

// Custom painter for the 3D planet
class PlanetPainter extends CustomPainter {
  final Offset mousePosition;
  final Size screenSize;

  PlanetPainter({
    required this.mousePosition,
    required this.screenSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    // Calculate rotation based on mouse position
    final dx = (mousePosition.dx - screenSize.width / 2) / screenSize.width;
    final dy = (mousePosition.dy - screenSize.height / 2) / screenSize.height;

    // Limit rotation angles
    final rotationX = dy * math.pi / 4; // Max 45 degrees
    final rotationY = dx * math.pi / 4; // Max 45 degrees

    // Draw planet sphere
    final planetPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // Draw main sphere
    canvas.drawCircle(center, radius, planetPaint);

    // Draw latitude lines
    final latitudePaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int i = -2; i <= 2; i++) {
      if (i == 0) continue; // Skip equator for ring
      final y = center.dy + (i * radius / 3);
      final latRadius = radius * math.cos(math.asin(i / 3));

      final path = Path();
      path.addOval(Rect.fromCenter(
        center: Offset(center.dx, y),
        width: latRadius * 2 * math.cos(rotationX),
        height: latRadius * 0.3,
      ));
      canvas.drawPath(path, latitudePaint);
    }

    // Draw longitude lines
    for (int i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      final path = Path();

      // Create elliptical path for longitude
      final ovalRect = Rect.fromCenter(
        center: center,
        width: radius * 2 * math.sin(angle + rotationY).abs() + 10,
        height: radius * 2,
      );

      path.addArc(ovalRect, -math.pi / 2, math.pi);

      // Apply rotation transform
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);
      canvas.translate(-center.dx, -center.dy);
      canvas.drawPath(path, latitudePaint);
      canvas.restore();
    }

    // Draw ring
    final ringPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final ringPath = Path();
    final ringWidth = radius * 1.4;
    final ringHeight = radius * 0.4;

    // Ring ellipse transformed by mouse position
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotationY * 0.3);

    final ringRect = Rect.fromCenter(
      center: Offset(0, 0),
      width: ringWidth * 2,
      height: ringHeight * 2 * (1 + rotationX * 0.5),
    );

    ringPath.addOval(ringRect);
    canvas.drawPath(ringPath, ringPaint);

    // Add ring shadow/depth
    final ringShadowPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawPath(ringPath, ringShadowPaint);
    canvas.restore();

    // Add glow effect
    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    canvas.drawCircle(center, radius * 1.1, glowPaint);
  }

  @override
  bool shouldRepaint(covariant PlanetPainter oldDelegate) {
    return oldDelegate.mousePosition != mousePosition;
  }
}
