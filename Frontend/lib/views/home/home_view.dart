// import 'package:flutter/material.dart';
// import 'dart:math' as math;
// import '../loginSignup/login_view.dart';
// import '../loginSignup/signup_view.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _slideAnimation;

//   // For the login link hover effect
//   bool _isLoginHovered = false;

//   // For mouse tracking
//   Offset _mousePosition = Offset.zero;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(0.0, 0.8, curve: Curves.easeIn),
//       ),
//     );

//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
//       ),
//     );

//     _slideAnimation = Tween<double>(begin: 30, end: 0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
//       ),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onHover: (event) {
//         setState(() {
//           _mousePosition = event.position;
//         });
//       },
//       child: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color(0xFF667eea), // Purple
//                 Color(0xFF764ba2), // Darker Purple
//                 Color(0xFF6B8DD6), // Blue Purple
//                 Color(0xFF8E37D7), // Vibrant Purple
//               ],
//               stops: [0.0, 0.3, 0.7, 1.0],
//             ),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.white.withOpacity(0.1),
//                   Colors.white.withOpacity(0.0),
//                 ],
//               ),
//             ),
//             child: SafeArea(
//               child: Column(
//                 children: [
//                   // Minimal Header
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 20,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                           Icons.calendar_month_rounded,
//                           color: Colors.white,
//                           size: 36,
//                         ),
//                         const SizedBox(width: 12),
//                         const Text(
//                           'PlanIt',
//                           style: TextStyle(
//                             fontSize: 36,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.white,
//                             letterSpacing: 1.2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Main Content
//                   Expanded(
//                     child: Center(
//                       child: SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.all(24),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               // Hero Section with 3D Planet
//                               FadeTransition(
//                                 opacity: _fadeAnimation,
//                                 child: ScaleTransition(
//                                   scale: _scaleAnimation,
//                                   child: Container(
//                                     constraints: const BoxConstraints(
//                                       maxWidth: 360,
//                                       maxHeight: 360,
//                                     ),
//                                     child: LayoutBuilder(
//                                       builder: (context, constraints) {
//                                         return CustomPaint(
//                                           size: Size(
//                                             constraints.maxWidth,
//                                             constraints.maxHeight,
//                                           ),
//                                           painter: PlanetPainter(
//                                             mousePosition: _mousePosition,
//                                             screenSize: MediaQuery.of(
//                                               context,
//                                             ).size,
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                               const SizedBox(height: 48),

//                               // Content Section
//                               AnimatedBuilder(
//                                 animation: _slideAnimation,
//                                 builder: (context, child) {
//                                   return Transform.translate(
//                                     offset: Offset(0, _slideAnimation.value),
//                                     child: FadeTransition(
//                                       opacity: _fadeAnimation,
//                                       child: Column(
//                                         children: [
//                                           // Tagline
//                                           const Text(
//                                             'Plan Smarter, Live Better',
//                                             style: TextStyle(
//                                               fontSize: 32,
//                                               fontWeight: FontWeight.w700,
//                                               color: Colors.white,
//                                               letterSpacing: 0.5,
//                                               shadows: [
//                                                 Shadow(
//                                                   blurRadius: 20,
//                                                   color: Colors.black26,
//                                                   offset: Offset(0, 5),
//                                                 ),
//                                               ],
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                           const SizedBox(height: 16),
//                                           Text(
//                                             'Enjoy your trip\nWe\'ll take care of the rest',
//                                             style: TextStyle(
//                                               fontSize: 18,
//                                               color: Colors.white.withOpacity(
//                                                 0.9,
//                                               ),
//                                               height: 1.5,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                           const SizedBox(height: 48),

