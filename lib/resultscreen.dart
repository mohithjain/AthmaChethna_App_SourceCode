import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final bool needsCounselor;

  const ResultScreen({required this.needsCounselor, super.key});

  void _navigateToChatbot(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/chatbot');
  }

  void _navigateToBookAppointment(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/counselling');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF2EDE5),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'Assessment Result',
          style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.06),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1),
            // Use Image.asset instead of Icon
            Image.asset(
              needsCounselor ? 'images/result2.png' : 'images/result1.png',
              width: screenWidth * 0.6, // Match the size of the previous icon
              height: screenWidth * 0.4, // Match the size of the previous icon
              fit: BoxFit.contain, // Ensures the image fits within the specified dimensions
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              needsCounselor
                  ? 'You May Benefit from Meeting a Counselor'
                  : 'You May Not Need to Meet a Counselor Right Now',
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'Based on your responses, here are your options:',
              style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.04),
            ElevatedButton(
              onPressed: () => _navigateToChatbot(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Continue to Chatbot',
                style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () => _navigateToBookAppointment(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Consult Counselor',
                style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}