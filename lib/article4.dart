import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MantraOfSuccessPage(),
    );
  }
}

class MantraOfSuccessPage extends StatelessWidget {
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
                "Mantra of Success",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "The mantra for success can vary from person to person, but some universal principles can guide you towards achieving your goals and finding fulfillment.",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 10),

            // Row for Text & Image
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expanded text section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSectionTitle('Set Clear Goals'),
                      buildBulletPoint('Define Your Vision:', 'Have a clear understanding of what you want to achieve.'),
                      buildBulletPoint('Break Down Goals:', 'Divide your main goal into smaller, manageable tasks.'),
                      buildBulletPoint('Track Your Progress:', 'Regularly review and adjust your goals to stay on track.'),
                      
                    ],
                  ),
                ),

                // Image on the right
                SizedBox(width: 10), // Spacing
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'images/mos.jpg',
                    height: 300,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            buildSectionTitle('Take Consistent Action'),
            buildBulletPoint('Be Proactive:', 'Take initiative and don’t wait for opportunities to come to you.'),
            buildBulletPoint('Stay Disciplined:', 'Commit to working on your goals regularly, even when motivation wanes.'),
            
            SizedBox(height: 20),
            buildSectionTitle('Stay Focused and Avoid Distractions'),
            buildBulletPoint('Limit Distractions:', 'Create an environment that supports your focus and productivity.'),
            buildBulletPoint('Stay Committed:', 'Keep your eyes on your goals and avoid getting sidetracked.'),
            
            SizedBox(height: 20),
            buildSectionTitle('Maintain a Positive Mindset'),
            buildBulletPoint('Believe in Yourself:', 'Have confidence in your abilities and stay optimistic.'),
            buildBulletPoint('Stay Resilient:', 'Keep pushing forward despite obstacles and challenges.'),
            
            SizedBox(height: 20),
            buildSectionTitle('Time Management'),
            buildBulletPoint('Use your time effectively by prioritizing tasks and avoiding procrastination.', ''),
            
            SizedBox(height: 20),
            buildSectionTitle('Healthy Lifestyle'),
            buildBulletPoint('Maintain a healthy body and mind through regular exercise, proper nutrition, and sufficient rest.', ''),
            
            SizedBox(height: 20),
            buildSectionTitle('Build Strong Relationships'),
            buildBulletPoint('Network Effectively:', 'Connect with people who inspire you and can help you grow.'),
            buildBulletPoint('Support and Collaborate:', 'Help others achieve their goals and be open to collaboration.'),
            
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF6D4C41),
      ),
    );
  }

  Widget buildBulletPoint(String boldText, String normalText) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16, color: Colors.black87)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black87),
                children: [
                  TextSpan(text: boldText, style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' $normalText'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}