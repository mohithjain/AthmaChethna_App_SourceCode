import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isPasswordStrong(String password) {
    final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
    return passwordRegex.hasMatch(password);
  }

  void _continue() {
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    setState(() {
      _passwordError = null;
      _confirmPasswordError = null;

      if (!_isPasswordStrong(password)) {
        _passwordError = 'Password must be at least 8 characters long and include a letter, number, and special character.';
      } else if (password != confirmPassword) {
        _confirmPasswordError = 'Passwords do not match!';
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successfully!')),
        );
        _passwordController.clear();
        _confirmPasswordController.clear();
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/login');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: TopWaveClipper(),
                  child: Container(
                    height: screenHeight * 0.25,
                    color: Colors.brown,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: const Color(0xFFFCEBCB)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: const Center(
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        color: const Color(0xFFFCEBCB),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
            const Text(
              'Enter New Password',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                'Your new password must be at least 8 characters long and include a letter, number, and special character.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  errorText: _passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  errorText: _confirmPasswordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: const Color(0xFFFCEBCB), fontSize: 26),
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

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 4, size.height,
      size.width / 2, size.height - 40,
    );
    path.quadraticBezierTo(
      size.width * 3 / 4, size.height - 80,
      size.width, size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
