import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoalsPage(),
    );
  }
}

class GoalsPage extends StatelessWidget {
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
              padding: EdgeInsets.only(bottom: 15), // Adjust this value as needed
              child: Text(
                "Setting And Achieving\nPersonal Goals",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06, // Now screenWidth is defined
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

            // Image on top
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'images/goals.jpg', // Change as per your file location
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 10),

            buildSectionTitle('Reflect on Your Values and Priorities'),
            buildBulletPoint(
                'Identify what matters most to you in life, including your values, passions, and long-term aspirations.'),
            buildBulletPoint(
                'Consider how your goals align with these values and priorities.'),

            buildSectionTitle('Define Clear and Specific Goals'),
            buildBulletPoint(
                'Make your goals specific, measurable, achievable, relevant, and time-bound (SMART).'),
            buildBulletPoint(
                'Clearly define what you want to accomplish, why it’s important to you, and how you will measure success.'),

            buildSectionTitle('Break Down Your Goals'),
            buildBulletPoint(
                'Divide larger goals into smaller, actionable steps or milestones.'),
            buildBulletPoint(
                'Breaking down goals into manageable tasks makes them less overwhelming and increases your chances of success.'),

            buildSectionTitle('Create a Plan of Action'),
            buildBulletPoint(
                'Develop a detailed plan outlining the steps you need to take to achieve each goal.'),
            buildBulletPoint(
                'Set deadlines for each milestone to keep yourself accountable and on track.'),

            buildSectionTitle('Stay Motivated'),
            buildBulletPoint(
                'Connect emotionally with your goals by reminding yourself of the reasons behind them.'),
            buildBulletPoint(
                'Visualize your success and the positive outcomes associated with achieving your goals.'),

            buildSectionTitle('Track Your Progress'),
            buildBulletPoint(
                'Regularly monitor your progress towards your goals.'),
            buildBulletPoint(
                'Keep a journal or use apps to track your accomplishments, setbacks, and lessons learned.'),

            buildSectionTitle('Seek Support'),
            buildBulletPoint(
                'Share your goals with supportive friends, family members, or mentors.'),
            buildBulletPoint(
                'Surround yourself with people who encourage and inspire you to stay committed to your goals.'),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF6D4C41),
        ),
      ),
    );
  }

  Widget buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16, color: Colors.black87)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}