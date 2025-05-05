import 'package:flutter/material.dart';

class JoyOfLearningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                "Joy Of Learning \nNew Habbits & Interest",
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
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageTextRow(
              context,
              imagePath: 'images/art9A.jpg',
              title: "Skill Enhancement",
              points: [
                "New habits and interests can lead to the development of valuable skills.",
                "These skills can enhance your career prospects and personal capabilities."
              ],
              isImageLeft: true,
            ),
            _buildImageTextRow(
              context,
              imagePath: 'images/art9B.jpg',
              title: "Diverse Experiences",
              points: [
                "Exploring different activities broadens your experiences and perspectives.",
                "This diversity enriches your life and provides a well-rounded outlook."
              ],
              isImageLeft: false,
            ),
            _buildImageTextRow(
              context,
              imagePath: 'images/art9C.jpg',
              title: "Overcoming Fear of Failure",
              points: [
                "Trying new activities helps you become comfortable with failure.",
                "This resilience improves your approach to challenges in life."
              ],
              isImageLeft: true,
            ),
            _buildSection(
              "Rediscovering Play",
              [
                "Engaging in new hobbies can bring back a sense of joy and fun often lost in adulthood.",
                "The sheer enjoyment of learning something new can be a significant source of joy."
              ],
            ),
            _buildSection(
              "Finding Purpose",
              [
                "Pursuing a new passion that brings discovery and satisfaction.",
                "Merging hobbies with life goals can make life more enjoyable and fulfilling."
              ],
            ),
            _buildSection(
              "Flexibility and Open-Mindedness",
              [
                "Learning new things encourages adaptability and openness to change.",
                "It can also make you more resilient in the face of life challenges."
              ],
            ),
            _buildSection(
              "Goal Setting and Achievement",
              [
                "Setting and achieving goals related to hobbies or interests provides a sense of achievement.",
                "This can boost your self-esteem and provide a sense of meaning."
              ],
            ),
            _buildSection(
              "Personal Fulfillment",
              [
                "Pursuing interests and hobbies that resonate with you can lead to a deeper sense of engagement.",
                "Activities that align with your passions can enhance overall well-being."
              ],
            ),
            _buildSection(
              "Creative Expression",
              [
                "Engaging in creative hobbies like painting, writing, or playing an instrument allows for personal expression.",
                "These outlets can be therapeutic and provide a sense of joy and fulfillment."
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageTextRow(BuildContext context, {required String imagePath, required String title, required List<String> points, required bool isImageLeft}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isImageLeft)
            Expanded(
              flex: 6,
              child: Image.asset(imagePath, height: 250, fit: BoxFit.cover),
            ),
          SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: _buildSection(title, points),
          ),
          if (!isImageLeft)
            Expanded(
              flex: 6,
              child: Image.asset(imagePath, height: 250, fit: BoxFit.cover),
            ),
        ],
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
          SizedBox(height: 15),
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
