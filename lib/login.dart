import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'forgetpassword.dart'; // ForgetPassword page import kiya hai
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEBCB),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildBackground(),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTabBar(),
                _buildSlider(),
                const SizedBox(height: 30),
                _buildMotivationalText(),
                const SizedBox(height: 30),
                _buildForm(),
                const SizedBox(height: 25),
                _buildLoginButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Opacity(
      opacity: 0.5,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bkg1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 105, 76, 67),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Login",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/signup');
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: Container(
        height: 4,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildMotivationalText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        "There is a hope, even when your brain tells you there isn't",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.italic,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(usernameController, "Username", TextInputType.text, "Username is required"),
          _buildTextField(phoneController, "Phone Number", TextInputType.phone, "Enter a valid 10-digit number", phoneValidation: true),
          _buildTextField(emailController, "Email", TextInputType.emailAddress, "Only @bmsce.ac.in emails allowed", emailValidation: true),
          _buildPasswordField(),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, TextInputType keyboardType, String errorMessage, {bool phoneValidation = false, bool emailValidation = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) return errorMessage;
          if (phoneValidation && !RegExp(r"^[0-9]{10}$").hasMatch(value)) return "Enter a valid 10-digit number";
          if (emailValidation && !RegExp(r"^[a-zA-Z0-9.]+@bmsce\.ac\.in$").hasMatch(value)) return errorMessage;
          return null;
        },
        decoration: _buildTransparentInputDecoration(label),
      ),
    );
  }

  Widget _buildPasswordField() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextFormField(
          controller: passwordController,
          obscureText: !_isPasswordVisible,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Password is required";
            }
            if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$')
                .hasMatch(value)) {
              return "Password must have at least 6 chars, a letter, a number, and a special char";
            }
            return null;
          },
          decoration: _buildTransparentInputDecoration("Password").copyWith(
            suffixIcon: IconButton(
              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
            );
          },
          child: const Text("Forgot Password?", style: TextStyle(color: Colors.black)),
        ),
      ],
    ),
  );
}


  InputDecoration _buildTransparentInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      border: const UnderlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 102, 76, 68),
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Fluttertoast.showToast(msg: "Logged in successfully!");
          Navigator.pushNamed(context, '/homescreen');
        }
      },
      child: const Text("Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}
