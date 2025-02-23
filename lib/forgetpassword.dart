import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'emailverify.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@bmsce\.ac\.in$").hasMatch(value)) {
      return "Enter a valid BMSCE email (@bmsce.ac.in)";
    }
    return null;
  }

 void _recoverPassword() {
  if (_formKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Password recovery email sent!")),
    );

    // Navigate to EmailVerifyPage after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmailVerificationPage()),
      );
    });
  }
}


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFCEBCB),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: WaveClipperOne(),
                      child: Container(
                        height: screenHeight * 0.25,
                        width: double.infinity,
                        color: Colors.brown,
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 10,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: const Color(0xFFF6D89E)),
                        onPressed: () {},
                      ),
                    ),
                    Positioned(
                      top: 110,  // Lowered the text by increasing top padding
                      left: 0,
                      right: 0,
                      child: const Center(
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: const Color(0xFFF6D89E),
                            fontSize: 32, // Increased font size from 22 to 26
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.1),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Mail Address Here",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Enter the email address associated\nwith your account.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                            hintText: "example@bmsce.ac.in",
                            filled: true,
                            fillColor: const Color(0xFFF6D89E),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                          onPressed: _recoverPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Recover Password",
                            style: TextStyle(fontSize: 16, color: const Color(0xFFF6D89E)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
