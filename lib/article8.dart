import 'package:flutter/material.dart';

class OutdoorMoodScreen extends StatelessWidget {
  const OutdoorMoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160), // AppBar height
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
                  "How Spending Time Outdoors\n Can Boost Your Mood",
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
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                "Reduces Stress",
                "Natural settings help reduce stress levels by lowering cortisol, the body’s primary stress hormone. The calming effect of nature can help you relax and unwind.",
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'images/article8.jpg',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              _buildSection(
                "Improves Mental Clarity",
                "Being in nature can enhance your cognitive functions, improving focus and clarity. This mental reset can lead to better problem-solving and creativity.",
              ),
              _buildSection(
                "Boosts Physical Health",
                "Physical activities like walking, hiking, or cycling in nature increase endorphins, the body’s feel-good hormones, which naturally elevate your mood.",
              ),
              _buildSection(
                "Enhances Mood Through Sunlight",
                "Exposure to sunlight boosts serotonin levels, a hormone associated with improved mood and feelings of well-being. It can also help regulate your sleep-wake cycles.",
              ),
              _buildSection(
                "Promotes Social Interaction",
                "Outdoor activities often involve social interactions, whether it’s a group hike or a simple chat with fellow park-goers. These interactions can improve your mood and sense of connection.",
              ),
              _buildSection(
                "Increases Mindfulness",
                "Nature encourages mindfulness by helping you stay present. The sights, sounds, and smells of the outdoors can ground you in the moment, reducing anxiety and improving overall mood.",
              ),
              _buildSection(
                "Improves Emotional Resilience",
                "Regular exposure to nature can increase your emotional resilience, helping you better manage and recover from stress and adversity.",
              ),
            ],
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
