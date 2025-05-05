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
      backgroundColor: Color(0xFFF2EDE5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), // Increased height
        child: AppBar(
          backgroundColor: Colors.brown,
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter, // Moves the title downward
            child: Padding(
              padding: EdgeInsets.only(bottom: 30), // Adjust this value as needed
              child: Text(
                "Benefits Of Meditation",
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
