import 'package:flutter/material.dart';

import 'planet_widget.dart';
import 'auth/login_card.dart';
import 'auth/signup_card.dart';
import '../../../objects/user_session.dart' as user_session;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  // ---------- mouse ----------
  final ValueNotifier<Offset> _mouse = ValueNotifier(Offset.zero);

  // ---------- animations ----------
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _slideAnimation;

  late final AnimationController _modalController;
  late final Animation<double> _modalFadeAnimation;
  late final Animation<double> _modalScaleAnimation;

  // ---------- UI state ----------
  bool _isLoginHovered = false;
  bool _showModal = false;
  bool _isLoginMode = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _modalController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, .8, curve: Curves.easeIn),
      ),
    );
    _scaleAnimation = Tween<double>(begin: .8, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(.2, 1, curve: Curves.easeOutBack),
      ),
    );
    _slideAnimation = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(.4, 1, curve: Curves.easeOut),
      ),
    );

    _modalFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _modalController, curve: Curves.easeInOut),
    );
    _modalScaleAnimation = Tween<double>(begin: .8, end: 1).animate(
      CurvedAnimation(parent: _modalController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _modalController.dispose();
    _mouse.dispose();
    super.dispose();
  }

  // ---------- modal helpers ----------
  void _showAuthModal(bool isLogin) {
    setState(() {
      _isLoginMode = isLogin;
      _showModal = true;
    });
    _modalController.forward();
  }

  void _hideModal() {
    _modalController.reverse().then((_) {
      if (!mounted) return;
      setState(() => _showModal = false);
    });
  }

  // ---------- build ----------
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // tracks mouse EVERYWHERE
      onHover: (e) {
        if (!_showModal)
          _mouse.value = e.position; // ignore while modal visible
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackground(context),
            if (_showModal) _buildAuthModal(),
          ],
        ),
      ),
    );
  }

  // ====== background & main content ======
  Widget _buildBackground(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 218, 164, 206),
            Color.fromARGB(255, 203, 156, 132),
            Color.fromARGB(255, 70, 133, 81),
            Color.fromARGB(255, 227, 220, 122),
            Color.fromARGB(255, 255, 252, 245),
          ],
          stops: [0, 0.25, 0.5, 0.85, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white.withOpacity(.1), Colors.white.withOpacity(0)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(child: _buildBody(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.calendar_month_rounded, color: Colors.white, size: 36),
              SizedBox(width: 12),
              Text(
                'PlanIt',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        if (user_session.UserSession.username != null)
            Padding(
              padding: const EdgeInsets.only(right: 50), // Adjust the value as needed
              child:
              GestureDetector(
                onTapDown: (details) async {
                  final selected = await showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      details.globalPosition.dx,
                      details.globalPosition.dy + 40,
                      details.globalPosition.dx,
                      details.globalPosition.dy + 40,
                    ),
                    items: [
                      PopupMenuItem(
                        value: 'profile',
                        child: Text('Profile'),
                      ),
                      PopupMenuItem(
                        value: 'itineraries',
                        child: Text('Your Itineraries'),
                      ),
                      PopupMenuItem(
                        value: 'signout',
                        child: Text('Sign Out'),
                      ),
                    ],
                  );
                  if (selected == 'profile') {
                    // TODO: Navigate to profile page
                  } else if (selected == 'itineraries') {
                    // TODO: Navigate to itineraries page
                  } else if (selected == 'signout') {
                    user_session.UserSession.username = null;
                    setState(() {}); // This will refresh the UI and hide user-only widgets
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    user_session.UserSession.username![0].toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF764ba2),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: PlanetWidget(mouse: _mouse),
                      ),
                    ),
                    // Overlayed buttons
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 170),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 250, // Set your desired width
                              child: ElevatedButton(
                                onPressed: () {
                                  // TODO: Navigate to Make Itinerary page
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF764ba2),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'Make an Itinerary',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            SizedBox(
                              width: 250, // Set your desired width
                              child: ElevatedButton(
                                onPressed: () {
                                  // TODO: Navigate to Search Itineraries page
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF764ba2),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'Search Our Itineraries',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 48),
            _buildContentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _slideAnimation.value),
        child: FadeTransition(opacity: _fadeAnimation, child: child),
      ),
      child: Column(
        children: [
          const Text(
            'Plan Smarter, Live Better',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: .5,
              shadows: [
                Shadow(
                  blurRadius: 20,
                  color: Colors.black26,
                  offset: Offset(0, 5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Your intelligent planning companion\nfor a more organized life',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              height: 1.5,
              color: Colors.white.withOpacity(.9),
            ),
          ),
          const SizedBox(height: 48),
          _buildPrimaryCta(),
          const SizedBox(height: 24),
          _buildLoginLink(),
        ],
      ),
    );
  }

  Widget _buildPrimaryCta() {
    if (user_session.UserSession.username != null) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _showAuthModal(false),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF764ba2),
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Get Started Free',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    if (user_session.UserSession.username != null) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(.8)),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _isLoginHovered = true),
          onExit: (_) => setState(() => _isLoginHovered = false),
          child: GestureDetector(
            onTap: () => _showAuthModal(true),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: _isLoginHovered ? 12 : 4,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: _isLoginHovered
                    ? Colors.white.withOpacity(.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isLoginHovered
                      ? Colors.white.withOpacity(.3)
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: _isLoginHovered
                      ? FontWeight.w700
                      : FontWeight.w600,
                  letterSpacing: _isLoginHovered ? .5 : 0,
                  shadows: _isLoginHovered
                      ? [
                          const Shadow(
                            blurRadius: 10,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Log in'),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: _isLoginHovered ? 8 : 0,
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _isLoginHovered ? 1 : 0,
                      child: const Icon(
                        Icons.arrow_forward_rounded,
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
    );
  }

  // ====== modal ======
  Widget _buildAuthModal() {
    return GestureDetector(
      onTap: _hideModal,
      child: FadeTransition(
        opacity: _modalFadeAnimation,
        child: Container(
          color: Colors.black.withOpacity(.5),
          child: Center(
            child: GestureDetector(
              onTap: () {}, // stop tap-through
              child: ScaleTransition(
                scale: _modalScaleAnimation,
                child: _isLoginMode
                    ? LoginCard(
                        onClose: _hideModal,
                        onSwitchToSignup: () =>
                            setState(() => _isLoginMode = false),
                      )
                    : SignupCard(
                        onClose: _hideModal,
                        onSwitchToLogin: () =>
                            setState(() => _isLoginMode = true),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
