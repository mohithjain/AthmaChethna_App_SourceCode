import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Article2Screen(),
    );
  }
}

class Article2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8EFE3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF6D4C41)), // Darker brown color for icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Article 2',
          style: TextStyle(color: Color(0xFF6D4C41), fontWeight: FontWeight.bold, fontSize: 24), // Darker brown color for title
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Finding Joy In Everyday Moment',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6D4C41), // Darker brown color for text
                ),
              ),
              SizedBox(height: 26),
              Image.asset(
                'images/arti2.png', // Replace with the actual image path
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 25),
              Text(
                '• Spend time on hobbies and interests such as reading, painting, gardening, or playing a sport.\n'
                    '• Make time for activities that bring you pleasure and satisfaction.\n'
                    '• Focus on the present moment.\n'
                    '• Take deep, mindful breaths to ground yourself.\n'
                    '• Spend quality time with family and friends.\n'
                    '• Cherish interactions and engage in acts of kindness.\n'
                    '• Reframe challenges as opportunities for growth and learning.\n'
                    '• Cultivate an optimistic outlook.\n'
                    '• Savor a cup of tea or coffee.\n'
                    '• Listen to your favorite music or read a good book.',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF6D4C41), // Darker brown color for text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