//                                           // Primary CTA Button
//                                           Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(30),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.black
//                                                       .withOpacity(0.3),
//                                                   blurRadius: 20,
//                                                   offset: const Offset(0, 10),
//                                                 ),
//                                               ],
//                                             ),
//                                             child: ElevatedButton(
//                                               onPressed: () => Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (_) =>
//                                                       const SignupView(),
//                                                 ),
//                                               ),
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.white,
//                                                 foregroundColor: const Color(
//                                                   0xFF764ba2,
//                                                 ),
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                       horizontal: 48,
//                                                       vertical: 20,
//                                                     ),
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(30),
//                                                 ),
//                                                 elevation: 0,
//                                               ),
//                                               child: const Text(
//                                                 'Get Started Free',
//                                                 style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.w700,
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),

//                                           const SizedBox(height: 24),

//                                           // Login Link with Hover Effect
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text(
//                                                 'Already have an account? ',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Colors.white
//                                                       .withOpacity(0.8),
//                                                 ),
//                                               ),
//                                               MouseRegion(
//                                                 cursor:
//                                                     SystemMouseCursors.click,
//                                                 onEnter: (_) => setState(
//                                                   () => _isLoginHovered = true,
//                                                 ),
//                                                 onExit: (_) => setState(
//                                                   () => _isLoginHovered = false,
//                                                 ),
//                                                 child: GestureDetector(
//                                                   onTap: () => Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                       builder: (_) =>
//                                                           const LoginView(),
//                                                     ),
//                                                   ),
//                                                   child: AnimatedContainer(
//                                                     duration: const Duration(
//                                                       milliseconds: 200,
//                                                     ),
//                                                     curve: Curves.easeInOut,
//                                                     padding:
//                                                         EdgeInsets.symmetric(
//                                                           horizontal:
//                                                               _isLoginHovered
//                                                               ? 12
//                                                               : 4,
//                                                           vertical: 4,
//                                                         ),
//                                                     decoration: BoxDecoration(
//                                                       color: _isLoginHovered
//                                                           ? Colors.white
//                                                                 .withOpacity(
//                                                                   0.15,
//                                                                 )
//                                                           : Colors.transparent,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                             20,
//                                                           ),
//                                                       border: Border.all(
//                                                         color: _isLoginHovered
//                                                             ? Colors.white
//                                                                   .withOpacity(
//                                                                     0.3,
//                                                                   )
//                                                             : Colors
//                                                                   .transparent,
//                                                         width: 1.5,
//                                                       ),
//                                                     ),
//                                                     child: AnimatedDefaultTextStyle(
//                                                       duration: const Duration(
//                                                         milliseconds: 200,
//                                                       ),
//                                                       style: TextStyle(
//                                                         fontSize: 16,
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             _isLoginHovered
//                                                             ? FontWeight.w700
//                                                             : FontWeight.w600,
//                                                         letterSpacing:
//                                                             _isLoginHovered
//                                                             ? 0.5
//                                                             : 0,
//                                                         shadows: _isLoginHovered
//                                                             ? [
//                                                                 const Shadow(
//                                                                   blurRadius:
//                                                                       10,
//                                                                   color: Colors
//                                                                       .black26,
//                                                                   offset:
//                                                                       Offset(
//                                                                         0,
//                                                                         2,
//                                                                       ),
//                                                                 ),
//                                                               ]
//                                                             : [],
//                                                       ),
//                                                       child: Row(
//                                                         mainAxisSize:
//                                                             MainAxisSize.min,
//                                                         children: [
//                                                           const Text('Log in'),
//                                                           AnimatedContainer(
//                                                             duration:
//                                                                 const Duration(
//                                                                   milliseconds:
//                                                                       200,
//                                                                 ),
//                                                             width:
//                                                                 _isLoginHovered
//                                                                 ? 8
//                                                                 : 0,
//                                                           ),
//                                                           AnimatedOpacity(
//                                                             duration:
//                                                                 const Duration(
//                                                                   milliseconds:
//                                                                       200,
//                                                                 ),
//                                                             opacity:
//                                                                 _isLoginHovered
//                                                                 ? 1.0
//                                                                 : 0.0,
//                                                             child: const Icon(
//                                                               Icons
//                                                                   .arrow_forward_rounded,
//                                                               size: 16,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Custom painter for the 3D planet
// class PlanetPainter extends CustomPainter {
//   final Offset mousePosition;
//   final Size screenSize;

//   PlanetPainter({required this.mousePosition, required this.screenSize});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 3;

//     // Calculate rotation based on mouse position
//     final dx = (mousePosition.dx - screenSize.width / 2) / screenSize.width;
//     final dy = (mousePosition.dy - screenSize.height / 2) / screenSize.height;

//     // Limit rotation angles
//     final rotationX = dy * math.pi / 4; // Max 45 degrees
//     final rotationY = dx * math.pi / 4; // Max 45 degrees

//     // Draw planet sphere
//     final planetPaint = Paint()
//       ..color = Colors.white.withOpacity(0.2)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3.0;

//     // Draw main sphere
//     canvas.drawCircle(center, radius, planetPaint);

//     // Draw latitude lines
//     final latitudePaint = Paint()
//       ..color = Colors.white.withOpacity(0.1)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.5;

//     for (int i = -2; i <= 2; i++) {
//       if (i == 0) continue; // Skip equator for ring
//       final y = center.dy + (i * radius / 3);
//       final latRadius = radius * math.cos(math.asin(i / 3));

//       final path = Path();
//       path.addOval(
//         Rect.fromCenter(
//           center: Offset(center.dx, y),
//           width: latRadius * 2 * math.cos(rotationX),
//           height: latRadius * 0.3,
//         ),
//       );
//       canvas.drawPath(path, latitudePaint);
//     }

//     // Draw longitude lines
//     for (int i = 0; i < 8; i++) {
//       final angle = i * math.pi / 4;
//       final path = Path();

//       // Create elliptical path for longitude
//       final ovalRect = Rect.fromCenter(
//         center: center,
//         width: radius * 2 * math.sin(angle + rotationY).abs() + 10,
//         height: radius * 2,
//       );

//       path.addArc(ovalRect, -math.pi / 2, math.pi);

//       // Apply rotation transform
//       canvas.save();
//       canvas.translate(center.dx, center.dy);
//       canvas.rotate(angle);
//       canvas.translate(-center.dx, -center.dy);
//       canvas.drawPath(path, latitudePaint);
//       canvas.restore();
//     }

//     // Draw ring
//     final ringPaint = Paint()
//       ..color = Colors.white.withOpacity(0.4)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4.0;

//     final ringPath = Path();
//     final ringWidth = radius * 1.4;
//     final ringHeight = radius * 0.4;

//     // Ring ellipse transformed by mouse position
//     canvas.save();
//     canvas.translate(center.dx, center.dy);
//     canvas.rotate(rotationY * 0.3);

//     final ringRect = Rect.fromCenter(
//       center: Offset(0, 0),
//       width: ringWidth * 2,
//       height: ringHeight * 2 * (1 + rotationX * 0.5),
//     );

//     ringPath.addOval(ringRect);
//     canvas.drawPath(ringPath, ringPaint);

//     // Add ring shadow/depth
//     final ringShadowPaint = Paint()
//       ..color = Colors.white.withOpacity(0.2)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 8.0
//       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

//     canvas.drawPath(ringPath, ringShadowPaint);
//     canvas.restore();

//     // Add glow effect
//     final glowPaint = Paint()
//       ..color = Colors.white.withOpacity(0.1)
//       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

//     canvas.drawCircle(center, radius * 1.1, glowPaint);
//   }

//   @override
//   bool shouldRepaint(covariant PlanetPainter oldDelegate) {
//     return oldDelegate.mousePosition != mousePosition;
//   }
// }

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_sign_in/google_sign_in.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  // Modal animation controllers
  late AnimationController _modalController;
  late Animation<double> _modalFadeAnimation;
  late Animation<double> _modalScaleAnimation;

  // For the login link hover effect
  bool _isLoginHovered = false;

  // For mouse tracking
  Offset _mousePosition = Offset.zero;

  // Modal state
  bool _showModal = false;
  bool _isLoginMode = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _modalController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _slideAnimation = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _modalFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _modalController, curve: Curves.easeInOut),
    );

    _modalScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _modalController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _modalController.dispose();
    super.dispose();
  }

  void _showAuthModal(bool isLogin) {
    setState(() {
      _isLoginMode = isLogin;
      _showModal = true;
    });
    _modalController.forward();
  }

  void _hideModal() {
    _modalController.reverse().then((_) {
      setState(() {
        _showModal = false;
      });
    });
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
        body: Stack(
          children: [
            // Main content
            Container(
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
                          horizontal: 24,
                          vertical: 20,
                        ),
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
                                              size: Size(
                                                constraints.maxWidth,
                                                constraints.maxHeight,
                                              ),
                                              painter: PlanetPainter(
                                                mousePosition: _mousePosition,
                                                screenSize: MediaQuery.of(
                                                  context,
                                                ).size,
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
                                        offset: Offset(
                                          0,
                                          _slideAnimation.value,
                                        ),
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
                                                  color: Colors.white
                                                      .withOpacity(0.9),
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
                                                      offset: const Offset(
                                                        0,
                                                        10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: ElevatedButton(
                                                  onPressed: () =>
                                                      _showAuthModal(false),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        const Color(0xFF764ba2),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 48,
                                                          vertical: 20,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            30,
                                                          ),
                                                    ),
                                                    elevation: 0,
                                                  ),
                                                  child: const Text(
                                                    'Get Started Free',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                                    cursor: SystemMouseCursors
                                                        .click,
                                                    onEnter: (_) => setState(
                                                      () => _isLoginHovered =
                                                          true,
                                                    ),
                                                    onExit: (_) => setState(
                                                      () => _isLoginHovered =
                                                          false,
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          _showAuthModal(true),
                                                      child: AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                              milliseconds: 200,
                                                            ),
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
                                                                    .withOpacity(
                                                                      0.15,
                                                                    )
                                                              : Colors
                                                                    .transparent,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                          border: Border.all(
                                                            color:
                                                                _isLoginHovered
                                                                ? Colors.white
                                                                      .withOpacity(
                                                                        0.3,
                                                                      )
                                                                : Colors
                                                                      .transparent,
                                                            width: 1.5,
                                                          ),
                                                        ),
                                                        child: AnimatedDefaultTextStyle(
                                                          duration:
                                                              const Duration(
                                                                milliseconds:
                                                                    200,
                                                              ),
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
                                                            shadows:
                                                                _isLoginHovered
                                                                ? [
                                                                    const Shadow(
                                                                      blurRadius:
                                                                          10,
                                                                      color: Colors
                                                                          .black26,
                                                                      offset:
                                                                          Offset(
                                                                            0,
                                                                            2,
                                                                          ),
                                                                    ),
                                                                  ]
                                                                : [],
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              const Text(
                                                                'Log in',
                                                              ),
                                                              AnimatedContainer(
                                                                duration:
                                                                    const Duration(
                                                                      milliseconds:
                                                                          200,
                                                                    ),
                                                                width:
                                                                    _isLoginHovered
                                                                    ? 8
                                                                    : 0,
                                                              ),
                                                              AnimatedOpacity(
                                                                duration:
                                                                    const Duration(
                                                                      milliseconds:
                                                                          200,
                                                                    ),
                                                                opacity:
                                                                    _isLoginHovered
                                                                    ? 1.0
                                                                    : 0.0,
                                                                child: const Icon(
                                                                  Icons
                                                                      .arrow_forward_rounded,
                                                                  size: 16,
                                                                  color: Colors
                                                                      .white,
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

            // Modal overlay
            if (_showModal)
              GestureDetector(
                onTap: _hideModal,
                child: FadeTransition(
                  opacity: _modalFadeAnimation,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {}, // Prevent closing when tapping the card
                        child: ScaleTransition(
                          scale: _modalScaleAnimation,
                          child: _isLoginMode
                              ? LoginCard(
                                  onClose: _hideModal,
                                  onSwitchToSignup: () {
                                    setState(() {
                                      _isLoginMode = false;
                                    });
                                  },
                                )
                              : SignupCard(
                                  onClose: _hideModal,
                                  onSwitchToLogin: () {
                                    setState(() {
                                      _isLoginMode = true;
                                    });
                                  },
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Login Card Widget
class LoginCard extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onSwitchToSignup;

  const LoginCard({
    Key? key,
    required this.onClose,
    required this.onSwitchToSignup,
  }) : super(key: key);

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> _handleGoogleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final account = await googleSignIn.signIn();
      if (account != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signed in as ${account.displayName}')),
        );
        widget.onClose();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google sign in failed: $error')),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF667eea).withOpacity(0.1),
                  const Color(0xFF764ba2).withOpacity(0.1),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF764ba2),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sign in to continue',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: widget.onClose,
                  icon: const Icon(Icons.close, color: Color(0xFF764ba2)),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Form content
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Username field
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 20),

                // Password field
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 12),

                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Handle forgotten password
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color(0xFF764ba2)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Sign in button
                ElevatedButton(
                  onPressed: () {
                    final username = _usernameController.text;
                    final password = _passwordController.text;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Username: $username, Password: $password',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF764ba2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[300])),
                  ],
                ),
                const SizedBox(height: 20),

                // Google sign in
                OutlinedButton.icon(
                  icon: Image.asset(
                    'assets/googlelogo.png',
                    height: 24,
                    width: 24,
                  ),
                  label: const Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: _handleGoogleSignIn,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: Colors.grey[300]!),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: widget.onSwitchToSignup,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF764ba2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Signup Card Widget
class SignupCard extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onSwitchToLogin;

  const SignupCard({
    Key? key,
    required this.onClose,
    required this.onSwitchToLogin,
  }) : super(key: key);

  @override
  State<SignupCard> createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _handleGoogleSignUp() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final account = await googleSignIn.signIn();
      if (account != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signed up as ${account.displayName}')),
        );
        widget.onClose();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google sign up failed: $error')),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF667eea).withOpacity(0.1),
                  const Color(0xFF764ba2).withOpacity(0.1),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF764ba2),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Start your planning journey',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: widget.onClose,
                  icon: const Icon(Icons.close, color: Color(0xFF764ba2)),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Form content
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Username field
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 16),

                // Email field
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 16),

                // Password field
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 16),

                // Confirm password field
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 24),

                // Sign up button
                ElevatedButton(
                  onPressed: () {
                    final username = _usernameController.text;
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final confirmPassword = _confirmPasswordController.text;

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Passwords do not match')),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Signed up as $username ($email)'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF764ba2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[300])),
                  ],
                ),
                const SizedBox(height: 20),

                // Google sign up
                OutlinedButton.icon(
                  icon: Image.asset(
                    'assets/googlelogo.png',
                    height: 24,
                    width: 24,
                  ),
                  label: const Text(
                    'Sign up with Google',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: _handleGoogleSignUp,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: Colors.grey[300]!),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                      onPressed: widget.onSwitchToLogin,
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: Color(0xFF764ba2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the 3D planet (remains the same)
class PlanetPainter extends CustomPainter {
  final Offset mousePosition;
  final Size screenSize;

  PlanetPainter({required this.mousePosition, required this.screenSize});

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
      path.addOval(
        Rect.fromCenter(
          center: Offset(center.dx, y),
          width: latRadius * 2 * math.cos(rotationX),
          height: latRadius * 0.3,
        ),
      );
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
