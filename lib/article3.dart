import 'package:flutter/material.dart';

class Article3Screen extends StatelessWidget {
  const Article3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120), // AppBar height
        child: AppBar(
          backgroundColor: Colors.brown,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 235, 210, 135)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end, // Move content to the bottom
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30), // Adjust bottom padding
                child: const Text(
                  "Tips For Boosting Immunity",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 235, 210, 135),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF2EDE5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'images/immunity_boosters.jpg',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              _buildSection(
                "Eat a Balanced Diet",
                [
                  "Include plenty of fruits and vegetables, which are rich in vitamins and minerals.",
                  "Incorporate whole grains, lean proteins, and healthy fats.",
                  "Consider foods rich in probiotics, like yogurt and fermented foods, to support gut health."
                ],
              ),
              _buildSection(
                "Stay Hydrated",
                [
                  "Drink plenty of water throughout the day.",
                  "Herbal teas and broths can also contribute to your hydration."
                ],
              ),
              _buildSection(
                "Get Regular Exercise",
                [
                  "Aim for at least 30 minutes of moderate exercise most days of the week.",
                  "Activities like walking, cycling, swimming, and yoga are beneficial."
                ],
              ),
              _buildSection(
                "Get Enough Sleep",
                [
                  "Aim for 7-9 hours of quality sleep each night.",
                  "Establish a regular sleep schedule and create a restful environment."
                ],
              ),
              _buildSection(
                "Manage Stress",
                [
                  "Practice stress-reducing techniques like mindfulness, meditation, and deep breathing exercises.",
                  "Engage in activities that relax and rejuvenate you, such as hobbies and spending time in nature."
                ],
              ),
              _buildSection(
                "Maintain Good Hygiene",
                [
                  "Wash your hands regularly with soap and water.",
                  "Avoid touching your face, especially your eyes, nose, and mouth."
                ],
              ),
            ],
          ),
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
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          ...points.map(
            (point) => Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "• ",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
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
