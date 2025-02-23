import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'signupverify.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _selectedSem;

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFCEBCB),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5, // Set opacity to 10%
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bkg1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  _buildTabBar(),
                  _buildSlider(),
                  const SizedBox(height: 10),
                  const Text(
                    "Start Your Journey",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cursive",
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildForm(screenWidth),
                  const SizedBox(height: 20),
                  _buildContinueButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
              ),
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

  Widget _buildForm(double screenWidth) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(nameController, "Name", TextInputType.name, (value) {
            if (value!.isEmpty) return "Name is required";
            if (!RegExp(r"^[A-Za-z ]+$").hasMatch(value)) return "Enter only alphabets";
            return null;
          }),
          _buildTextField(usernameController, "Username", TextInputType.text, (value) {
            if (value!.isEmpty) return "Username is required";
            if (!RegExp(r"^[A-Za-z0-9]+$").hasMatch(value)) return "Use only letters and numbers";
            return null;
          }),
          _buildPasswordField(),
          _buildConfirmPasswordField(),
          _buildDropdownField(),
          _buildEmailField(),
          _buildTextField(departmentController, "Department", TextInputType.text, (value) {
            return value!.isNotEmpty ? null : "Department is required";
          }),
          _buildTextField(phoneController, "Phone Number", TextInputType.phone, (value) {
            if (value!.isEmpty) return "Phone number is required";
            if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) return "Enter a valid 10-digit number";
            return null;
          }),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, TextInputType keyboardType, String? Function(String?) validator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: _buildTransparentInputDecoration(label),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done, // Prevents extra toolbar
        toolbarOptions: const ToolbarOptions(
        copy: false,
        cut: false,
        paste: false,
        selectAll: false,
        ),

        controller: passwordController,
        obscureText: !_isPasswordVisible,
        validator: (value) {
          if (value!.isEmpty) return "Password is required";
          if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
            return "Weak password: Use uppercase, number, special char";
          }
          return null;
        },
        decoration: _buildTransparentInputDecoration("Password").copyWith(
          suffixIcon: IconButton(
            icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: confirmPasswordController,
        obscureText: !_isConfirmPasswordVisible,
        validator: (value) {
          if (value!.isEmpty) return "Confirm your password";
          if (value != passwordController.text) return "Passwords do not match";
          return null;
        },
        decoration: _buildTransparentInputDecoration("Confirm Password").copyWith(
          suffixIcon: IconButton(
            icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

Widget _buildDropdownField() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: DropdownButtonFormField<String>(
      value: _selectedSem,
      decoration: _buildTransparentInputDecoration("Semester"), // Matching other fields
      items: List.generate(8, (index) {
        return DropdownMenuItem(
          value: "${index + 1}",
          child: Text(
            "${index + 1}", // Only numbers displayed
            style: const TextStyle(fontSize: 16), // Match text size
          ),
        );
      }),
      onChanged: (value) {
        setState(() {
          _selectedSem = value;
        });
      },
      validator: (value) => value == null ? "Select a semester" : null,
      dropdownColor: const Color(0xFFFCEBCB), // Match background color
      menuMaxHeight: 150, // Compact dropdown height
    ),
  );
}


  Widget _buildEmailField() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      controller: emailController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email prefix is required";
        }
        if (!RegExp(r"^[a-zA-Z0-9.]+$").hasMatch(value)) {
          return "Only letters, numbers, and dots allowed";
        }
        return null;
      },
      decoration: _buildTransparentInputDecoration("Email ").copyWith(
        suffixText: "@bmsce.ac.in",
      ),
    ),
  );
}


  InputDecoration _buildTransparentInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: UnderlineInputBorder(),
    );
  }

  Widget _buildContinueButton() {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 102, 76, 68),
    ),
    onPressed: () {
      if (_formKey.currentState!.validate()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EmailVerificationPage()), // Navigate to congo.dart
        );
      }
    },
    child: const Text(
      "Continue",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 43, 42, 42)),
    ),
  );
}

}