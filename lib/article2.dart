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
      backgroundColor: Color(0xFFF2EDE5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160), // Increased height
        child: AppBar(
          backgroundColor: Colors.brown,
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter, // Moves the title downward
            child: Padding(
              padding: EdgeInsets.only(bottom: 30), // Adjust this value as needed
              child: Text(
                "Finding Joy In Everyday Moment",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 246, 223, 153),
                ),
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 246, 223, 153)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
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
