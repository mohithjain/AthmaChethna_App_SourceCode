import 'package:flutter/material.dart';


class SleepHygineSurveyPage extends StatefulWidget {
  @override
  _SleepHyginePageState createState() => _SleepHyginePageState();
}

class _SleepHyginePageState extends State<SleepHygineSurveyPage> {
  final List<String> questions = [
    '1. How often do you go to bed and wake up at the same time every day, including weekends?',
    '2. How often do you consume caffeine or other stimulants after 2 PM?',
    '3. Do you find it difficult to fall asleep or stay asleep?',
    '4. Do you have a relaxing bedtime routine to wind down before sleep?',
    '5. Do you keep your bedroom dark, quiet, and cool at night?',
    '6. How often do you find yourself staying in bed even when you cannot sleep?',
    '7. How often do you feel stressed or anxious about sleep?',
    '8. How often do you lie awake worrying about not getting enough sleep?',
    '9. How often do you get at least 7-8 hours of sleep per night?',
    '10.Do you consume alcohol or tobacco close to bedtime?',
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
          onPressed: () { Navigator.pop(context);},
        ),
        title: Text('SleepHygine'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Center(
            child: Image.asset('images/sleep.png', height: 200),
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
