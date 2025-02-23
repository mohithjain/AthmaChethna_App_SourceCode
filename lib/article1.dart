import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Article1Screen(),
    );
  }
}

class Article1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8EFE3),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8EFE3),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF6D4C41)), // Darker brown color for icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Article 1',
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
                'Benefits Of Meditation',
                style: TextStyle(
                  fontSize: 36, // Increased font size
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6D4C41), // Darker brown color for text
                ),
              ),
              SizedBox(height: 26),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/arti1A.jpg', // Replace with your image path
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Reduced Stress:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF6D4C41)), // Increased font size
                        ),
                        Text(
                          'Meditation helps lower cortisol levels, the hormone associated with stress, leading to a calmer mind and body.',
                          style: TextStyle(color: Color(0xFF6D4C41), fontSize: 18), // Increased font size
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Improved Focus and Concentration:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF6D4C41)), // Increased font size
                        ),
                        Text(
                          'Regular practice enhances the ability to concentrate and maintain attention on tasks.',
                          style: TextStyle(color: Color(0xFF6D4C41), fontSize: 18), // Increased font size
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Enhanced Emotional Health:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF6D4C41)), // Increased font size
                        ),
                        Text(
                          'It promotes a positive outlook on life and can help reduce symptoms of depression and anxiety.',
                          style: TextStyle(color: Color(0xFF6D4C41), fontSize: 18), // Increased font size
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Improved Focus and Concentration:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF6D4C41)), // Increased font size
                        ),
                        Text(
                          'Regular practice enhances the ability to concentrate and maintain attention on tasks.',
                          style: TextStyle(color: Color(0xFF6D4C41), fontSize: 18), // Increased font size
                        ),
                        SizedBox(height: 8),

                        Text(
                          'Greater Self-Awareness:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF6D4C41)), // Increased font size
                        ),
                        Text(
                          'Meditation encourages self-reflection and helps individuals understand their thoughts and behaviors better.',
                          style: TextStyle(color: Color(0xFF6D4C41), fontSize: 18), // Increased font size
                        ),
                        SizedBox(height: 8),
                        Image.asset(
                          'images/arti1B.jpg', // Replace with your image path
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Emotional Stability:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF6D4C41)), // Increased font size
                        ),
                        Text(
                          'It helps in regulating emotions, making it easier to respond to situations calmly rather than reactively.',
                          style: TextStyle(color: Color(0xFF6D4C41), fontSize: 18), // Increased font size
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
