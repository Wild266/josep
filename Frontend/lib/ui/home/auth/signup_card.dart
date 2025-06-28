import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:http/http.dart' as http;
import '../../../apicalls/user_apis.dart' as user_apis;

/// Authentication card shown when the user chooses “Sign Up”.
/// Contains a basic form, Google-sign-up demo, and callbacks to
/// notify its parent widget.
class SignupCard extends StatefulWidget {
  const SignupCard({
    Key? key,
    required this.onClose,
    required this.onSwitchToLogin,
  }) : super(key: key);

  bool isPasswordStrong(String password) {
    final passwordRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
    return passwordRegExp.hasMatch(password);
  }

  String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }


  /// Callback when the user closes the modal.
  /// Closes the modal.
  final VoidCallback onClose;

  /// Switches the modal to the login card.
  final VoidCallback onSwitchToLogin;

  @override
  State<SignupCard> createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  final _usernameC = TextEditingController();
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();
  final _confirmC = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  // ---------------------------------------------------------------------------
  // Google sign-up demo
  // ---------------------------------------------------------------------------
  Future<void> _handleGoogleSignUp() async {
    try {
      final acc = await GoogleSignIn().signIn();
      if (acc != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signed up as ${acc.displayName}')),
        );
        widget.onClose();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Google sign-up failed: $e')));
    }
  }

  // ---------------------------------------------------------------------------
  // housekeeping
  // ---------------------------------------------------------------------------
  @override
  void dispose() {
    _usernameC.dispose();
    _emailC.dispose();
    _passwordC.dispose();
    _confirmC.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // build
  // ---------------------------------------------------------------------------
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
            color: Colors.black.withOpacity(.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _inputField(
                  controller: _usernameC,
                  label: 'Username',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _inputField(
                  controller: _emailC,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboard: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _passwordField(
                  controller: _passwordC,
                  obscure: _obscurePassword,
                  label: 'Password',
                  toggle: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                const SizedBox(height: 16),
                _passwordField(
                  controller: _confirmC,
                  obscure: _obscureConfirm,
                  label: 'Confirm Password',
                  toggle: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                ),
                const SizedBox(height: 24),

                // Sign-up button
                ElevatedButton(
                  onPressed: _onSignUpPressed,
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

                // Google sign-up
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

                // Switch to login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
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

  // ---------------------------------------------------------------------------
  // sub-widgets
  // ---------------------------------------------------------------------------
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF667eea).withOpacity(.1),
            const Color(0xFF764ba2).withOpacity(.1),
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
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required bool obscure,
    required String label,
    required VoidCallback toggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: toggle,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // logic
  // ---------------------------------------------------------------------------
  void  _onSignUpPressed() async {
    final username = _usernameC.text;
    final email = _emailC.text;
    final password = _passwordC.text;
    final confirm = _confirmC.text;

    if (password != confirm) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    final available = await user_apis.UserApis.isUsernameAvailable(username);
    if (available) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username is already taken')),
      );
      return;
    }
    final hashedPassword = widget.hashPassword(password);

    try {
      final response = await user_apis.UserApis.registerUser(
        username: username,
        email: email,
        password: hashedPassword,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Signed up as $username ($email)')));
      widget.onClose();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }

  }
}
