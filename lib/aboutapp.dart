import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[600], // Matches your app's theme
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'About App',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF795548), // Matches your specified gradient
              Color(0xFFFCEBCB), // Matches your specified gradient
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo with image (replace with your image asset)
              Container(
                padding: EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor:
                      Colors
                          .transparent, // No background color needed if using an image
                  backgroundImage: AssetImage(
                    'images/logo.png',
                  ), // Replace with your logo path
                ),
              ),
              SizedBox(height: 10),
              // App Title
              Text(
                'Atma Chetana – Your Mental Wellness Companion',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:
                      Colors
                          .black, // Changed to white for better contrast with the new gradient
                  letterSpacing: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              // Description
              Text(
                'Atma Chetna is an AI-powered mental health app designed to nurture your emotional well-being and bring peace to your mind. Track your mood, chat with our compassionate AI chatbot, take insightful assessments, and embark on a transformative journey toward mental harmony.',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color:
                      Colors
                          .black, // Adjusted for better readability on the new gradient
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              // Motto with star icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 26),
                  SizedBox(width: 8),
                  Text(
                    'Our Motto',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.black, // Changed to white for better contrast
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.star, color: Colors.yellow, size: 26),
                ],
              ),
              SizedBox(height: 12),
              Text(
                '“Your mental well-being matters. Let’s heal, grow, and thrive together!”',
                style: GoogleFonts.lora(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black, // Adjusted for better readability
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              // Key Features Section
              Text(
                'Key Features',
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Changed to white for better contrast
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              // Feature List with Icons
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeatureItem(
                    icon: Icons.favorite,
                    text: 'AI Chatbot for Emotional Support',
                  ),
                  _buildFeatureItem(
                    icon: Icons.mood,
                    text: 'Mood Tracking & Analysis',
                  ),
                  _buildFeatureItem(
                    icon: Icons.assessment,
                    text: 'Mental Health Assessments',
                  ),
                  _buildFeatureItem(
                    icon: Icons.lightbulb,
                    text: 'Daily Motivational Quotes & Reminders',
                  ),
                  _buildFeatureItem(
                    icon: Icons.calendar_today,
                    text: 'Counselor Appointment Scheduling',
                  ),
                ],
              ),
              SizedBox(height: 32),
              // Copyright Section (replacing "Get Started Now" button)
              Text(
                '@copyright AtmaChetna 2025. All rights reserved. This app is for personal use only; its contents are protected and may not be reproduced or distributed without permission.',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: Colors.black,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.brown,
            size: 24,
          ), // Changed to white for better contrast
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.black, // Adjusted for better readability
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
