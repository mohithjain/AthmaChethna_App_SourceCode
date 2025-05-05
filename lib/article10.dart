import 'package:flutter/material.dart';

class ConnectingTipsScreen extends StatelessWidget {
  const ConnectingTipsScreen({super.key});

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
                "How Exercise Improves\n the Outlook of Your Life",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06, // Now screenWidth is defined
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
      ),// Light grey background
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFFF2EDE5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Maintaining strong connections with friends and family is essential for our well-being.\n\nHere are some practical tips to help you stay connected:",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                _buildSection(
                  "Schedule Regular Catch-Ups",
                  "Set a recurring time for catch-ups, like weekly video calls or monthly dinners, to keep your relationships strong.",
                ),
                _buildSection(
                  "Share Life Updates",
                  "Keep loved ones informed by sharing photos, videos, and stories through social media, family albums, or group chats.",
                ),
                _buildSection(
                  "Plan Activities Together",
                  "Organize activities like game nights, virtual movie nights, or collaborative projects to create shared memories.",
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'images/art10.jpg', // Replace with your image path
                    width: double.infinity,
                    height: 280,
                    fit: BoxFit.cover,
                  ),
                ),
                _buildSection(
                  "Listen Actively",
                  "Show genuine interest in others’ lives by listening more than you speak, asking questions, and being empathetic.",
                ),
                _buildSection(
                  "Celebrate Milestones",
                  "Remember birthdays and anniversaries with cards, gifts, or messages to show you care.",
                ),
                _buildSection(
                  "Send Handwritten Letters",
                  "A handwritten letter or postcard can be a cherished gesture, showing that you’ve taken the time to think about someone.",
                ),
                _buildSection(
                  "Practice Gratitude",
                  "Regularly express gratitude for the people in your life to foster deeper connections.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
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
          Text(
            content,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
