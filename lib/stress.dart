import 'package:flutter/material.dart';

class StressSurveyPage extends StatefulWidget {
  const StressSurveyPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StressSurveyPageState createState() => _StressSurveyPageState();
}

class _StressSurveyPageState extends State<StressSurveyPage> {
  final List<String> questions = [
    '1. How often do you feel overwhelmed by your responsibilities?',
    '2. Do you find it difficult to relax after a stressful day?',
    '3. How often do you have trouble sleeping due to stress?',
    '4. How often do you use substances like alcohol or drugs to cope with stress?',
    '5. How often do you feel fatigued or exhausted due to stress?',
    '6. Do you have frequent mood swings when under stress?',
    '7. How often do you feel isolated or withdrawn due to stress?',
    '8. Do you feel a sense of panic or impending doom when stressed?',
    '9. How often do you experience heart palpitations or a racing heart when stressed?',
    '10.How often do you feel like you are losing control or going to "lose it" when stressed?',
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
      Navigator.pushNamed(context, '/homescreen');

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
        title: Text('Stress'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Center(
            child: Image.asset('images/stress.png', height: 150),
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

