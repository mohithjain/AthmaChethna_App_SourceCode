import 'package:flutter/material.dart';

class DepressionSurveyPage extends StatefulWidget {
  const DepressionSurveyPage({super.key});
  @override
  _DepressionPageState createState() => _DepressionPageState();
}

class _DepressionPageState extends State<DepressionSurveyPage> {
  final List<String> questions = [
    '1. How often do you feel sad or down for most of the day?',
    '2. Do you find it difficult to enjoy activities that you used to find pleasurable?',
    '3. In the past two weeks, how often have you felt hopeless about the future?',
    '4. How often do you have trouble sleeping (insomnia) or sleep too much (hypersomnia)?',
    '5. How often do you feel worthless or excessively guilty?',
    '6. Do you find it hard to concentrate, think, or make decisions?',
    '7. How often do you find yourself crying without an apparent reason?',
    '8. How often do you feel like you are a burden to others?',
    '9. Do you frequently feel a sense of emptiness or numbness?',
    '10.How often do you withdraw from social activities or isolate yourself?',
  ];

  final List<double> sliderValues = List<double>.generate(10, (index) => 0);

  // ignore: unused_element
  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Submit Successful'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    // Perform any submission logic here

    // Show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Submit Successful'),
        duration: Duration(seconds: 2),
      ),
    );

    // Navigate to '/anxiety_quiz' after SnackBar is shown
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushNamed(context, '/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Depression'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Center(
            child: Image.asset('images/depression.jpg', height: 150),
          ),
          SizedBox(height: 16.0),
          ...questions.asMap().entries.map((entry) {
            int idx = entry.key;
            String question = entry.value;
            return buildQuestionCard(question, idx);
          }).toList(),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _submitForm(context);
            },
            // ignore: sort_child_properties_last
            child: Text(
              'SUBMIT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuestionCard(String question, int idx) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                thumbColor: Colors.brown,
                activeTrackColor: Colors.brown,
                inactiveTrackColor: Colors.brown[100],
                overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                overlayColor: Colors.brown.withOpacity(0.2),
                tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 7),
                activeTickMarkColor: Colors.brown,
                inactiveTickMarkColor: Colors.brown,
              ),
              child: Slider(
                value: sliderValues[idx],
                min: 0,
                max: 3,
                divisions: 3,
                onChanged: (value) {
                  setState(() {
                    sliderValues[idx] = value;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildLabel('Never', idx, 0),
                buildLabel('Rarely', idx, 1),
                buildLabel('Often', idx, 2),
                buildLabel('Always', idx, 3),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(String label, int questionIdx, int value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          sliderValues[questionIdx] = value.toDouble();
        });
      },
      child: Column(
        children: [
          SizedBox(height: 4), // Reduced height to decrease space
          Text(label),
        ],
      ),
    );
  }
}

