import 'package:flutter/material.dart';

class ExerciseBenefitsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Define screenWidth

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
                "How Exercise Improves\n the Outlook of Your Life",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.06, // Now screenWidth is defined
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 235, 210, 135),
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
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
          

            // First Image on Left, Text on Right
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Image.asset('images/exerc1.jpg', height: 300, fit: BoxFit.cover),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 6,
                  child: _buildSection(
                    "Improved Fitness and Strength",
                    [
                      "Regular exercise strengthens muscles, improves cardiovascular health, and enhances overall physical fitness.",
                      "Increases muscular strength and endurance can boost confidence and self-esteem."
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            _buildSection(
              "Weight Management",
              [
                "Exercise helps maintain a healthy weight, reducing the risk of obesity and related health issues like diabetes and heart disease.",
                "Achieving and maintaining a healthy weight can improve body image."
              ],
            ),
            _buildSection(
              "Better Sleep",
              [
                "Physical activity promotes better sleep patterns and quality, helping you feel more rested and energetic.",
                "Improved sleep contributes to better mood and cognitive function."
              ],
            ),
            SizedBox(height: 20),

            // Second Image on Right, Text on Left
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: _buildSection(
                    "Reduced Stress and Anxiety",
                    [
                      "Exercise reduces levels of the body's stress hormones, such as cortisol.",
                      "Physical activity stimulates the production of endorphins, chemicals in the brain that act as natural painkillers and mood elevators."
                    ],
                  ),
                ),
                SizedBox(width: 0),
                Expanded(
                  flex: 6,
                  child: Image.asset('images/exerc.jpg', height: 300, fit: BoxFit.cover),
                ),
              ],
            ),

            SizedBox(height: 20),
            _buildSection(
              "Enhanced Mood",
              [
                "Regular exercise can help alleviate symptoms of depression and anxiety, leading to a more positive outlook on life.",
                "Activities like running, swimming, and yoga promote mental relaxation and a sense of well-being."
              ],
            ),
            _buildSection(
              "Improved Cognitive Function",
              [
                "Exercise enhances brain function, improving memory, attention, and processing speed.",
                "Physical activity can reduce the risk of cognitive decline as you age."
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> points) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          SizedBox(height: 5),
          ...points.map(
            (point) => Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("• ", style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Text(
                      point,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
