import 'package:flutter/material.dart';

class HelpingOthersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                "How Helping Others\nEnrich Your Life",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
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
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02), // Added spacing
            _buildSection("Boosts Happiness",
                "Acts of kindness trigger the release of endorphins, often called the 'helper’s high.' This natural mood booster increases happiness and reduces stress.",
                screenWidth),
            _buildSectionWithRightImage(
                "Strengthens Connections",
                "Helping others fosters a sense of community and builds stronger relationships. It can lead to new friendships and deeper bonds with existing ones.",
                'images/helping.jpg',
                screenWidth,
                screenHeight),
            _buildSection("Increases Gratitude",
                "Helping those in need can give you a fresh perspective on your own life, making you more appreciative of what you have.",
                screenWidth),
            _buildSection("Enhances Self-Esteem",
                "Knowing that your actions have made a positive impact can boost your confidence and sense of self-worth.",
                screenWidth),
            _buildSection("Promotes Physical Health",
                "Engaging in volunteer work or acts of kindness can improve physical health by reducing stress and promoting a more active lifestyle.",
                screenWidth),
            _buildSection("Provides a Sense of Purpose",
                "Helping others gives you a sense of purpose and fulfillment, contributing to overall life satisfaction.",
                screenWidth),
            _buildFullWidthImageSection(
                "Encourages Personal Growth",
                "By stepping out of your comfort zone to help others, you can learn new skills, gain new experiences, and grow as a person.",
                'images/helping2.jpg',
                screenWidth,
                screenHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            content,
            style: TextStyle(fontSize: screenWidth * 0.04),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionWithRightImage(
      String title, String content, String imagePath, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  content,
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              height: screenHeight * 0.3,
              width: screenWidth * 0.50,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullWidthImageSection(
      String title, String content, String imagePath, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            content,
            style: TextStyle(fontSize: screenWidth * 0.04),
          ),
          SizedBox(height: screenHeight * 0.02),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              width: screenWidth, // Full width
              height: screenHeight * 0.35, // Adjust height as needed
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
