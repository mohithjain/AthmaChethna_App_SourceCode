import 'package:flutter/material.dart';
import 'dart:async';

class CongoScreen extends StatefulWidget {
  @override
  _CongoScreenState createState() => _CongoScreenState();
}

class _CongoScreenState extends State<CongoScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/login'); // 5 sec ke baad login page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6D89E), // Same as image
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/congo.png", height: 350), // Ensure image is in assets
            SizedBox(height: 40),
            Text(
              "Welcome to the SoulEase Family!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "💛",
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 15),
            Text(
              "We’re so glad to have you with us—\nlet’s grow, heal, and thrive together!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            
          ],
        ),
      ),
    );
  }
}
