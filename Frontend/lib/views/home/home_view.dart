import 'package:flutter/material.dart';
import '../loginSignup/login_view.dart';
import '../loginSignup/signup_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 112, // Twice the default height
        title: const Text(
          'PlanIt',
            style: TextStyle(
            fontFamily: 'Brioso', // Change this to your desired font
            fontWeight: FontWeight.bold,
            fontSize: 28, // Slightly larger for emphasis
            letterSpacing: 2, // Optional: adds spacing between letters
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView()),);
            },
            child: const Text('Log In', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupView()),);
            },
            child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 16),
        ],
        backgroundColor: Colors.blueAccent, // Zesty blue color
        elevation: 4,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            Image.asset(
              'assets/planitlogo.jpg',
              width: 600,
              height: 600,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}