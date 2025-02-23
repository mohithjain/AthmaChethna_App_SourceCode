import 'package:flutter/material.dart';
import 'login.dart';  // Import Login Screen
import 'signup.dart'; // Import Signup Screen

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Background Image (Full Screen)
          Image.asset(
            'images/auth_background.png',
            fit: BoxFit.cover,
          ),

          // ✅ Buttons
          Positioned(
            bottom: screenHeight * 0.08,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: Column(
              children: [
                // ✅ Login Button
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.065,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  LoginScreen()),
                      );
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                // ✅ Signup Button
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.065,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CreateAccountPage()),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
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