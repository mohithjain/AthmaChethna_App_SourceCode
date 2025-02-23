import 'package:flutter/material.dart';
import 'dart:async';
import 'auth_screen.dart'; // ✅ Import Auth Screen
import 'login.dart';
import 'signup.dart';
import 'homescreen.dart';
import 'anxiety_quiz.dart';
import 'depression.dart';
import 'stress.dart';
import 'eating.dart';
import 'communication.dart';
import 'sleep.dart';
import 'article1.dart';
import 'article2.dart';
import 'todo.dart';

void main() {
  runApp(const MyApp()); // ✅ Start the app with MyApp()
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // ✅ Start with SplashScreen
      routes: {
        '/': (context) => const SplashScreen(), // ✅ Show SplashScreen first
        '/auth': (context) => const AuthScreen(), // ✅ Navigate to Auth Screen after splash
        '/login': (context) => const LoginScreen(), // ✅ Login Page Route
        '/signup': (context) => const CreateAccountPage(), // ✅ Sign Up Page Route
        '/homescreen': (context) => HomeScreen(),
        '/anxiety_quiz': (context) => AnxietySurveyPage(),
        '/depression': (context) => DepressionSurveyPage(),
        '/stress': (context) => StressSurveyPage(),
        '/eating': (context) => EatingHabitsSurveyPage(),
        '/communication': (context) => CommunicationSurveyPage(),
        '/sleep': (context) => SleepHygineSurveyPage(),
        '/article1': (context) => Article1Screen(), // Add route for Article 1
        '/article2': (context) => Article2Screen(),
        '/todo': (context) => ToDoScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _imageAnimation;
  late Animation<Offset> _textAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _imageAnimation = Tween<Offset>(
      begin: const Offset(0, -3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceOut));

    _textAnimation = Tween<Offset>(
      begin: const Offset(-3, 0),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });

    // ✅ Navigate to Auth Screen after 5 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/auth');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF6D89E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _imageAnimation,
              child: Image.asset(
                'images/logo.png',
                width: screenWidth * 0.5,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SlideTransition(
              position: _textAnimation,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Text(
                  'A versatile mental health app that\nbreathes new life into users.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.black,
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
